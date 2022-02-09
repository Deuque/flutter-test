import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:morphosis_flutter_demo/non_ui/bloc/task_cubit.dart';
import 'package:morphosis_flutter_demo/non_ui/locator/locator.dart';
import 'package:morphosis_flutter_demo/non_ui/model/task.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/task/task_manager_impl.dart';

part 'task_modify_state.dart';

class TaskModifyCubit extends Cubit<TaskModifyState> {
  final TaskManagerImpl taskManagerImpl;

  TaskModifyCubit(this.taskManagerImpl) : super(TaskModifyState());

  TaskCubit get taskCubit => locator<TaskCubit>();

  void addTask(Task task) async {
    emit(state.modifyingTask(task));
    final stringAsync = await taskManagerImpl.addTask(task);
    if (stringAsync.hasError) {
      emit(state.modifyingTaskError(stringAsync.error.toString()));
    } else {
      final id = stringAsync.value!;
      task = task..id = id;
      taskCubit.addTaskToList(task);
      emit(state.modifyingTaskSuccess('Task added successfully'));
    }
  }

  void updateTask(Task task) async {
    emit(state.modifyingTask(task));
    final stringAsync = await taskManagerImpl.updateTask(task);
    if (stringAsync.hasError) {
      emit(state.modifyingTaskError(stringAsync.error.toString()));
    } else {
      taskCubit.updateTaskInList(task);
      emit(state.modifyingTaskSuccess('Task updated successfully'));
    }
  }
}
