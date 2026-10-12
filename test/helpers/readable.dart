import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

/// Fails if the paragraph found by [text] is laid out shorter than its text (clipped).
void expectNotClipped(WidgetTester tester, Finder text) {
  final paragraph = tester.renderObject<RenderParagraph>(text);
  expect(
    paragraph.size.height,
    greaterThanOrEqualTo(
      paragraph.getMaxIntrinsicHeight(paragraph.size.width) - 0.5,
    ),
    reason: 'the paragraph is clipped',
  );
}
