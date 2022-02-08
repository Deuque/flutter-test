class CocktailManager{
  static CocktailManager? _one;

  static CocktailManager get shared =>
      (_one == null ? (_one = CocktailManager._()) : _one!);
  CocktailManager._();

  final String _baseUrl = 'http://www.thecocktaildb.com/api/json/v1/1/filter.php';



}