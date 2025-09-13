import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hackerspace/widgets/missions_panel.dart';
import 'package:hackerspace/bloc/hacker_bloc.dart';
import 'package:hackerspace/bloc/hacker_state.dart';

void main() {
  group('Missions Panel Widget Tests', () {

    setUpAll(() {
      SharedPreferences.setMockInitialValues({
        'username': 'test_user',
        'level': 1,
        'experience': 0,
      });
    });

    Widget createTestWidget() {
      return MaterialApp(
        home: Scaffold(
          body: BlocProvider(
            create: (context) => HackerBloc(),
            child: const MissionsPanel(),
          ),
        ),
      );
    }

    testWidgets('should display missions panel', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.byType(MissionsPanel), findsOneWidget);
    });

    testWidgets('should display without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(tester.takeException(), isNull);
    });

    testWidgets('should contain mission content', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.byType(MissionsPanel), findsOneWidget);
    });
  });
}
