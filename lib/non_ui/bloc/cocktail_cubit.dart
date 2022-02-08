import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:morphosis_flutter_demo/non_ui/model/cocktail.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/cocktail/cocktail_manager.impl.dart';

part 'cocktail_state.dart';

class CocktailCubit extends Cubit<CocktailState> {
  final CocktailManagerImpl cocktailManager;

  CocktailCubit(this.cocktailManager) : super(CocktailState());

  // initial loading tries local storage before fetching from online source
  void loadOrdinaryDrinks() async {
    emit(state.copyWith(loading: true));

    // local call
    var cocktailsAsync = await cocktailManager.fetchLocalOrdinaryDrinks();
    if (cocktailsAsync.hasValue && cocktailsAsync.value!.isNotEmpty) {
      emit(state.withValue(cocktailsAsync.value!));
      return;
    }

    // network call if local is empty
    fetchOrdinaryDrinksFromOnlineSource();
  }

  // reloading fetches directly from online source
  void reloadOrdinaryDrinks() async {
    emit(state.copyWith(loading: true));

    fetchOrdinaryDrinksFromOnlineSource();
  }

  void fetchOrdinaryDrinksFromOnlineSource() async {
    final cocktailsAsync = await cocktailManager.fetchOnlineOrdinaryDrinks();
    if (cocktailsAsync.error != null) {
      emit(state.copyWith(error: cocktailsAsync.error.toString()));
    } else {
      cocktailManager.saveOrdinaryDrinks(cocktailsAsync.value!);
      emit(state.withValue(cocktailsAsync.value!));
    }
  }
}
