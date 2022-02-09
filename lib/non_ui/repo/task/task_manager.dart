import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morphosis_flutter_demo/non_ui/model/task.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/async_value.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/task/task_manager_impl.dart';

import '../firebase_manager.dart';

class TaskManager implements TaskManagerImpl {
  final String _collectionPath = 'duke_tasks';
  final firebaseManager = FirebaseManager.shared;

  CollectionReference get taskCollection =>
      firebaseManager.tasksRef(_collectionPath);

  @override
  Future<AsyncValue<String>> addTask(Task task) async {
    try {
      final response = await taskCollection.add(task.toJson());
      return AsyncValue.withValue(response.id);
    } catch (e) {
      return AsyncValue.withError(e);
    }
  }

  @override
  Future<AsyncValue<bool>> deleteTask(Task task) async{
    try {
      await taskCollection.doc(task.id).delete();
      return AsyncValue.withValue(true);
    } catch (e) {
      return AsyncValue.withError(e);
    }
  }

  @override
  Future<AsyncValue<List<Task>>> fetchTasks() async {
    try {
      final response = await taskCollection.get();
      return AsyncValue.withValue(response.docs
          .map(
              (e) => Task.fromJson(e.data() as Map<String, dynamic>)..id = e.id)
          .toList());
    } catch (e) {
      return AsyncValue.withError(e);
    }
  }

  @override
  Future<AsyncValue<bool>> updateTask(Task task) async {
    try {
       await taskCollection.doc(task.id).update(task.toJson());
      return AsyncValue.withValue(true);
    } catch (e) {
      return AsyncValue.withError(e);
    }
  }
}
