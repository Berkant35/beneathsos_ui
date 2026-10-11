import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('page padding is 16 on phones and 24 from 600 px', () {
    expect(BeneathSpacing.pageFor(375), const EdgeInsets.all(16));
    expect(BeneathSpacing.pageFor(599), const EdgeInsets.all(16));
    expect(BeneathSpacing.pageFor(600), const EdgeInsets.all(24));
  });

  test('field-ergonomics sizes', () {
    expect(BeneathSizes.minTouchTarget, 56);
    expect(BeneathSizes.primaryButtonHeight, 64);
  });
}
