import 'package:flutter/material.dart';
import 'package:recipe3/models/ingredient.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe3/models/recipe.dart';

class IngredientListItem extends StatefulWidget {
  Recipe myRandomRecipe;

  @override
  _IngredientListItemState createState() => new _IngredientListItemState();
}

class _IngredientListItemState extends State<IngredientListItem>{
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: widget.myRandomRecipe.Ingredients.length,
      padding: new EdgeInsets.all(15.0),
      itemBuilder: (BuildContext context, int position) {
        Ingredient tempIngredient = widget.myRandomRecipe.Ingredients[position];
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
    );
  }
}