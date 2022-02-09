part of 'task_cubit.dart';

class TaskState extends Equatable {
  final List<Task>? allTasks;
  final List<Task>? completedTasks;
  final bool loading;
  final String? error;

  TaskState({this.allTasks, this.loading = false, this.error})
      : completedTasks =
            allTasks?.where((element) => element.isCompleted).toList();

  TaskState copyWith({List<Task>? allTasks, bool? loading, String? error}) =>
      TaskState(
          allTasks: allTasks ?? this.allTasks,
          loading: loading ?? this.loading,
          error: error ?? this.error);

  TaskState withValue(List<Task> allTasks) => TaskState(
        allTasks: allTasks,
      );

  @override
  List<Object> get props => [allTasks ?? [],completedTasks??[], loading, error ?? ''];
}
