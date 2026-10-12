import 'package:flutter_test/flutter_test.dart';

import 'golden.dart';

void main() {
  test('a missing Material icon font is an error, not a silent skip', () {
    expect(() => materialIconsFont(null), throwsStateError);
    expect(() => materialIconsFont('/nonexistent'), throwsStateError);
  });
}
