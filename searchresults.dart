import 'package:flutter/material.dart';
import 'recipe.dart';
import 'recipe_utilities.dart';
import 'dart:async';


class SearchResults extends StatefulWidget {
  RecipeUtilities MyRecipeUtility;
  SearchResults(this.MyRecipeUtility,{Key key,this.title}) : super(key: key);
  final String title;

  @override
  _SearchResultsState createState() => new _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults>{
  Recipe myFirstRecipe;
  RecipeUtilities myRecipeUtility;
  List myList;

  Future<List> fetchData() async{
    return widget.MyRecipeUtility.RecipeList;
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Recipe Book'),
      ),
      body: new Center(
          child: new FutureBuilder(
              future: fetchData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting: return new Text("Awaiting Results...");
                  default:
                    if (snapshot.hasError)
                      return new Text("Error: ${snapshot.error}");
                    else
                      return createRecipeList(context, snapshot);
                }
              })
      ),
    );
  }
  Widget createRecipeList (BuildContext context, AsyncSnapshot snapshot){
    List<Recipe> recipeList = snapshot.data;
    print('The List Is: ${recipeList.length}');
    return new ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: recipeList.length,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext context, int position) {
        Recipe tempRecipe = recipeList[position];
        return new Card(
            child: new Padding(
              padding: new EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: new ListTile(
                title: new Text(
                  tempRecipe.Title,
                  style: new TextStyle(fontSize: 18.9),
                ),
                subtitle: new Column(children: <Widget>[
                  new Image.network(tempRecipe.PhotoURL),
                ],),
                trailing: new Text('nada', style: new TextStyle(fontSize: 10.3),),

              ),
            )
        );
      },
    );
  }
}

