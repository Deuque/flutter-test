// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cocktail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cocktail _$CocktailFromJson(Map<String, dynamic> json) => Cocktail()
  ..id = json['idDrink'] as String
  ..name = json['strDrink'] as String
  ..image = json['strDrinkThumb'] as String;

Map<String, dynamic> _$CocktailToJson(Cocktail instance) => <String, dynamic>{
      'idDrink': instance.id,
      'strDrink': instance.name,
      'strDrinkThumb': instance.image,
    };
