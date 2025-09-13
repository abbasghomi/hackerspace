import 'package:flutter_test/flutter_test.dart';

// Import all test files
import 'models/hacker_models_test.dart' as models_tests;
import 'bloc/hacker_event_test.dart' as event_tests;
import 'bloc/hacker_state_test.dart' as state_tests;
import 'bloc/hacker_bloc_test.dart' as bloc_tests;
import 'bloc/advanced_features_test.dart' as advanced_tests;
import 'widgets/hacker_desktop_test.dart' as desktop_tests;
import 'widgets/terminal_panel_test.dart' as terminal_tests;
import 'widgets/data_stream_panel_test.dart' as stream_tests;
import 'widgets/missions_panel_test.dart' as mission_tests;
import 'performance/performance_test.dart' as performance_tests;

void main() {
  group('HackerSpace Complete Test Suite', () {
    group('Model Tests', () {
      models_tests.main();
    });

    group('BLoC Event Tests', () {
      event_tests.main();
    });

    group('BLoC State Tests', () {
      state_tests.main();
    });

    group('BLoC Logic Tests', () {
      bloc_tests.main();
    });

    group('Advanced Features Tests', () {
      advanced_tests.main();
    });

    group('Widget Tests', () {
      desktop_tests.main();
      terminal_tests.main();
      stream_tests.main();
      mission_tests.main();
    });

    group('Performance Tests', () {
      performance_tests.main();
    });
  });
}
