import 'package:flutter/material.dart';
import 'package:recipe3/models/recipe.dart';
import 'package:pigment/pigment.dart';
import 'package:recipe3/models/ingredient.dart';

class RecipeScreen extends StatefulWidget {
  Recipe myRandomRecipe;
  RecipeScreen(this.myRandomRecipe, {Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RecipeScreenState createState() => new _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //myFirstRecipe = myRecipeUtility.FirstRecipe;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Pigment.fromString('FFF8E2'),
      appBar: new AppBar(
        backgroundColor: Pigment.fromString("FFF8E2"),
        elevation: 0.0,
        title: new Text(
          'Zeste',
          style: new TextStyle(color: Colors.blueGrey),
        ),
        iconTheme: IconThemeData(color: Colors.blueGrey),
      ),
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverList(
            delegate: SliverChildListDelegate(
              [
                Card(
                  child: new Column(
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: widget.myRandomRecipe.Title == null
                            ? new Text(
                                "Hang on, we're trying to squeeze out the Title")
                            : new Text(
                                widget.myRandomRecipe.Title,
                                style: new TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      new Padding(
                        padding: new EdgeInsets.all(5.0),
                        child: widget.myRandomRecipe.PhotoURL == null
                            ? new Text("Give it a dash more time")
                            : new Image.network(
                          widget.myRandomRecipe.PhotoURL,
                        ),
                      ),
                      new Padding(
                        padding: new EdgeInsets.all(5.0),
                        child: widget.myRandomRecipe.description == null
                            ? new Text("We're stirring up a description")
                            : new Text(widget.myRandomRecipe.description),
                      ),
                    ],
                  ),
                ),
                new Card(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                    ],
                  ),
                ),
                new ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.myRandomRecipe.Ingredients.length,
                  padding: new EdgeInsets.all(15.0),
                  itemBuilder: (BuildContext context, int position) {
                    Ingredient tempIngredient =
                        widget.myRandomRecipe.Ingredients[position];
                    return new Column(
                      children: <Widget>[
                        new Card(
                          child: new Padding(
                            padding: new EdgeInsets.only(left: 2.0),
                            child: new ListTile(
                              title: new Text(tempIngredient.IngredientName),
                              subtitle: new Text(
                                  '${tempIngredient.Quantity} ${tempIngredient.Unit}'),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget displayIngredientList(BuildContext context) {
    return new Expanded(
      child: new ListView.builder(
        itemCount: widget.myRandomRecipe.Ingredients.length,
        padding: new EdgeInsets.all(5.0),
        itemBuilder: (BuildContext context, int position) {
          Ingredient tempIngredient =
              widget.myRandomRecipe.Ingredients[position];
          new Card(
            child: new Padding(
              padding: new EdgeInsets.all(5.0),
              child: new ListTile(
                title: new Row(
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.all(0.0),
                      child: new Text(tempIngredient.IngredientName),
                    ),
                    new Text(
                        '${tempIngredient.Quantity} ${tempIngredient.Unit}')
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
