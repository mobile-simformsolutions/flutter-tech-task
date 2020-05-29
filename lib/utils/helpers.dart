import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';

import '../values/app_constants.dart';
import '../values/strings.dart';
import 'app_toast.dart';
import 'extensions.dart';

/// shows message in a toast
ToastFuture showToast(String text) {
  return showToastWidget(
    AppToast(text: text),
    position: ToastPosition(align: Alignment.topCenter),
    duration: Duration(seconds: 5),
  );
}

/// format given date to a readable string
String getFormattedDate(DateTime dateTime) {
  if (dateTime == null) return '';
  final today = DateTime.now();
  if (dateTime.dateOnly().isAtSameMomentAs(today.dateOnly())) {
    return AppStrings.today;
  }
  return DateFormat(AppConstants.dateFormat).format(dateTime);
}
