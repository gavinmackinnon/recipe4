import 'package:recipe3/models/ingredient.dart';

class Recipe{
  int RecipeID;
  String Title;
  String description;
  String PhotoURL;
  List<Ingredient> Ingredients;

  Recipe(this.RecipeID,this.Title,this.description,this.PhotoURL, {this.Ingredients});


}