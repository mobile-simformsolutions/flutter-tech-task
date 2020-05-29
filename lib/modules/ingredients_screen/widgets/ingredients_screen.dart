import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/extensions.dart';
import '../../../values/app_colors.dart';
import '../../../values/app_constants.dart';
import '../../../values/enums.dart';
import '../../../values/strings.dart';
import '../store/ingredients_store.dart';
import 'date_picker_dialog.dart';
import 'ingredient_chip.dart';
import 'ingredients_placeholder.dart';
import 'primary_button.dart';

/// ingredients selection screen
class IngredientsScreen extends StatefulObserverWidget {
  @override
  _IngredientsScreenState createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  IngredientsStore store;

  @override
  void initState() {
    store = Provider.of<IngredientsStore>(context, listen: false);
    super.initState();
  }

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
                  _getFormattedDate(),
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.4,
                  ),
                ),
                InkWell(
                  customBorder: CircleBorder(),
                  onTap: _openDatePicker,
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
              child: PageTransitionSwitcher(
                duration: Duration(microseconds: 300),
                transitionBuilder: (child, animation, secondaryAnimation) =>
                    FadeScaleTransition(
                  animation: animation,
                  child: child,
                ),
                child: store.state != NetworkState.success
                    ? IngredientsPlaceholder(
                        state: store.state,
                        onRetry: () => store.fetchIngredients(),
                      )
                    : Align(
                        alignment: Alignment.topCenter,
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
                              for (final ingredient in store.ingredients) ...{
                                IngredientChip(
                                  title: ingredient.name,
                                  selected: ingredient.isSelected,
                                  enabled:
                                      store.isIngredientNotExpired(ingredient),
                                  onTap: () {
                                    ingredient.isSelected =
                                        !ingredient.isSelected;
                                    store.ingredientsObservable.reportChanged();
                                  },
                                ),
                              }
                            ],
                          ),
                        ),
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
            PrimaryButton(
              title: AppStrings.getRecipes,
              enabled: store.isAnySelected,
              onTap: _makeRecipes,
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedDate() {
    final today = DateTime.now();
    if (store.selectedDate.year == today.year &&
        store.selectedDate.month == today.month &&
        store.selectedDate.day == today.day) {
      return AppStrings.today;
    }
    return DateFormat(AppConstants.dateFormat).format(store.selectedDate);
  }

  void _openDatePicker() async {
    final result = await DatePickerDialog(
      initialDate: store.selectedDate,
      minimumYear: DateTime
          .now()
          .year,
    ).show(context);
    if (result != null &&
        !result.dateOnly().isAtSameMomentAs(store.selectedDate.dateOnly())) {
      store.selectedDate = result;
      store.fetchIngredients();
    }
  }

  void _makeRecipes() async {
    // TODO:
  }
}
