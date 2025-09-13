import 'package:flutter_test/flutter_test.dart';
import 'package:hackerspace/bloc/hacker_bloc.dart';
import 'package:hackerspace/bloc/hacker_event.dart';
import 'package:hackerspace/bloc/hacker_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('HackerBloc Performance Tests', () {
    late HackerBloc hackerBloc;

    setUpAll(() {
      SharedPreferences.setMockInitialValues({
        'username': 'test_user',
        'level': 1,
        'experience': 0,
      });
    });

    setUp(() {
      hackerBloc = HackerBloc();
    });

    tearDown(() {
      hackerBloc.close();
    });

    test('should handle rapid command execution efficiently', () async {
      final stopwatch = Stopwatch()..start();

      final events = [
        const ExecuteCommand('help'),
        const ExecuteCommand('scan'),
        const ExecuteCommand('missions'),
        const ExecuteCommand('tools'),
        const ExecuteCommand('network'),
      ];

      for (final event in events) {
        hackerBloc.add(event);
        await Future.delayed(const Duration(milliseconds: 10));
      }

      stopwatch.stop();

      // Should complete within reasonable time
      expect(stopwatch.elapsedMilliseconds, lessThan(5000));
    });

    test('should handle experience gain calculations efficiently', () async {
      final stopwatch = Stopwatch()..start();

      // Rapid experience gains
      for (int i = 0; i < 10; i++) {
        hackerBloc.add(GainExperience(i * 10 + 10));
        await Future.delayed(const Duration(milliseconds: 1));
      }

      stopwatch.stop();

      // Should complete within reasonable time
      expect(stopwatch.elapsedMilliseconds, lessThan(1000));
    });

    test('should handle state updates efficiently', () async {
      final stopwatch = Stopwatch()..start();

      // Multiple state-changing events
      hackerBloc.add(const ToggleMatrixMode());
      hackerBloc.add(const ToggleGhostMode());
      hackerBloc.add(const ToggleRedAlert());
      hackerBloc.add(const ScanNetwork());
      hackerBloc.add(const UpdateDataStream());

      await Future.delayed(const Duration(milliseconds: 100));

      stopwatch.stop();

      // Should complete within reasonable time
      expect(stopwatch.elapsedMilliseconds, lessThan(2000));
    });

    test('should maintain performance with large terminal output', () async {
      final stopwatch = Stopwatch()..start();

      // Add many terminal outputs
      for (int i = 0; i < 50; i++) {
        hackerBloc.add(AddTerminalOutput('Test message $i'));
        if (i % 10 == 0) {
          await Future.delayed(const Duration(milliseconds: 1));
        }
      }

      stopwatch.stop();

      // Should complete within reasonable time
      expect(stopwatch.elapsedMilliseconds, lessThan(3000));
    });
  });
}
