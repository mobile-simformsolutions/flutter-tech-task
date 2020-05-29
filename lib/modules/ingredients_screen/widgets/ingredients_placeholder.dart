import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../values/app_colors.dart';
import '../../../values/strings.dart';

/// shown when loading ingredients or there is a failure.
class IngredientsPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.welcome,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Text(
              AppStrings.ingredientsLoadingSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primaryText,
                letterSpacing: 0.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Visibility(
            visible: false,
            child: Container(
              height: 48,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                disabledColor: AppColors.accentColor.withOpacity(0.5),
                disabledTextColor: Colors.white.withOpacity(0.5),
                color: AppColors.accentColor,
                child: Text(
                  AppStrings.retry,
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
            replacement: SpinKitThreeBounce(
              color: AppColors.accentColor,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
