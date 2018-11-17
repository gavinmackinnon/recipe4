import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:recipe3/models/recipe.dart';
import 'dart:async';
import 'package:recipe3/models/recipe_utilities.dart';
import 'package:recipe3/home_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  RecipeUtilities myRecipeUtility;

  Future<Recipe> fetchData() async{
    myRecipeUtility = new RecipeUtilities();
    Recipe myRandomRecipe = await myRecipeUtility.getRandomRecipe();
    return myRandomRecipe;
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: fetchData(),
        builder:
            (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return createWaiting(context,snapshot);
            default: return createRSList(context,snapshot);
          }
        }
    );
  }
  Widget createRSList (BuildContext context, AsyncSnapshot snapshot) {
    print("in Create Order List");
    Recipe newRecipe = snapshot.data;
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RecipeBook",
      theme: new ThemeData(
        primaryColor: Pigment.fromString('C74944'),
      ),
      home: new MyHomePage(myRecipeUtility,newRecipe),
    );
  }
  Widget createWaiting(BuildContext context, AsyncSnapshot snapshot) {
    print('in Create Order List');
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Zeste",
        theme: new ThemeData(
          primaryColor: Pigment.fromString('C74944'),
        ),
        home: new Scaffold(
          body: new Center(
            child: new Column(
              children: <Widget>[
                new CircularProgressIndicator(),
                new Text('Cooked up in the suburbs of MA'),
              ],
            ),
          ),
        )
    );
  }
}







