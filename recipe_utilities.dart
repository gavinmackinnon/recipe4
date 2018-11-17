import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe3/models/ingredient.dart';
import 'package:recipe3/models/recipe.dart';
import 'package:xml2json/xml2json.dart';

class RecipeUtilities{
  String BigOvenKey = "Ifu76FTQAzDd6CpFyGgVK9Y8IJ7MW196";
  Recipe FirstRecipe;
  List<Recipe> RecipeList;
  String CurrentSearchTerm;
  int PageNum;
  RecipeUtilities(){
    RecipeList = new List<Recipe>();
    PageNum = 1;
  }
//random recipes
  Future<Recipe> getRandomRecipe() async{
    Map<String,dynamic> recipeMap;
    recipeMap = await _randomRecipeWS();
    int RecipeID = recipeMap["RecipeID"];
    String ImageURL = recipeMap["ImageURL"];
    String Title = recipeMap["Title"];
    //String TotalTime = recipeMap['TotalMinutes'];
    //String PrepTime = recipeMap["ActiveMinutes"];
    String Description = recipeMap["Description"];
    List allingredients = recipeMap['Ingredients'];
    List<Ingredient> tempIngredientList = new List<Ingredient>();
    allingredients.forEach((element){
      String name = element['Name'];
      String qty = element['DisplayQuantity'];
      String unit = element['Unit'];
      String notes = element['PreparationNotes'];
      qty==null?qty="NA":qty=qty;
      unit==null?unit="NA":unit=unit;
      name==null?name="NA":name=name;
      notes==null?notes="NA":notes=notes;
      tempIngredientList.add(new Ingredient(name, notes, qty, unit));
    });
    Recipe newRecipe = new Recipe(RecipeID,Title,Description, ImageURL,Ingredients: tempIngredientList);
    return newRecipe;
  }
//specific recipe
  Future<Recipe> specificRecipes(String targetRecipeID) async{
    Map<String, dynamic> recipeMap;
    print("Starting...");
    recipeMap = await _specificRecipeWS(targetRecipeID);
    int RecipeID = recipeMap["RecipeID"];
    String PrepTime = recipeMap["ActiveMinutes"];
    String ImageURL = recipeMap["ImageURL"];
    String Title = recipeMap["Title"];
    String Description = recipeMap["Description"];
    String Ingredients = recipeMap["Ingredients"];
    String TotalTime = recipeMap['TotalMinutes'];
    Recipe newRecipe = new Recipe(RecipeID,ImageURL, Description, Ingredients, );

    return newRecipe;
  }
//search for recipes
  Future<List> searchRecipes(String searchTerm) async{
    Map<String,dynamic> recipeMap;
    print("Starting...");
    recipeMap = await _searchRecipeWS(searchTerm);
    List recipeList = recipeMap['Results'];
    recipeList.forEach((element){
      int RecipeID = element["RecipeID"];
      String ImageURL = element["ImageURL"];
      String Title = element["Title"];
      String Description = element["Description"];
      String Ingredients = recipeMap["Ingredients"];
      RecipeList.add(new Recipe(RecipeID, Title, Description, ImageURL,));
    }
    );
  }

  Future<Map> _searchRecipeWS(String searchTerms) async{
    final Xml2Json myTransformer = new Xml2Json();
    String apiURL = "https://api2.bigoven.com/recipe/47725?api_key=$BigOvenKey";
    //String apiURL = "https://api2.bigoven.com/recipes?title_kw=oysters&pg=1&rpp=20&api_key=$BigOvenKey"
    var response = await http.get(apiURL);
    int i = 1;
    ///Transforms XML into JSON
    var jsonResponse = json.decode(response.body);
    //myTransformer.parse(response.body);
    //String jsonData = myTransformer.toParker();
    //Map decodedList = json.decode(jsonData);
    return jsonResponse;
  }

  Future<Map> _specificRecipeWS(String recipeID) async{
    final Xml2Json myTransformer = new Xml2Json();
    String apiURL = "https://api2.bigoven.com/recipe/$recipeID&?api_key=$BigOvenKey";
    var response = await http.get(apiURL);
    var jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  //random web service
  Future<Map> _randomRecipeWS() async{
    final Xml2Json myTransformer = new Xml2Json();
    String apiURL = "https://api2.bigoven.com/recipes/random?api_key=$BigOvenKey&photos=true";
    var response = await http.get(apiURL);
    var jsonResponse = json.decode(response.body);
    return jsonResponse;
  }
}