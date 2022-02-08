import 'dart:convert';

import 'package:morphosis_flutter_demo/non_ui/model/cocktail.dart';
import 'package:http/http.dart' as http;

import '../async_value.dart';
import '../local_storage_manager.dart';
import 'cocktail_manager.impl.dart';


class CocktailManager implements CocktailManagerImpl {
  final String _baseUrl =
      'https://thecocktaildb.com/api/json/v1/1/filter.php';
  final _storageKey = 'COCKTAILS';
  @override
  Future<AsyncValue<List<Cocktail>>> fetchOnlineOrdinaryDrinks() async {
    final ordinaryDrinksUrl = _baseUrl + '?c=Ordinary_Drink';
    try {
      final response = await http.get(Uri.parse(ordinaryDrinksUrl));
      if (response.statusCode == 200) {
        final cocktailMap = (jsonDecode(response.body))['drinks'] as List;
        return AsyncValue.withValue(
            cocktailMap.take(10).map((e) => Cocktail.fromJson(e)).toList());
      } else {
        return AsyncValue.withError('Unexpected error: ${response.body}');
      }
    } catch (e) {
      return AsyncValue.withError(e);
    }
  }

  @override
  Future<AsyncValue<List<Cocktail>>> fetchLocalOrdinaryDrinks() async {
    try {
      final response = await LocalStorage.shared
          .getStringListData(key: _storageKey, defaultValue: []);
      return AsyncValue.withValue(
          response.map((e) => Cocktail.fromJson(jsonDecode(e))).toList());
    } catch (e) {
      return AsyncValue.withError(e);
    }
  }

  @override
  Future<AsyncValue<bool>> saveOrdinaryDrinks(List<Cocktail> cocktails) async {
    try {
      final encodedCocktails = cocktails.map((e) => jsonEncode(e)).toList();
      final response = await LocalStorage.shared
          .saveStringListData(value: encodedCocktails, key: _storageKey);
      return AsyncValue.withValue(response);
    } catch (e) {
      return AsyncValue.withError(e);
    }
  }

}


