# beneathsos_ui

[![CI](https://github.com/Berkant35/beneathsos_ui/actions/workflows/ci.yml/badge.svg)](https://github.com/Berkant35/beneathsos_ui/actions/workflows/ci.yml)
[![License: Apache 2.0](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)

Design system of [BeneathSOS](https://github.com/Berkant35/beneathsos): brand tokens, a light and a
dark Material 3 theme, the bundled Atkinson Hyperlegible Next typeface, the logo and core components.
Built for people at a collapsed building in an emergency — high contrast, large targets, calm.

```dart
MaterialApp(theme: BeneathTheme.light(), darkTheme: BeneathTheme.dark(), ...);
```

## Rules
- Colours come from the theme. Orange (`BeneathTokens.accent`) is a fill behind dark content only;
  never orange text or icons on a light background.
- At most one `PrimaryButton` per screen, in the bottom half.
- Use `StatusBanner` for state — what happened, then what to do; `blocked` (red) only when something
  blocks the task. Every kind has its own icon, never colour alone.
- Design guidance: [`docs/design/`](https://github.com/Berkant35/beneathsos/tree/main/docs/design)
  and [ADR 0018](https://github.com/Berkant35/beneathsos/blob/main/docs/adr/0018-design-system-material-theme.md).

## Catalogue
Every component in light and dark, at 100–200 % text size, with knobs:
`cd widgetbook && fvm flutter run -d chrome` (or `fvm flutter build web`). The catalogue is a separate
app (`widgetbook/`) and is not part of the published package.

## Development
- Fonts are generated in the hub: `tools/brand/build.py --fonts-dir packages/beneathsos_ui/fonts`.
- Golden tests (tag `golden`) run on macOS: `fvm flutter test --tags golden`;
  update with `--update-goldens`. Linux skips them (`dart_test.yaml`).

Licence: Apache-2.0. Atkinson Hyperlegible Next: SIL Open Font License 1.1 (`fonts/OFL.txt`).
