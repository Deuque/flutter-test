part of 'task_modify_cubit.dart';

class TaskModifyState extends Equatable {
  final Task? toBeModified;
  final String? taskModifyError;
  final String? taskModifySuccess;

  TaskModifyState(
      {this.toBeModified, this.taskModifyError, this.taskModifySuccess});

  TaskModifyState modifyingTask(Task? task) =>
      TaskModifyState(toBeModified: task);

  TaskModifyState modifyingTaskError(String error) =>
      TaskModifyState(taskModifyError: error);

  TaskModifyState modifyingTaskSuccess(String message) =>
      TaskModifyState(taskModifySuccess: message);

  @override
  List<Object> get props =>
      [toBeModified ?? Task(), taskModifyError ?? '', taskModifySuccess ?? ''];
}
