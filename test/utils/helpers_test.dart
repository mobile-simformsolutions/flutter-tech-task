import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/utils/helpers.dart';

void main() {
  test('test getFormattedDate method', () {
    expect(getFormattedDate(DateTime.now()), 'Today');
    expect(getFormattedDate(DateTime(1970, 5, 20)), 'May 20, 1970');
  });
}
