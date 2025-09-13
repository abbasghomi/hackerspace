import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hackerspace/models/hacker_models.dart';
import 'package:hackerspace/bloc/hacker_state.dart';
import 'package:hackerspace/bloc/hacker_bloc.dart';

// Test utilities and helpers for the HackerSpace app

/// Mock data factory for creating test objects
class TestDataFactory {
  static HackerUser createTestUser({
    String? id,
    String? username,
    int? level,
    int? experience,
    List<String>? achievements,
    UserStatus? status,
  }) {
    return HackerUser(
      id: id ?? 'test-user-id',
      username: username ?? 'test_hacker',
      level: level ?? 1,
      experience: experience ?? 0,
      achievements: achievements ?? const [],
      lastLoginTime: DateTime(2025, 1, 1),
      status: status ?? UserStatus.normal,
    );
  }

  static Mission createTestMission({
    String? id,
    String? name,
    MissionType? type,
    int? difficulty,
    int? reward,
    bool? isCompleted,
  }) {
    return Mission(
      id: id ?? 'test-mission-id',
      name: name ?? 'Test Mission',
      description: 'Test mission description',
      type: type ?? MissionType.infiltration,
      difficulty: difficulty ?? 5,
      reward: reward ?? 100,
      requirements: const ['stealth'],
      isCompleted: isCompleted ?? false,
    );
  }

  static Target createTestTarget({
    String? id,
    String? name,
    String? ipAddress,
    int? securityLevel,
    TargetStatus? status,
  }) {
    return Target(
      id: id ?? 'test-target-id',
      name: name ?? 'Test Server',
      ipAddress: ipAddress ?? '192.168.1.100',
      securityLevel: securityLevel ?? 5,
      status: status ?? TargetStatus.scanning,
      vulnerabilities: const ['CVE-2023-1234'],
      exploitData: const {},
      lastScanned: DateTime(2025, 1, 1),
    );
  }

  static Tool createTestTool({
    String? id,
    String? name,
    ToolType? type,
    int? powerLevel,
    bool? isUnlocked,
  }) {
    return Tool(
      id: id ?? 'test-tool-id',
      name: name ?? 'Test Tool',
      description: 'Test tool description',
      type: type ?? ToolType.scanner,
      powerLevel: powerLevel ?? 5,
      isUnlocked: isUnlocked ?? true,
      requiredSkills: const ['networking'],
    );
  }

  static NetworkNode createTestNetworkNode({
    String? id,
    String? address,
    NodeType? type,
    int? securityLevel,
    bool? isCompromised,
  }) {
    return NetworkNode(
      id: id ?? 'test-node-id',
      address: address ?? '192.168.1.1',
      type: type ?? NodeType.router,
      securityLevel: securityLevel ?? 5,
      isCompromised: isCompromised ?? false,
      connectedNodes: const [],
      metadata: const {},
    );
  }

  static HackerState createTestState({
    HackerUser? user,
    List<String>? terminalOutput,
    List<Mission>? missions,
    List<Target>? targets,
    List<Tool>? tools,
    List<NetworkNode>? networkNodes,
    bool? isMatrixMode,
    bool? isGhostMode,
    bool? isRedAlert,
    double? systemIntegrity,
  }) {
    return HackerState(
      user: user,
      terminalOutput: terminalOutput ?? const [],
      missions: missions ?? const [],
      targets: targets ?? const [],
      tools: tools ?? const [],
      networkNodes: networkNodes ?? const [],
      isMatrixMode: isMatrixMode ?? false,
      isGhostMode: isGhostMode ?? false,
      isRedAlert: isRedAlert ?? false,
      systemIntegrity: systemIntegrity ?? 100.0,
    );
  }
}

/// Custom matchers for testing
Matcher hasTerminalOutput(String output) {
  return predicate<HackerState>(
    (state) => state.terminalOutput.any((line) => line.contains(output)),
    'has terminal output containing "$output"',
  );
}

Matcher hasUserWithLevel(int level) {
  return predicate<HackerState>(
    (state) => state.user?.level == level,
    'has user with level $level',
  );
}

Matcher hasSystemIntegrity(double integrity) {
  return predicate<HackerState>(
    (state) => state.systemIntegrity == integrity,
    'has system integrity of $integrity',
  );
}

Matcher hasActiveHack(String hack) {
  return predicate<HackerState>(
    (state) => state.activeHacks.contains(hack),
    'has active hack "$hack"',
  );
}

Matcher hasMissionWithId(String missionId) {
  return predicate<HackerState>(
    (state) => state.missions.any((mission) => mission.id == missionId),
    'has mission with id "$missionId"',
  );
}

/// Test expectations helpers
class TestExpectations {
  static void expectUserLoggedIn(HackerState state, String username) {
    expect(state.user, isNotNull);
    expect(state.user!.username, username);
    expect(state.terminalOutput, isNotEmpty);
  }

  static void expectCommandExecuted(HackerState state, String command) {
    expect(
      state.terminalOutput.any((output) => output.contains('> $command')),
      true,
      reason: 'Command "$command" should appear in terminal output',
    );
  }

  static void expectExperienceGained(HackerState oldState, HackerState newState) {
    expect(newState.user?.experience, greaterThan(oldState.user?.experience ?? 0));
  }

  static void expectSystemCompromised(HackerState state) {
    expect(state.systemIntegrity, lessThan(100.0));
    expect(state.activeHacks, isNotEmpty);
  }

  static void expectMissionCompleted(HackerState state, String missionId) {
    final mission = state.missions.firstWhere((m) => m.id == missionId);
    expect(mission.isCompleted, true);
    expect(mission.completedAt, isNotNull);
  }
}

/// Mock implementations for testing
class MockHackerBloc extends Mock implements HackerBloc {}

/// Test groups for common scenarios
void runBasicBlocTests(String description, HackerBloc Function() createBloc) {
  group(description, () {
    late HackerBloc bloc;

    setUp(() {
      bloc = createBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is correct', () {
      expect(bloc.state, const HackerState());
    });

    test('bloc can be closed', () {
      expect(() => bloc.close(), returnsNormally);
    });
  });
}

/// Performance test helpers
class PerformanceTestHelpers {
  static Future<void> measureBlocPerformance(
    HackerBloc bloc,
    List<dynamic> events, {
    Duration? timeout,
  }) async {
    final stopwatch = Stopwatch()..start();

    for (final event in events) {
      bloc.add(event);
      await Future.delayed(const Duration(milliseconds: 10));
    }

    await bloc.stream.take(events.length).last.timeout(
      timeout ?? const Duration(seconds: 5),
    );

    stopwatch.stop();

    print('Performance test completed in ${stopwatch.elapsedMilliseconds}ms');
    expect(stopwatch.elapsedMilliseconds, lessThan(5000));
  }
}

/// Widget testing helpers
class WidgetTestHelpers {
  static Future<void> enterTextAndSubmit(
    WidgetTester tester,
    Finder textField,
    String text,
  ) async {
    await tester.enterText(textField, text);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
  }

  static Future<void> waitForAnimations(WidgetTester tester) async {
    await tester.pumpAndSettle(const Duration(milliseconds: 500));
  }

  static Finder findTextContaining(String text) {
    return find.byWidgetPredicate((widget) {
      if (widget is Text) {
        return widget.data?.contains(text) == true;
      }
      return false;
    });
  }
}

/// Integration test helpers
class IntegrationTestHelpers {
  static Future<void> completeUserFlow(
    WidgetTester tester, {
    required String username,
    required String password,
    required List<String> commands,
  }) async {
    // Login
    await _login(tester, username, password);

    // Execute commands
    for (final command in commands) {
      await _executeCommand(tester, command);
    }
  }

  static Future<void> _login(
    WidgetTester tester,
    String username,
    String password,
  ) async {
    final usernameField = find.byType(TextFormField).first;
    final passwordField = find.byType(TextFormField).last;

    await tester.enterText(usernameField, username);
    await tester.enterText(passwordField, password);
    await tester.tap(find.textContaining('LOGIN'));
    await tester.pumpAndSettle(const Duration(seconds: 3));
  }

  static Future<void> _executeCommand(
    WidgetTester tester,
    String command,
  ) async {
    final terminalInput = find.byType(TextFormField).first;
    await WidgetTestHelpers.enterTextAndSubmit(tester, terminalInput, command);
    await WidgetTestHelpers.waitForAnimations(tester);
  }
}
