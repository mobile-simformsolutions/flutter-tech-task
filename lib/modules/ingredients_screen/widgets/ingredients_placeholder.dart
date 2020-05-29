import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../values/app_colors.dart';
import '../../../values/enums.dart';
import '../../../values/strings.dart';
import 'primary_button.dart';

/// shown when loading ingredients or there is a failure.
class IngredientsPlaceholder extends StatelessWidget {
  /// represents the state of the network call
  final NetworkState state;

  /// handles click events for retry button
  final VoidCallback onRetry;

  /// primary constructor to create instance of this class
  const IngredientsPlaceholder({
    Key key,
    @required this.state,
    @required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var subtitle = '';
    switch (state) {
      case NetworkState.loading:
        subtitle = AppStrings.ingredientsLoadingSubtitle;
        break;
      case NetworkState.failure:
        subtitle = AppStrings.ingredientsErrorSubtitle;
        break;
      case NetworkState.success:
        subtitle = AppStrings.noIngredientsSubtitle;
        break;
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primaryText,
                letterSpacing: 0.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (state == NetworkState.failure)
            PrimaryButton(
              title: AppStrings.retry,
              onTap: onRetry,
            ),
          if (state == NetworkState.loading)
            SpinKitThreeBounce(
              color: AppColors.accentColor,
              size: 24,
            ),
        ],
      ),
    );
  }
}
