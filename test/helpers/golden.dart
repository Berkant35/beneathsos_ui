import 'dart:io';

import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Key of the RepaintBoundary that golden tests capture.
const goldenKey = ValueKey('golden');

/// Loads the bundled Atkinson weights under the family name the theme uses (call in setUpAll).
Future<void> loadBeneathFont() async {
  final loader = FontLoader('packages/$beneathFontPackage/$beneathFontFamily');
  for (final style in const ['Regular', 'SemiBold', 'Bold', 'ExtraBold']) {
    final bytes = File('fonts/AtkinsonHyperlegibleNext-$style.ttf')
        .readAsBytesSync();
    loader.addFont(Future.value(ByteData.sublistView(bytes)));
  }
  await loader.load();
}

/// [child] on the theme background, padded, inside a RepaintBoundary keyed [goldenKey].
Widget goldenFrame(Widget child, {required Brightness brightness}) =>
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: brightness == Brightness.light
          ? BeneathTheme.light()
          : BeneathTheme.dark(),
      home: Scaffold(
        body: Center(
          child: RepaintBoundary(
            key: goldenKey,
            child: Builder(
              builder: (context) => ColoredBox(
                color: Theme.of(context).colorScheme.surface,
                child: Padding(padding: const EdgeInsets.all(16), child: child),
              ),
            ),
          ),
        ),
      ),
    );
