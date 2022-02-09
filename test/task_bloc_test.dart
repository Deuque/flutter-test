import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morphosis_flutter_demo/non_ui/bloc/task_cubit.dart';
import 'package:morphosis_flutter_demo/non_ui/bloc/task_modify_cubit.dart';
import 'package:morphosis_flutter_demo/non_ui/model/task.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/async_value.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/task/task_manager_impl.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/task/task_mock_manager.dart';

void main() {
  group('Task bloc test', () {
    late TaskManagerImpl taskManager;
    late TaskCubit taskCubit;
    late Task newTask;
    late Task updatedTask;
    setUp(() {
      taskManager = MockTaskManager();
      taskCubit = TaskCubit(taskManager);
      newTask = mockTasks[1]
        ..title = 'title'
        ..description = 'desc 3';
      updatedTask = mockTasks[0]..completedAt = DateTime.now();
    });

    blocTest<TaskCubit, TaskState>(
        'Tasks are filtered by creation time [created_at] when loaded',
        build: () {
          final response = Future.value(AsyncValue.withValue(mockTasks));
          when(() => taskManager.fetchTasks()).thenAnswer((_) => response);
          return taskCubit;
        },
        act: (bloc) => bloc.fetchTasks(),
        expect: () => [
              TaskState(loading: true),
              TaskState(
                allTasks: mockTasks,
                loading: false,
              )
            ],
        verify: (_) {
          verify(() => taskManager.fetchTasks()).called(1);
        });

    blocTest<TaskModifyCubit, TaskModifyState>('Tasks is added to top of list',
        build: () {
          final response = Future.value(AsyncValue.withValue('3'));
          when(() => taskManager.addTask(newTask)).thenAnswer((_) => response);
          return TaskModifyCubit(taskManager, taskCubit);
        },
        act: (bloc) => bloc.addTask(newTask),
        expect: () => [
              TaskModifyState(toBeModified: newTask),
              TaskModifyState(taskModifySuccess: '✅ Task added successfully')
            ],
        verify: (_) {
          expect(taskCubit.state.allTasks![0], newTask);
        });

    blocTest<TaskModifyCubit, TaskModifyState>('Tasks are updated in list',
        build: () {
          final response = Future.value(AsyncValue.withValue(true));
          when(() => taskManager.updateTask(updatedTask))
              .thenAnswer((_) => response);
          return TaskModifyCubit(taskManager, taskCubit);
        },
        act: (bloc) => bloc.updateTask(updatedTask),
        expect: () => [
              TaskModifyState(toBeModified: updatedTask),
              TaskModifyState(taskModifySuccess: '🔄 Task updated successfully')
            ],
        verify: (_) {
          expect(taskCubit.state.allTasks![0].isCompleted, true);
        });

    blocTest<TaskModifyCubit, TaskModifyState>(
      'Tasks are deleted from list',
      build: () {
        final response = Future.value(AsyncValue.withValue(true));
        when(() => taskManager.deleteTask(mockTasks[0]))
            .thenAnswer((_) => response);
        return TaskModifyCubit(taskManager, taskCubit);
      },
      act: (bloc) => bloc.deleteTask(mockTasks[0]),
      expect: () => [
        TaskModifyState(toBeModified: mockTasks[0]),
        TaskModifyState(taskModifySuccess: '❌ Task deleted successfully')
      ],
    );
  });
}
