import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hackerspace/main.dart' as app;
import 'package:hackerspace/bloc/hacker_event.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('HackerSpace Integration Tests', () {
    testWidgets('complete user login flow', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Find login form elements
      expect(find.byType(TextFormField), findsWidgets);

      // Enter username and password
      final usernameField = find.byType(TextFormField).first;
      final passwordField = find.byType(TextFormField).last;

      await tester.enterText(usernameField, 'test_hacker');
      await tester.enterText(passwordField, 'password123');

      // Submit login
      await tester.tap(find.textContaining('LOGIN'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify login success
      expect(find.textContaining('test_hacker'), findsWidgets);
      expect(find.textContaining('Welcome'), findsWidgets);
    });

    testWidgets('execute terminal commands', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Assume user is logged in
      await _performLogin(tester);

      // Find terminal input
      final terminalInput = find.byType(TextFormField);
      expect(terminalInput, findsWidgets);

      // Execute help command
      await tester.enterText(terminalInput.first, 'help');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Verify help output
      expect(find.textContaining('Available commands'), findsWidgets);

      // Execute scan command
      await tester.enterText(terminalInput.first, 'scan');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Verify scan output
      expect(find.textContaining('scan'), findsWidgets);
    });

    testWidgets('toggle system modes', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await _performLogin(tester);

      // Execute matrix mode command
      final terminalInput = find.byType(TextFormField).first;
      await tester.enterText(terminalInput, 'matrix');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Verify matrix mode activation
      expect(find.textContaining('Matrix'), findsWidgets);

      // Execute ghost mode command
      await tester.enterText(terminalInput, 'ghost');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Verify ghost mode activation
      expect(find.textContaining('Ghost Protocol'), findsWidgets);
    });

    testWidgets('mission workflow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await _performLogin(tester);

      // Navigate to missions
      final terminalInput = find.byType(TextFormField).first;
      await tester.enterText(terminalInput, 'missions');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Verify missions are displayed
      expect(find.textContaining('Available Missions'), findsWidgets);

      // Start a mission if available
      final startButton = find.textContaining('START');
      if (startButton.evaluate().isNotEmpty) {
        await tester.tap(startButton.first);
        await tester.pumpAndSettle();

        // Verify mission started
        expect(find.textContaining('Starting mission'), findsWidgets);
      }
    });

    testWidgets('network scanning workflow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await _performLogin(tester);

      // Execute network scan
      final terminalInput = find.byType(TextFormField).first;
      await tester.enterText(terminalInput, 'network');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Verify network map is displayed
      expect(find.textContaining('Network'), findsWidgets);
    });

    testWidgets('data stream updates', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await _performLogin(tester);

      // Wait for automated data stream updates
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // Verify data stream panel has content
      expect(find.textContaining('DATA STREAM'), findsWidgets);
    });

    testWidgets('system integrity monitoring', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await _performLogin(tester);

      // Perform actions that affect system integrity
      final terminalInput = find.byType(TextFormField).first;
      await tester.enterText(terminalInput, 'hack target-1');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Wait for system integrity updates
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      // Verify system integrity is displayed
      expect(find.textContaining('%'), findsWidgets);
    });

    testWidgets('achievement system', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await _performLogin(tester);

      // Perform actions to gain experience
      final terminalInput = find.byType(TextFormField).first;
      await tester.enterText(terminalInput, 'scan');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Wait for experience gain
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      // Check for experience or level up messages
      expect(find.textContaining('XP'), findsWidgets);
    });

    testWidgets('error handling', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await _performLogin(tester);

      // Execute invalid command
      final terminalInput = find.byType(TextFormField).first;
      await tester.enterText(terminalInput, 'invalid_command_xyz');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Verify error message
      expect(find.textContaining('Command not found'), findsWidgets);
    });

    testWidgets('logout workflow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await _performLogin(tester);

      // Execute logout command
      final terminalInput = find.byType(TextFormField).first;
      await tester.enterText(terminalInput, 'exit');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Verify logout
      expect(find.textContaining('Session terminated'), findsWidgets);
    });
  });
}

// Helper function to perform login
Future<void> _performLogin(WidgetTester tester) async {
  // Check if already logged in
  if (find.textContaining('Welcome').evaluate().isNotEmpty) {
    return;
  }

  // Find login elements and perform login
  final textFields = find.byType(TextFormField);
  if (textFields.evaluate().length >= 2) {
    await tester.enterText(textFields.first, 'test_user');
    await tester.enterText(textFields.last, 'password123');

    final loginButton = find.textContaining('LOGIN');
    if (loginButton.evaluate().isNotEmpty) {
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));
    }
  }
}
