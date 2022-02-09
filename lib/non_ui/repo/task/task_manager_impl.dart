import 'package:morphosis_flutter_demo/non_ui/model/task.dart';

import '../async_value.dart';

abstract class TaskManagerImpl{
  Future<AsyncValue<List<Task>>> fetchTasks();
  Future<AsyncValue<String>> addTask(Task task);
  Future<AsyncValue<bool>> deleteTask(Task task);
  Future<AsyncValue<bool>> updateTask(Task task);
}