part of 'cocktail_cubit.dart';

class CocktailState extends Equatable {
  final List<Cocktail>? loadedCocktails;
  final bool loading;
  final String? error;

  CocktailState({this.loadedCocktails, this.loading = false, this.error});

  CocktailState copyWith(
          {List<Cocktail>? loadedCocktails, bool? loading, String? error}) =>
      CocktailState(
          loadedCocktails: loadedCocktails ?? this.loadedCocktails,
          loading: loading ?? this.loading,
          error: error ?? this.error);

  CocktailState withValue(List<Cocktail> loadedCocktails) => CocktailState(
        loadedCocktails: loadedCocktails,
      );

  @override
  List<Object> get props => [loadedCocktails ?? [], loading, error ?? ''];
}
