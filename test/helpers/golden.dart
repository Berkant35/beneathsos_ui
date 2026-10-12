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
  await _loadMaterialIcons();
}

/// Material icons from the Flutter SDK, so icons in goldens are glyphs rather than boxes.
Future<void> _loadMaterialIcons() async {
  final root = Platform.environment['FLUTTER_ROOT'];
  final font = File(
    '$root/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
  );
  if (root == null || !font.existsSync()) return;
  final loader = FontLoader('MaterialIcons')
    ..addFont(Future.value(ByteData.sublistView(font.readAsBytesSync())));
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
