import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphosis_flutter_demo/non_ui/bloc/cocktail_cubit.dart';
import 'package:morphosis_flutter_demo/non_ui/bloc/task_cubit.dart';
import 'package:morphosis_flutter_demo/non_ui/bloc/task_modify_cubit.dart';
import 'package:morphosis_flutter_demo/non_ui/locator/locator.dart';
import 'package:morphosis_flutter_demo/ui/screens/home.dart';
import 'package:morphosis_flutter_demo/ui/screens/tasks.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  void initState() {
    locator<CocktailCubit>().loadOrdinaryDrinks();
    locator<TaskCubit>().fetchTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      HomePage(),

      // ALL TASKS
      TasksPage.all(),

      // COMPLETED TASKS
      TasksPage.completed()
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
            value: locator<CocktailCubit>()),
        BlocProvider.value(value: locator<TaskCubit>()),
        BlocProvider.value(value: locator<TaskModifyCubit>()),
      ],
      child: Scaffold(
        body: children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'All Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check),
              label: 'Completed Tasks',
            ),
          ],
        ),
      ),
    );
  }
}
