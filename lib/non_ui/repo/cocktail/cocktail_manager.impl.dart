
import 'package:morphosis_flutter_demo/non_ui/model/cocktail.dart';

import '../async_value.dart';

abstract class CocktailManagerImpl {
  Future<AsyncValue<List<Cocktail>>> fetchOnlineOrdinaryDrinks();
  Future<AsyncValue<List<Cocktail>>> fetchLocalOrdinaryDrinks();
  Future<AsyncValue<bool>> saveOrdinaryDrinks(List<Cocktail> cocktails);
}
