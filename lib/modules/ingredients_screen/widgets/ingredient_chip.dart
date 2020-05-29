import 'package:flutter/material.dart';

import '../../../values/app_colors.dart';

/// Represents a single ingredient view
class IngredientChip extends StatelessWidget {
  /// Title text of the chip
  final String title;

  /// determines whether the chip is selected or not
  final bool selected;

  /// determines whether the chip is enabled or not
  final bool enabled;

  /// handles click events on the chip
  final VoidCallback onTap;

  /// default constructor to create chip widget
  const IngredientChip({
    Key key,
    @required this.title,
    this.selected = false,
    this.enabled = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Card(
        color: Colors.white,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: selected ? AppColors.accentColor : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          highlightColor: AppColors.accentColor.withOpacity(0.2),
          splashColor: AppColors.accentColor.withOpacity(0.5),
          onTap: enabled ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: selected ? AppColors.accentColor : AppColors.primaryText,
                fontSize: 20,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
