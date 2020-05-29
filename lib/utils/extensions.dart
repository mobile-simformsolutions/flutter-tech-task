/// extensions for DateTime class
extension DateTimeExtensions on DateTime {
  /// creates instance of DateTime omitting time information
  DateTime dateOnly() => DateTime(year, month, day);
}
