import 'package:inherited_builder/src/utils/naming_conventions.dart';
import 'package:test/test.dart';

void main() {
  test('Replace all dart prohibited characters', () {
    const testStr = 'HelloWorld';
    final actual = testStr.replaceAll(const DartProhibitedCharacters(), '');
    expect(actual, testStr);
  });
}
