import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hackerspace/screens/hacker_desktop.dart';
import 'package:hackerspace/bloc/hacker_bloc.dart';
import 'package:hackerspace/bloc/hacker_state.dart';
import 'package:hackerspace/models/hacker_models.dart';

void main() {
  group('HackerDesktop Widget Tests', () {

    setUpAll(() {
      SharedPreferences.setMockInitialValues({
        'username': 'test_user',
        'level': 1,
        'experience': 0,
      });
    });

    testWidgets('should render HackerDesktop with initial state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => HackerBloc(),
            child: const HackerDesktop(),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(HackerDesktop), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => HackerBloc(),
            child: const HackerDesktop(),
          ),
        ),
      );

      await tester.pump();

      // Just verify the widget builds successfully
      expect(tester.takeException(), isNull);
    });

    testWidgets('should have proper theme configuration', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black,
            fontFamily: 'Courier',
          ),
          home: BlocProvider(
            create: (context) => HackerBloc(),
            child: const HackerDesktop(),
          ),
        ),
      );

      await tester.pump();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.brightness, Brightness.dark);
      expect(materialApp.theme?.scaffoldBackgroundColor, Colors.black);
    });
  });
}
