import 'package:morphosis_flutter_demo/non_ui/model/cocktail.dart';

import '../async_value.dart';
import 'cocktail_manager.impl.dart';

class MockCocktailManager implements CocktailManagerImpl {
  @override
  Future<AsyncValue<List<Cocktail>>> fetchOnlineOrdinaryDrinks() {
    return Future.value(AsyncValue.withValue([]));
  }

  @override
  Future<AsyncValue<List<Cocktail>>> fetchLocalOrdinaryDrinks() {
    return Future.value(AsyncValue.withValue([]));
  }

  @override
  Future<AsyncValue<bool>> saveOrdinaryDrinks(List<Cocktail> cocktails) {
    return Future.value(AsyncValue.withValue(true));
  }


}
