import 'package:beneathsos_catalogue/flows/ambient_scan.dart';
import 'package:beneathsos_catalogue/flows/choose_target.dart';
import 'package:beneathsos_catalogue/flows/first_run_notice.dart';
import 'package:beneathsos_catalogue/flows/measurement.dart';
import 'package:beneathsos_catalogue/flows/probability_map.dart';
import 'package:beneathsos_catalogue/flows/rubble_site.dart';
import 'package:beneathsos_catalogue/flows/victim_mode.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

/// Every mockup screen in journey order (name, widget).
const flowScreens = <(String, Widget)>[
  ('1 First-run notice', FirstRunNoticeMockup()),
  ('2 Rubble site', RubbleSiteMockup()),
  ('3 Ambient scan', AmbientScanMockup()),
  ('4 Choose the target', ChooseTargetMockup()),
  ('5 Measurement', MeasurementMockup()),
  ('6 Probability map', ProbabilityMapMockup()),
  ('7 Victim mode', VictimModeMockup()),
];

/// Roadmap 1.4: rescuer and victim journeys for review before any screen is built.
final flowsCategory = WidgetbookCategory(
  name: 'Flows (mockups)',
  children: [
    for (final (name, screen) in flowScreens)
      WidgetbookComponent(
        name: name,
        useCases: [
          WidgetbookUseCase(name: 'Mockup', builder: (context) => screen),
        ],
      ),
  ],
);
