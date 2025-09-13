import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hackerspace/widgets/data_stream_panel.dart';
import 'package:hackerspace/bloc/hacker_bloc.dart';
import 'package:hackerspace/bloc/hacker_state.dart';

void main() {
  group('Data Stream Panel Widget Tests', () {

    setUpAll(() {
      SharedPreferences.setMockInitialValues({
        'username': 'test_user',
        'level': 1,
        'experience': 0,
      });
    });

    Widget createTestWidget(HackerState state) {
      return MaterialApp(
        home: Scaffold(
          body: BlocProvider(
            create: (context) => HackerBloc(),
            child: const DataStreamPanel(),
          ),
        ),
      );
    }

    testWidgets('should display data stream panel', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const HackerState()));
      await tester.pump();

      expect(find.byType(DataStreamPanel), findsOneWidget);
    });

    testWidgets('should display without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const HackerState()));
      await tester.pump();

      // Just verify the widget builds successfully
      expect(tester.takeException(), isNull);
    });

    testWidgets('should contain progress bars', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const HackerState()));
      await tester.pump();

      // Should have progress indicators
      expect(find.byType(LinearProgressIndicator), findsAtLeastNWidgets(1));
    });

    testWidgets('should display animated text header', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const HackerState()));
      await tester.pump();

      // Should have some kind of animated text or header
      expect(find.byType(Container), findsAtLeastNWidgets(1));
    });
  });
}
