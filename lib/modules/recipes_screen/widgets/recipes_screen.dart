import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/recipes/recipe.dart';
import '../../../utils/helpers.dart';
import '../../../values/app_colors.dart';
import '../../../values/strings.dart';

/// displays all the recipes that can be made using selected ingredients
class RecipesScreen extends StatelessWidget {
  /// recipes
  final List<Recipe> recipes;

  /// date for which the recipes are displayed
  final DateTime selectedDate;

  /// primary constructor
  const RecipesScreen({
    Key key,
    @required this.recipes,
    @required this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              customBorder: CircleBorder(),
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back),
              ),
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              AppStrings.recipes,
              style: TextStyle(
                fontSize: 32,
                color: AppColors.primaryText,
                letterSpacing: 0.2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              getFormattedDate(selectedDate),
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primaryText,
                letterSpacing: 0.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              itemBuilder: (_, index) => RecipeItemView(recipe: recipes[index]),
              itemCount: recipes.length,
              separatorBuilder: (_, __) => SizedBox(height: 8),
            ),
          ),
        ],
      ),
    );
  }
}

/// represents single item view for recipes list screen
class RecipeItemView extends StatelessWidget {
  /// data source for this recipe widget
  final Recipe recipe;

  /// primary constructor
  const RecipeItemView({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipe.title,
              style: TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.29,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 24),
            Text(
              AppStrings.ingredients,
              style: TextStyle(
                color: AppColors.primaryText,
                letterSpacing: 0.2,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 6),
            Text(
              recipe.ingredients.join(', '),
              style: TextStyle(
                color: AppColors.primaryText,
                letterSpacing: 0.2,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
