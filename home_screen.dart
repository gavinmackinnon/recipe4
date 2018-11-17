import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:recipe3/models/recipe_utilities.dart';
import 'package:recipe3/ui/recipe_screen.dart';
import 'package:recipe3/models/recipe.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  RecipeUtilities myRecipeUtility;
  Recipe myRandomRecipe;
  MyHomePage(this.myRecipeUtility, this.myRandomRecipe, {Key key, this.title})
      : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Recipe myFirstRecipe;
  Recipe mySpecificRecipe;
  Recipe currentRecipe;
  RecipeUtilities myRecipeUtilities;
  List myList;
  final searchController = new TextEditingController();

  String get searchTerm => null;

  Future fetchData() async {
    widget.myRandomRecipe = await widget.myRecipeUtility.getRandomRecipe();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      backgroundColor: Pigment.fromString('FFF8E2'),
      appBar: new AppBar(
        title: new Row(
          children: <Widget>[
            new Padding(padding: new EdgeInsets.only(left: 10.0)),
            new Text(
              'Zeste',
              style: new TextStyle(color: Colors.black),
            ),
            new Padding(padding: new EdgeInsets.only(right: 10.0)),
            new Icon(
              Icons.search,
              size: 20.0,
              color: Colors.black,
            ),
          ],
        ),
        elevation: 1.0,
        backgroundColor: Pigment.fromString('FFF8E2'),
      ),
      body: new ListView.builder(
        padding: new EdgeInsets.all(8.0),
        itemBuilder: (BuildContext context, int index){
          return new Column(
            children: <Widget>[
              new GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context)=> new RecipeScreen(widget.myRandomRecipe)
                    ),
                  );
                },
                child: new Card(
                  child: new Column(
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.all(8.0),
                        child: widget.myRandomRecipe.PhotoURL==null?new Text(""):new Image.network(widget.myRandomRecipe.PhotoURL),
                      ),
                      new ListTile(
                        title: new Text(widget.myRandomRecipe.Title),
                        leading: new IconButton(icon: new Icon(Icons.favorite_border), onPressed: null),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      )
    );
    //this is the start of the card// This trailing comma makes auto-formatting nicer for build methods.
  }
}
