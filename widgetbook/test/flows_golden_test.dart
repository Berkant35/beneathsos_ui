@Tags(['golden'])
library;

import 'dart:io';

import 'package:beneathsos_catalogue/flows/flows.dart';
import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Loads Atkinson (from the package) and the Material icons, so mockups show real glyphs.
Future<void> _loadFonts() async {
  final atkinson = FontLoader(
    'packages/$beneathFontPackage/$beneathFontFamily',
  );
  for (final style in const ['Regular', 'SemiBold', 'Bold', 'ExtraBold']) {
    final bytes = File('../fonts/AtkinsonHyperlegibleNext-$style.ttf')
        .readAsBytesSync();
    atkinson.addFont(Future.value(ByteData.sublistView(bytes)));
  }
  await atkinson.load();
  final root = Platform.environment['FLUTTER_ROOT'];
  final icons = File(
    '$root/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
  );
  if (root == null || !icons.existsSync()) {
    throw StateError('Material icon font not found under FLUTTER_ROOT=$root');
  }
  final loader = FontLoader('MaterialIcons')
    ..addFont(Future.value(ByteData.sublistView(icons.readAsBytesSync())));
  await loader.load();
}

String _slug(String name) =>
    name.toLowerCase().replaceAll(RegExp('[^a-z0-9]+'), '_');

void main() {
  setUpAll(_loadFonts);

  for (final (name, screen) in flowScreens) {
    for (final dark in [false, true]) {
      testWidgets('$name (${dark ? 'dark' : 'light'})', (tester) async {
        tester.view
          ..physicalSize = const Size(402, 874)
          ..devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        await tester.pumpWidget(
          MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: dark ? BeneathTheme.dark() : BeneathTheme.light(),
            home: screen,
          ),
        );
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile(
            'goldens/flow_${_slug(name)}_${dark ? 'dark' : 'light'}.png',
          ),
        );
      });
    }
  }
}
