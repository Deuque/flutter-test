
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphosis_flutter_demo/non_ui/bloc/task_cubit.dart';
import 'package:morphosis_flutter_demo/non_ui/bloc/task_modify_cubit.dart';
import 'package:morphosis_flutter_demo/non_ui/locator/locator.dart';
import 'package:morphosis_flutter_demo/non_ui/model/task.dart';
import 'package:morphosis_flutter_demo/ui/screens/task.dart';

class TasksPage extends StatelessWidget {
  final String title;
  final bool showOnlyCompletedTasks;

  TasksPage.all()
      : this.title = 'All Tasks',
        showOnlyCompletedTasks = false;

  TasksPage.completed()
      : this.title = 'Completed Tasks',
        showOnlyCompletedTasks = true;

  void addTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => addTask(context),
            )
          ],
        ),
        body: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            if (state.error != null) {
              return Center(
                child: Text(
                  state.error!,
                  textAlign: TextAlign.center,
                ),
              );
            } else if (state.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.allTasks != null) {
              final tasks = showOnlyCompletedTasks
                  ? state.completedTasks!
                  : state.allTasks!;
              return tasks.isEmpty
                  ? Center(
                      child: Text('Add your first task'),
                    )
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return _Task(
                          tasks[index],
                        );
                      },
                    );
            }
            return SizedBox.shrink();
          },
        ));
  }
}

class _Task extends StatelessWidget {
  _Task(this.task);

  final Task task;

  void _delete() {
    //TODO implement delete to firestore
  }

  void _toggleComplete() {
    final completedAt = task.isCompleted ? null : DateTime.now();
    locator<TaskModifyCubit>().updateTask(task..completedAt = completedAt);
  }

  void _view(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskPage(task: task)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskModifyCubit, TaskModifyState>(
      builder: (context, state) {
        bool isUpdating = state.toBeModified == task;
        return Stack(
          children: [
            ListTile(
              leading:  IconButton(
                      icon: isUpdating
                          ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      )
                          :Icon(
                        task.isCompleted
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                      ),
                      onPressed: _toggleComplete,
                    ),
              title: Text(task.title!),
              subtitle: Text(task.description!),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: _delete,
              ),
              onTap: () => _view(context),
            ),
            if (isUpdating)
              Positioned.fill(
                  child: Container(
                color: Colors.white.withOpacity(.6),
              ))
          ],
        );
      },
    );
  }
}
