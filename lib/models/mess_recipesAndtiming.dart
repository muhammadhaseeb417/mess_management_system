import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessRecipes {
  String? recipeId;
  String recipeName;
  double recipePrice;
  String messDay;
  String messTime;

  MessRecipes({
    this.recipeId,
    required this.recipeName,
    required this.recipePrice,
    required this.messDay,
    required this.messTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'recipeId': recipeId,
      'recipeName': recipeName,
      'recipePrice': recipePrice,
      'messDay': messDay,
      'messTime': messTime,
    };
  }

  factory MessRecipes.fromMap(Map<String, dynamic> map) {
    return MessRecipes(
      recipeId: map['recipeId'] != null ? map['recipeId'] as String : null,
      recipeName: map['recipeName'] as String,
      recipePrice: map['recipePrice'] as double,
      messDay: map['messDay'] as String,
      messTime: map['messTime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessRecipes.fromJson(String source) =>
      MessRecipes.fromMap(json.decode(source) as Map<String, dynamic>);
}
