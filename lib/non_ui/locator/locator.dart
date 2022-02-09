import 'package:get_it/get_it.dart';
import 'package:morphosis_flutter_demo/non_ui/bloc/cocktail_cubit.dart';
import 'package:morphosis_flutter_demo/non_ui/bloc/task_cubit.dart';
import 'package:morphosis_flutter_demo/non_ui/bloc/task_modify_cubit.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/cocktail/cocktail_manager.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/task/task_manager.dart';

final locator = GetIt.instance;

void locatorSetup() {
  locator.registerLazySingleton<CocktailManager>(() => CocktailManager());
  locator.registerLazySingleton<TaskManager>(() => TaskManager());

  locator.registerLazySingleton<CocktailCubit>(
      () => CocktailCubit(locator.get<CocktailManager>()));
  locator.registerLazySingleton(() => TaskCubit(locator.get<TaskManager>()));
  locator.registerLazySingleton(
      () => TaskModifyCubit(locator.get<TaskManager>(), locator<TaskCubit>()));
}
