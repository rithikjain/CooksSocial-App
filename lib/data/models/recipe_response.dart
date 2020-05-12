import 'package:cooks_social/data/models/recipe.dart';

class RecipeResponse {
  String message;
  Recipe recipe;

  RecipeResponse({this.message, this.recipe});

  RecipeResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    recipe =
        json['recipe'] != null ? new Recipe.fromJson(json['recipe']) : null;
  }
}
