import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../values/app_colors.dart';
import '../../../values/strings.dart';
import 'ingredient_chip.dart';

/// ingredients selection screen
class IngredientsScreen extends StatefulWidget {
  @override
  _IngredientsScreenState createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 56),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.today,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.4,
                  ),
                ),
                InkWell(
                  customBorder: CircleBorder(),
                  onTap: () {
                    // TODO: open Date picker
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.calendar_today,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 48),
            Text(
              AppStrings.ingredientsSubtitle,
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  runSpacing: 8,
                  spacing: 6,
                  children: [
                    IngredientChip(
                      title: 'Milk',
                      selected: false,
                      enabled: false,
                      onTap: () {},
                    ),
                    IngredientChip(
                      title: 'Chocolate',
                      selected: true,
                      enabled: true,
                      onTap: () {},
                    ),
                    IngredientChip(
                      title: 'Tomatoes',
                      selected: true,
                      enabled: true,
                      onTap: () {},
                    ),
                    IngredientChip(
                      title: 'Cocoa Powder',
                      selected: false,
                      enabled: true,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Text(
                AppStrings.ingredientsInstruction,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 48,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                disabledColor: AppColors.accentColor.withOpacity(0.5),
                disabledTextColor: Colors.white.withOpacity(0.5),
                color: AppColors.accentColor,
                child: Text(
                  AppStrings.getRecipes,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  // TODO: get recipes
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
