import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morphosis_flutter_demo/non_ui/bloc/cocktail_cubit.dart';
import 'package:morphosis_flutter_demo/non_ui/model/cocktail.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/async_value.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/cocktail/cocktail_manager.impl.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/cocktail/cocktail_mock_manager.dart';


void main() {
  group('Cocktail bloc test', () {
    late CocktailManagerImpl cocktailManager;

    setUp(() {
      cocktailManager = MockCocktailManager();
    });

    blocTest<CocktailCubit, CocktailState>(
        'Fetches from local storage on initial load',
        build: () {
          final response =
              Future.value(AsyncValue.withValue(mockLocalCocktails));
          when(() => cocktailManager.fetchLocalOrdinaryDrinks())
              .thenAnswer((_) => response);
          return CocktailCubit(cocktailManager);
        },
        act: (bloc) => bloc.loadOrdinaryDrinks(),
        expect: () => [
              CocktailState(loading: true),
              CocktailState(
                loadedCocktails: mockLocalCocktails,
                loading: false,
              )
            ],
        verify: (_) {
          // verify that items from local storage are not saved again
          verifyNever(() => cocktailManager.saveOrdinaryDrinks(any()));
        });

    blocTest<CocktailCubit, CocktailState>(
        'Fetches from online source when local storage return empty data on initial load',
        build: () {
          final localResponse =
              Future.value(AsyncValue.withValue(<Cocktail>[]));
          final onlineResponse =
              Future.value(AsyncValue.withValue(mockOnlineCocktails));
          final saveResponse = Future.value(AsyncValue.withValue(true));
          when(() => cocktailManager.fetchLocalOrdinaryDrinks())
              .thenAnswer((_) => localResponse);
          when(() => cocktailManager.fetchOnlineOrdinaryDrinks())
              .thenAnswer((_) => onlineResponse);
          when(() => cocktailManager.saveOrdinaryDrinks(any()))
              .thenAnswer((_) => saveResponse);
          return CocktailCubit(cocktailManager);
        },
        act: (bloc) => bloc.loadOrdinaryDrinks(),
        expect: () => [
              CocktailState(loading: true),
              CocktailState(
                loadedCocktails: mockOnlineCocktails,
                loading: false,
              )
            ],
        verify: (_) {
          verify(() => cocktailManager.fetchLocalOrdinaryDrinks()).called(1);
          verify(() => cocktailManager.fetchOnlineOrdinaryDrinks()).called(1);
          verify(() => cocktailManager.saveOrdinaryDrinks(mockOnlineCocktails))
              .called(1);
        });

    blocTest<CocktailCubit, CocktailState>(
        'Fetches directly from online source on reload action',
        build: () {
          final onlineResponse =
              Future.value(AsyncValue.withValue(mockOnlineCocktails));
          final saveResponse = Future.value(AsyncValue.withValue(true));
          when(() => cocktailManager.fetchOnlineOrdinaryDrinks())
              .thenAnswer((_) => onlineResponse);
          when(() => cocktailManager.saveOrdinaryDrinks(any()))
              .thenAnswer((_) => saveResponse);
          return CocktailCubit(cocktailManager);
        },
        act: (bloc) => bloc.reloadOrdinaryDrinks(),
        expect: () => [
              CocktailState(loading: true),
              CocktailState(
                loadedCocktails: mockOnlineCocktails,
                loading: false,
              )
            ],
        verify: (_) {
          // verify that items are saved when they are from online source
          verify(() => cocktailManager.saveOrdinaryDrinks(any())).called(1);
        });
  });
}
