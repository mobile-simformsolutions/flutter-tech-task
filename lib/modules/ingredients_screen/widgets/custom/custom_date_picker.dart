import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../../../../values/app_colors.dart';
import 'cupertino_picker.dart';

const double _kItemExtent = 50.0;
//const double _kPickerWidth = 330.0;
const double _kMagnification = 1.08;
const double _kDatePickerPadSize = 12.0;
// The density of a date picker is different from a generic picker.
// Eyeballed from iOS.
const double _kSqueeze = 1.25;
// Considers setting the default background color from the theme, in the future.

enum _PickerColumnType {
  // Day of month column in date mode.
  dayOfMonth,
  // Month column in date mode.
  month,
  // Year column in date mode.
  year,
  // Medium date column in dateAndTime mode.
  date,
}

//List of the short months
const List<String> _shortMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

//default text theme
TextStyle _themeTextStyle(BuildContext context) {
  return TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.bold);
}

class CustomDatePicker extends StatefulWidget {
  /// Constructs an iOS style date picker.
  ///
  /// [onDateChanged] is the callback called when the selected date
  /// changes and must not be null.
  ///
  /// [minimumYear] is the minimum year that the picker can be scrolled to in
  /// [CupertinoDatePickerMode.date] mode. Defaults to 1 and must not be null.
  ///
  /// [maximumYear] is the maximum year that the picker can be scrolled to in
  /// [CupertinoDatePickerMode.date] mode. Null if there's no limit.
  ///
  CustomDatePicker({
    @required this.onDateChanged,
    this.mode = CupertinoDatePickerMode.dateAndTime,
    DateTime initialDateTime,
    this.minimumYear = 1,
    this.maximumYear,
    this.itemExtent = _kItemExtent,
    this.magnification = _kMagnification,
    this.dateThemeTextStyle = const TextStyle(
        color: AppColors.primaryText, fontWeight: FontWeight.bold),
    this.monthThemeTextStyle = const TextStyle(
        color: AppColors.primaryText, fontWeight: FontWeight.bold),
    this.yearThemeTextStyle = const TextStyle(
        color: AppColors.primaryText, fontWeight: FontWeight.bold),
    this.selectedDateThemeTextStyle = const TextStyle(
        color: AppColors.primaryText, fontWeight: FontWeight.bold),
    this.selectedMonthThemeTextStyle =
        const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    this.selectedYearThemeTextStyle = const TextStyle(
        color: AppColors.accentColor, fontWeight: FontWeight.bold),
    this.looping = true,
    this.backgroundColor = AppColors.appBackground,
    this.magnifierColor = Colors.blueGrey,
    this.magnifierBorderRadius = const BorderRadius.all(
      Radius.circular(4),
    ),
    this.height = 300,
  })  : initialDateTime = initialDateTime ?? DateTime.now(),
        assert(onDateChanged != null),
        assert(minimumYear != null) {
    assert(this.initialDateTime != null);
  }

  /// The initial date and/or time of the picker. Defaults to the present date
  /// and time and must not be null. The present must conform to the intervals
  /// set in [minimumYear], and [maximumYear].
  ///
  /// Changing this value after the initial build will not affect the currently
  /// selected date time.
  final DateTime initialDateTime;

  /// The mode of the date picker as one of [CupertinoDatePickerMode].
  /// Defaults to [CupertinoDatePickerMode.dateAndTime]. Cannot be null and
  /// value cannot change after initial build.
  final CupertinoDatePickerMode mode;

  /// Minimum year that the picker can be scrolled to in
  /// [CupertinoDatePickerMode.date] mode. Defaults to 1 and must not be null.
  final int minimumYear;

  /// Maximum year that the picker can be scrolled to in
  /// [CupertinoDatePickerMode.date] mode. Null if there's no limit.
  final int maximumYear;

  /// Callback called when the selected date and/or time changes. Must not be
  /// null.
  final ValueChanged<DateTime> onDateChanged;

  /// The uniform height of all children.
  ///
  /// All children will be given the [BoxConstraints] to match this exact
  /// height. Must not be null and must be positive.
  final double itemExtent;

  /// {@macro flutter.rendering.wheelList.magnification}
  final double magnification;

  /// The [looping] argument decides whether the child list loops and can be
  /// scrolled infinitely.  If set to true, scrolling past the end of the list
  /// will loop the list back to the beginning.  If set to false, the list will
  /// stop scrolling when you reach the end or the beginning.
  final bool looping;

  /// If non-null, the style to use for this text.
  ///
  /// If the style's "inherit" property is true, the style will be merged with
  /// the closest enclosing [DefaultTextStyle]. Otherwise, the style will
  /// replace the closest enclosing [DefaultTextStyle].
  final TextStyle dateThemeTextStyle;
  final TextStyle monthThemeTextStyle;
  final TextStyle yearThemeTextStyle;
  final TextStyle selectedDateThemeTextStyle;
  final TextStyle selectedMonthThemeTextStyle;
  final TextStyle selectedYearThemeTextStyle;

  final Color backgroundColor;
  final Color magnifierColor;

  /// If non-null, the corners of this box are rounded by this [BorderRadius].
  ///
  /// Applies only to boxes with rectangular shapes; ignored if [shape] is not
  /// [BoxShape.rectangle].
  ///
  /// {@macro flutter.painting.boxDecoration.clip}
  final BorderRadiusGeometry magnifierBorderRadius;

  final double height;

  @override
  State<CustomDatePicker> createState() => _CupertinoDatePickerDateState();

  // Estimate the minimum width that each column needs to layout its content.
  static double _getColumnWidth(
    _PickerColumnType columnType,
    CupertinoLocalizations localizations,
    BuildContext context,
  ) {
    String longestText = '';

    switch (columnType) {
      case _PickerColumnType.date:
        // Measuring the length of all possible date is impossible, so here
        // just some dates are measured.
        for (int i = 1; i <= 12; i++) {
          // An arbitrary date.
          final String date =
              localizations.datePickerMediumDate(DateTime(2018, i, 25));
          if (longestText.length < date.length) longestText = date;
        }
        break;
      case _PickerColumnType.dayOfMonth:
        for (int i = 1; i <= 31; i++) {
          final String dayOfMonth = localizations.datePickerDayOfMonth(i);
          if (longestText.length < dayOfMonth.length) longestText = dayOfMonth;
        }
        break;
      case _PickerColumnType.month:
        for (int i = 1; i <= 12; i++) {
          final String month = _shortMonths[i - 1];
          if (longestText.length < month.length) longestText = month;
        }
        break;
      case _PickerColumnType.year:
        longestText = localizations.datePickerYear(2018);
        break;
    }

    assert(longestText != '', 'column type is not appropriate');

    final TextPainter painter = TextPainter(
      text: TextSpan(
        style: _themeTextStyle(context),
        text: longestText,
      ),
      textDirection: Directionality.of(context),
    );

    // This operation is expensive and should be avoided. It is called here only
    // because there's no other way to get the information we want without
    // laying out the text.
    painter.layout();

    return painter.maxIntrinsicWidth + 24;
  }
}

typedef _ColumnBuilder = Widget Function(
    double offAxisFraction, TransitionBuilder itemPositioningBuilder);

class _CupertinoDatePickerDateState extends State<CustomDatePicker> {
  int textDirectionFactor;
  CupertinoLocalizations localizations;

  // The currently selected values of the picker.
  int selectedDay;
  int selectedMonth;
  int selectedYear;

  // The controller of the day picker. There are cases where the selected value
  // of the picker is invalid (e.g. February 30th 2018), and this dayController
  // is responsible for jumping to a valid value.
  FixedExtentScrollController dayController;

  // Estimated width of columns.
  Map<int, double> estimatedColumnWidths = <int, double>{};
  TextStyle dateStyle;
  TextStyle monthStyle;
  TextStyle yearStyle;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedDay = widget.initialDateTime.day;
    selectedMonth = widget.initialDateTime.month;
    selectedYear = widget.initialDateTime.year;

    dayController = FixedExtentScrollController(initialItem: selectedDay - 1);
    textDirectionFactor =
        Directionality.of(context) == TextDirection.ltr ? 1 : -1;

    localizations = CupertinoLocalizations.of(context);

    estimatedColumnWidths[_PickerColumnType.dayOfMonth.index] =
        CustomDatePicker._getColumnWidth(
            _PickerColumnType.dayOfMonth, localizations, context);
    estimatedColumnWidths[_PickerColumnType.month.index] =
        CustomDatePicker._getColumnWidth(
            _PickerColumnType.month, localizations, context);
    estimatedColumnWidths[_PickerColumnType.year.index] =
        CustomDatePicker._getColumnWidth(
            _PickerColumnType.year, localizations, context);
  }

  Widget _buildDayPicker(
    double offAxisFraction,
    TransitionBuilder itemPositioningBuilder,
  ) {
    final int daysInCurrentMonth =
        DateTime(selectedYear, (selectedMonth + 1) % 12, 0).day;
    return CustomCupertinoPicker(
      scrollController: dayController,
      offAxisFraction: offAxisFraction,
      itemExtent: widget.itemExtent,
      backgroundColor: widget.backgroundColor,
      squeeze: _kSqueeze,
      onSelectedItemChanged: (int index) {
        selectedDay = index + 1;
        if (DateTime(selectedYear, selectedMonth, selectedDay).day ==
            selectedDay) {
          widget.onDateChanged(
              DateTime(selectedYear, selectedMonth, selectedDay));
        }
      },
      children: List<Widget>.generate(31, (int index) {
        dateStyle = widget.dateThemeTextStyle;
        if (index >= daysInCurrentMonth) {
          dateStyle = dateStyle.copyWith(color: CupertinoColors.inactiveGray);
        } else {
          if (index + 1 == selectedDay) {
            dateStyle = widget.selectedDateThemeTextStyle;
          }
        }

        return itemPositioningBuilder(
          context,
          Text(
            localizations.datePickerDayOfMonth(index + 1),
            style: dateStyle,
          ),
        );
      }),
      looping: widget.looping,
    );
  }

  Widget _buildMonthPicker(
      double offAxisFraction, TransitionBuilder itemPositioningBuilder) {
    return CustomCupertinoPicker(
      scrollController:
          FixedExtentScrollController(initialItem: selectedMonth - 1),
      offAxisFraction: offAxisFraction,
      itemExtent: widget.itemExtent,
      backgroundColor: widget.backgroundColor,
      squeeze: _kSqueeze,
      onSelectedItemChanged: (int index) {
        selectedMonth = index + 1;
        if (DateTime(selectedYear, selectedMonth, selectedDay).day ==
            selectedDay)
          widget.onDateChanged(
              DateTime(selectedYear, selectedMonth, selectedDay));
      },
      children: List<Widget>.generate(12, (int index) {
        monthStyle = widget.monthThemeTextStyle;
        if (index + 1 == selectedMonth) {
          monthStyle = widget.selectedMonthThemeTextStyle;
        }

        return itemPositioningBuilder(
          context,
          Text(
            _shortMonths[index],
            style: monthStyle,
          ),
        );
      }),
      looping: widget.looping,
    );
  }

  Widget _buildYearPicker(
      double offAxisFraction, TransitionBuilder itemPositioningBuilder) {
    return CustomCupertinoPicker.builder(
      scrollController: FixedExtentScrollController(initialItem: selectedYear),
      offAxisFraction: offAxisFraction,
      itemExtent: widget.itemExtent,
      backgroundColor: widget.backgroundColor,
      onSelectedItemChanged: (int index) {
        selectedYear = index;
        if (DateTime(selectedYear, selectedMonth, selectedDay).day ==
            selectedDay)
          widget.onDateChanged(
              DateTime(selectedYear, selectedMonth, selectedDay));
      },
      itemBuilder: (BuildContext context, int index) {
        if (index < widget.minimumYear) return null;

        if (widget.maximumYear != null && index > widget.maximumYear)
          return null;

        yearStyle = widget.yearThemeTextStyle;
        if (index == selectedYear) {
          yearStyle = widget.selectedYearThemeTextStyle;
        }

        return itemPositioningBuilder(
          context,
          Text(
            localizations.datePickerYear(index),
            style: yearStyle,
          ),
        );
      },
    );
  }

  bool _keepInValidRange(ScrollEndNotification notification) {
    // Whenever scrolling lands on an invalid entry, the picker
    // automatically scrolls to a valid one.
    final int desiredDay =
        DateTime(selectedYear, selectedMonth, selectedDay).day;
    if (desiredDay != selectedDay) {
      SchedulerBinding.instance.addPostFrameCallback((Duration timestamp) {
        dayController.animateToItem(
          // The next valid date is also the amount of days overflown.
          dayController.selectedItem - desiredDay,
          duration: const Duration(milliseconds: 1),
          curve: Curves.easeOut,
        );
      });
    }
    setState(() {
      // Rebuild because the number of valid days per month are different
      // depending on the month and year.
    });
    return false;
  }

  bool _changeColorOnScroll(ScrollNotification notification) {
    final int desiredDay =
        DateTime(selectedYear, selectedMonth, selectedDay).day;
    final int desiredMonth =
        DateTime(selectedYear, selectedMonth, selectedDay).month;
    final int desiredYear =
        DateTime(selectedYear, selectedMonth, selectedDay).year;

    if (desiredDay == selectedDay) {
      dateStyle = widget.dateThemeTextStyle ??
          const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold);
    }

    if (desiredMonth == selectedMonth) {
      monthStyle = widget.monthThemeTextStyle ??
          const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold);
    }

    if (desiredYear == selectedYear) {
      yearStyle = widget.yearThemeTextStyle ??
          const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold);
    }
    setState(() {});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    List<_ColumnBuilder> pickerBuilders = <_ColumnBuilder>[];
    List<double> columnWidths = <double>[];

    pickerBuilders = <_ColumnBuilder>[
      _buildDayPicker,
      _buildMonthPicker,
      _buildYearPicker
    ];

    columnWidths = <double>[
      estimatedColumnWidths[_PickerColumnType.dayOfMonth.index],
      estimatedColumnWidths[_PickerColumnType.month.index],
      estimatedColumnWidths[_PickerColumnType.year.index]
    ];

    final List<Widget> pickers = <Widget>[];

    for (int i = 0; i < columnWidths.length; i++) {
      final double offAxisFraction = (i - 1) * 0.3 * textDirectionFactor;

      EdgeInsets padding = const EdgeInsets.only(right: _kDatePickerPadSize);
      if (textDirectionFactor == -1)
        padding = const EdgeInsets.only(left: _kDatePickerPadSize);

      pickers.add(LayoutId(
        id: i,
        child: pickerBuilders[i](
          offAxisFraction,
          (BuildContext context, Widget child) {
            return Container(
              alignment: Alignment.center,
              padding: i == 0 ? null : padding,
              child: Container(
                alignment: Alignment.center,
                width: columnWidths[i] + _kDatePickerPadSize,
                child: child,
              ),
            );
          },
        ),
      ));
    }

    //Magnifier
    Widget _buildMagnifierScreen() {
      return IgnorePointer(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      widget.backgroundColor.withOpacity(1),
                      widget.backgroundColor.withOpacity(0.5),
                    ],
                    stops: [0, 0.7],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: widget.magnifierColor.withOpacity(.2),
                borderRadius: widget.magnifierBorderRadius,
              ),
              constraints: BoxConstraints.expand(
                height: widget.itemExtent * widget.magnification,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      widget.backgroundColor.withOpacity(1),
                      widget.backgroundColor.withOpacity(0.5),
                    ],
                    stops: [0, 0.7],
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return MediaQuery(
      data: const MediaQueryData(textScaleFactor: 1.0),
      child: NotificationListener<ScrollNotification>(
        onNotification: _changeColorOnScroll,
        child: NotificationListener<ScrollEndNotification>(
          onNotification: _keepInValidRange,
          child: Container(
            height: widget.height,
            child: Stack(
              children: <Widget>[
                CustomMultiChildLayout(
                  delegate: _DatePickerLayoutDelegate(
                    columnWidths: columnWidths,
                    textDirectionFactor: textDirectionFactor,
                  ),
                  children: pickers,
                ),
                _buildMagnifierScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DatePickerLayoutDelegate extends MultiChildLayoutDelegate {
  _DatePickerLayoutDelegate({
    @required this.columnWidths,
    @required this.textDirectionFactor,
  })  : assert(columnWidths != null),
        assert(textDirectionFactor != null);

  // The list containing widths of all columns.
  final List<double> columnWidths;

  // textDirectionFactor is 1 if text is written left to right, and -1 if right to left.
  final int textDirectionFactor;

  @override
  void performLayout(Size size) {
    double remainingWidth = size.width;

    for (int i = 0; i < columnWidths.length; i++)
      remainingWidth -= columnWidths[i] + _kDatePickerPadSize * 2;

    double currentHorizontalOffset = 0.0;

    for (int i = 0; i < columnWidths.length; i++) {
      final int index =
          textDirectionFactor == 1 ? i : columnWidths.length - i - 1;

      double childWidth = columnWidths[index] + _kDatePickerPadSize * 2;
      if (index == 0 || index == columnWidths.length - 1)
        childWidth += remainingWidth / 2;

      // We can't actually assert here because it would break things badly for
      // semantics, which will expect that we laid things out here.
      assert(() {
        if (childWidth < 0) {
          FlutterError.reportError(
            FlutterErrorDetails(
              exception: FlutterError(
                'Insufficient horizontal space to render the '
                'CupertinoDatePicker because the parent is too narrow at '
                '${size.width}px.\n'
                'An additional ${-remainingWidth}px is needed to avoid '
                'overlapping columns.',
              ),
            ),
          );
        }
        return true;
      }());
      layoutChild(index,
          BoxConstraints.tight(Size(math.max(0.0, childWidth), size.height)));
      positionChild(index, Offset(currentHorizontalOffset, 0.0));

      currentHorizontalOffset += childWidth;
    }
  }

  @override
  bool shouldRelayout(_DatePickerLayoutDelegate oldDelegate) {
    return columnWidths != oldDelegate.columnWidths ||
        textDirectionFactor != oldDelegate.textDirectionFactor;
  }
}
