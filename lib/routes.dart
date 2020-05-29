import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/recipes/recipe.dart';
import 'modules/recipes_screen/widgets/recipes_screen.dart';

/// holds all the navigation routes for the app
class Routes {
  /// opens recipes list screen
  static PageRoute recipesScreen(List<Recipe> recipes, DateTime selectedDate) {
    return MaterialPageRoute(
      builder: (_) => RecipesScreen(
        recipes: recipes,
        selectedDate: selectedDate,
      ),
    );
  }
}
