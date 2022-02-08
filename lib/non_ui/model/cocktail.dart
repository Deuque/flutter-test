import 'package:json_annotation/json_annotation.dart';

part 'cocktail.g.dart';

@JsonSerializable(explicitToJson: true)
class Cocktail {
  Cocktail();

  @JsonKey(name: 'idDrink')
  late String id;
  @JsonKey(name: 'strDrink')
  late String name;
  @JsonKey(name: 'strDrinkThumb')
  late String image;

  factory Cocktail.fromJson(Map<String, dynamic> json) => _$CocktailFromJson(json);

  Map<String, dynamic> toJson() => _$CocktailToJson(this);
}
