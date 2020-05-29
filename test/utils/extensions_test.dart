import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/utils/extensions.dart';

void main() {
  test('test DateTimeExtensions', () {
    expect(DateTime.now().dateOnly().hour, 0);
    expect(DateTime.now().dateOnly().minute, 0);
    expect(DateTime.now().dateOnly().second, 0);
    expect(DateTime(1970, 5, 20).dateOnly().year, 1970);
    expect(DateTime(1970, 5, 20).dateOnly().month, 5);
    expect(DateTime(1970, 5, 20).dateOnly().day, 20);
  });
}
