import 'package:mocktail/mocktail.dart';
import 'package:morphosis_flutter_demo/non_ui/model/cocktail.dart';

import 'cocktail_manager.impl.dart';

class MockCocktailManager extends Mock implements CocktailManagerImpl {}

final mockLocalCocktails = <Cocktail>[
  Cocktail()
    ..name = 'local drink'
    ..id = '1'
    ..image = '',
];
final mockOnlineCocktails = <Cocktail>[
  Cocktail()
    ..name = 'online drink'
    ..id = '1'
    ..image = '',
];
