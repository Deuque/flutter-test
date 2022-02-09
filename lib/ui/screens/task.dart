import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphosis_flutter_demo/non_ui/bloc/task_modify_cubit.dart';
import 'package:morphosis_flutter_demo/non_ui/locator/locator.dart';
import 'package:morphosis_flutter_demo/non_ui/model/task.dart';

class TaskPage extends StatelessWidget {
  TaskPage({this.task});

  final Task? task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? 'New Task' : 'Edit Task'),
      ),
      body: _TaskForm(task),
    );
  }
}

class _TaskForm extends StatefulWidget {
  _TaskForm(this.task);

  final Task? task;

  @override
  __TaskFormState createState() => __TaskFormState(task);
}

class __TaskFormState extends State<_TaskForm> {
  static const double _padding = 16;

  __TaskFormState(this.task);

  Task? task;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  final _formKey = GlobalKey<FormState>();

  void init() {
    if (task == null) {
      task = Task();
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    } else {
      _titleController = TextEditingController(text: task?.title);
      _descriptionController = TextEditingController(text: task?.description);
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void _save(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (task!.isNew) {
      task = task!
        ..title = _titleController.text
        ..description = _descriptionController.text
        ..createdAt = DateTime.now();
      locator<TaskModifyCubit>().addTask(task!);
    } else {
      task = task!
        ..title = _titleController.text
        ..description = _descriptionController.text
        ..createdAt = DateTime.now();
      locator<TaskModifyCubit>().updateTask(task!);
    }
  }

    @override
    Widget build(BuildContext context) {
      return BlocProvider.value(
        value: locator<TaskModifyCubit>(),
        child: BlocConsumer<TaskModifyCubit, TaskModifyState>(
          listener: (context, state) {
            if (state.taskModifyError != null) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                  SnackBar(content: Text(state.taskModifyError!)));
            }
            if (state.taskModifySuccess != null) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.taskModifySuccess!)));
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(_padding),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Title',
                            ),
                            validator: (s) =>
                            s == null || s.isEmpty
                                ? 'Please enter a title'
                                : null,
                          ),
                          SizedBox(height: _padding),
                          TextFormField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Description',
                            ),
                            validator: (s) =>
                            s == null || s.isEmpty
                                ? 'Please enter a description'
                                : null,
                            minLines: 5,
                            maxLines: 10,
                          ),
                          SizedBox(height: _padding),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Completed ?'),
                              CupertinoSwitch(
                                value: task?.isCompleted ?? false,
                                onChanged: (_) {
                                  setState(() {
                                    task!.toggleComplete();
                                  });
                                },
                              ),
                            ],
                          ),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () => _save(context),
                            child: Container(
                              width: double.infinity,
                              child: Center(
                                  child: Text(
                                      task!.isNew ? 'Create' : 'Update')),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                if (state.toBeModified == task)
                  Positioned.fill(
                      child: Container(
                        color: Colors.white.withOpacity(.7),
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ))
              ],
            );
          },
        ),
      );
    }
  }
