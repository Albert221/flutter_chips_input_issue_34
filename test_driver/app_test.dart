import 'package:flutter_driver/flutter_driver.dart';
// import 'package:flutter_test/flutter_test.dart' show findsOneWidget;
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      // driver.close();
    }
  });

  test('Reproduces bug from #34', () async {
    final chipsInput = find.byValueKey('input');

    await driver.tap(chipsInput);
    await Future.delayed(Duration(seconds: 1));

    await driver.enterText('a');
    await driver.waitFor(find.text('a'));
    await Future.delayed(Duration(seconds: 1));

    final alphaSuggestion = find.text('Alpha');
    await driver.tap(alphaSuggestion);
    await Future.delayed(Duration(seconds: 1));

    await driver.enterText('a');
    await driver.waitFor(find.text('a'));
  });
}
