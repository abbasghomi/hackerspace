import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hackerspace/main.dart';
import 'package:hackerspace/bloc/hacker_bloc.dart';

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({
      'username': 'test_user',
      'level': 1,
      'experience': 0,
    });
  });

  testWidgets('HackerSpace app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const HackerSpaceApp());
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(BlocProvider<HackerBloc>), findsOneWidget);
  });

  testWidgets('App displays without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const HackerSpaceApp());
    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}
