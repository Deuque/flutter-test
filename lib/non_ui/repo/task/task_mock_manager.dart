import 'package:mocktail/mocktail.dart';
import 'package:morphosis_flutter_demo/non_ui/model/task.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/task/task_manager_impl.dart';

class MockTaskManager extends Mock implements TaskManagerImpl {}

List<Task> mockTasks = [
  {
    "id": "1",
    "title": "Task 1",
    "description": "Task 1 description",
    "created_at": DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
  },
  {
    "id": "2",
    "title": "Task 2",
    "description": "Task 2 description",
    "created_at": DateTime.now().toIso8601String(),
    "completed_at": DateTime.now().toIso8601String()
  }
].map((e) => Task.fromJson(e)).toList();
