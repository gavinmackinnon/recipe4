import 'package:flutter/material.dart';
import 'recipe.dart';
import 'recipe_utilities.dart';
import 'searchresults.dart';
import 'dart:async';

class MySearchPage extends StatefulWidget{
  MySearchPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MySearchPageState createState() => new _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  Recipe myFirstRecipe;
  RecipeUtilities myRecipeUtility;
  List myList;
  final searchController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Recipe Search'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(top: 16.0,bottom: 16.0),
              child: new TextFormField(
                controller: searchController,
                //autofocus: true,
                //initialValue: "",
                decoration: new InputDecoration(
                    labelText: "Search Terms",
                    filled: true,
                    fillColor: Colors.grey.shade100),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            new Padding(padding: new EdgeInsets.only(top: 10.0,right: 10.0,left: 10.0),
                child: new GestureDetector(
                  onTap: ()async{
                    myRecipeUtility = new RecipeUtilities();
                    myList = await myRecipeUtility.searchRecipes(searchController.text);
                    print('Fetching data');
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new SearchResults(myRecipeUtility)
                        )
                    );
                  },
                  child: new Container(
                    decoration: new BoxDecoration(
                      border: new Border.all(color: Colors.black54,width: 2.0),
                      color: Colors.blueAccent,
                    ),
                    alignment: Alignment.center,
                    height: 40.0,
                    child: new Column(
                      children: <Widget>[
                        new Text('Go To Search',
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 18.9,
                              fontWeight: FontWeight.bold),
                        ),

                      ],
                      mainAxisAlignment: MainAxisAlignment.center,),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}