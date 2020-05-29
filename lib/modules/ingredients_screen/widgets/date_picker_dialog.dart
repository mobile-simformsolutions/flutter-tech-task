import 'package:flutter/material.dart';

import '../../../utils/extensions.dart';
import '../../../values/app_colors.dart';
import '../../../values/strings.dart';
import 'custom/custom_date_picker.dart';

/// dialog widget that allows to choose a date
class DatePickerDialog extends StatefulWidget {
  /// represent the initial selected date
  final DateTime initialDate;

  /// defines the minimum year to be displayed in the date picker
  final int minimumYear;

  /// primary constructor to create instance of this class
  const DatePickerDialog({
    Key key,
    this.initialDate,
    this.minimumYear,
  }) : super(key: key);

  /// displays date picker as a dialog
  Future<DateTime> show(BuildContext context) async {
    return showDialog<DateTime>(
      context: context,
      builder: (_) => this,
    );
  }

  @override
  _DatePickerDialogState createState() => _DatePickerDialogState();
}

class _DatePickerDialogState extends State<DatePickerDialog> {
  DateTime selected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.appBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CustomDatePicker(
              backgroundColor: AppColors.appBackground,
              minimumYear: widget.minimumYear,
              initialDateTime: widget.initialDate ?? DateTime.now(),
              onDateChanged: (newSelection) {
                setState(() {
                  selected = newSelection;
                });
              },
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 48,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),
              disabledColor: AppColors.accentColor.withOpacity(0.5),
              disabledTextColor: Colors.white.withOpacity(0.5),
              color: AppColors.accentColor,
              child: Text(
                AppStrings.select,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed:
                  !selected.dateOnly().isBefore(DateTime.now().dateOnly())
                      ? () {
                          Navigator.pop(context, selected);
                        }
                      : null,
            ),
          ),
        ],
      ),
    );
  }
}
