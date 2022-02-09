
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:morphosis_flutter_demo/non_ui/model/task.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/task/task_manager_impl.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskManagerImpl taskManagerImpl;

  TaskCubit(this.taskManagerImpl) : super(TaskState());

  void fetchTasks() async {
    emit(state.copyWith(loading: true));
    final tasksAsync = await taskManagerImpl.fetchTasks();
    if (tasksAsync.hasError) {
      emit(state.copyWith(error: tasksAsync.error.toString()));
    } else {
      final tasks = tasksAsync.value;
      tasks!.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      emit(state.withValue(tasks));
    }
  }

  void addTaskToList(Task task) {
    final tasks = <Task>[task, ...state.allTasks ?? []];
    emit(state.copyWith(allTasks: tasks));
  }

  void updateTaskInList(Task task) {
    final tasks = state.allTasks ?? [];
    tasks.removeWhere((element) => element.id == task.id);
    final newTasks = <Task>[task, ...tasks];
    emit(state.copyWith(allTasks: newTasks));
  }
}
