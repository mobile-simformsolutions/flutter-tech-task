import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../values/app_colors.dart';

/// primary action button widget
class PrimaryButton extends StatelessWidget {
  /// handles click events
  final VoidCallback onTap;

  /// handles enable/disable state
  final bool enabled;

  /// represents title text of the button
  final String title;

  /// defines width of the button
  final double width;

  /// represents loading state of the button
  final bool loading;

  /// primary constructor to create instance of this widget
  const PrimaryButton({
    Key key,
    @required this.onTap,
    this.enabled = true,
    this.title,
    this.width = double.maxFinite,
    this.loading = false,
  })  : assert(onTap != null, title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 48,
      child: FlatButton(
        onPressed: enabled ? loading ? () {} : onTap : null,
        color: AppColors.accentColor,
        textTheme: ButtonTextTheme.normal,
        child: loading
            ? SpinKitThreeBounce(
                color: Theme.of(context).accentTextTheme.button.color,
                size: 24,
              )
            : Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
        disabledTextColor: Colors.white.withOpacity(0.5),
        disabledColor: AppColors.accentColor.withOpacity(0.5),
      ),
    );
  }
}
