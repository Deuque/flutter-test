import 'package:get_it/get_it.dart';
import 'package:morphosis_flutter_demo/non_ui/bloc/cocktail_cubit.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/cocktail/cocktail_manager.dart';

final locator = GetIt.instance;

void locatorSetup() {
  locator.registerLazySingleton<CocktailManager>(() => CocktailManager());

  locator.registerLazySingleton<CocktailCubit>(() =>
      CocktailCubit(locator.get<CocktailManager>()));
}
