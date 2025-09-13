import 'package:flutter_test/flutter_test.dart';
import 'package:hackerspace/bloc/hacker_state.dart';
import 'package:hackerspace/models/hacker_models.dart';

void main() {
  group('HackerState', () {
    test('should create initial state with default values', () {
      const state = HackerState();

      expect(state.user, null);
      expect(state.terminalOutput, []);
      expect(state.dataStream, []);
      expect(state.systemLogs, []);
      expect(state.networkTraffic, []);
      expect(state.missions, []);
      expect(state.targets, []);
      expect(state.tools, []);
      expect(state.networkNodes, []);
      expect(state.activeHacks, []);
      expect(state.systemIntegrity, 100.0);
      expect(state.isMatrixMode, false);
      expect(state.isGhostMode, false);
      expect(state.isRedAlert, false);
      expect(state.isSystemTakeover, false);
      expect(state.cryptoAnalysis, {});
      expect(state.malwareData, {});
      expect(state.blockchainData, {});
      expect(state.neuralNetworkData, {});
      expect(state.hackingLevel, 1);
      expect(state.currentCommand, '');
      expect(state.isLoading, false);
      expect(state.error, null);
    });

    test('should create state with custom values', () {
      final user = HackerUser(
        id: 'test-id',
        username: 'test_user',
        level: 5,
        experience: 1000,
        achievements: const ['first_hack'],
        lastLoginTime: DateTime(2025, 1, 1),
        status: UserStatus.ghost,
      );

      final state = HackerState(
        user: user,
        terminalOutput: ['Welcome to HackerSpace'],
        systemIntegrity: 75.5,
        isMatrixMode: true,
        hackingLevel: 5,
        isLoading: true,
        error: 'Connection failed',
      );

      expect(state.user, user);
      expect(state.terminalOutput, ['Welcome to HackerSpace']);
      expect(state.systemIntegrity, 75.5);
      expect(state.isMatrixMode, true);
      expect(state.hackingLevel, 5);
      expect(state.isLoading, true);
      expect(state.error, 'Connection failed');
    });

    test('should support copyWith method for user updates', () {
      const initialState = HackerState();

      final user = HackerUser(
        id: 'test-id',
        username: 'new_user',
        level: 3,
        experience: 500,
        achievements: const [],
        lastLoginTime: DateTime(2025, 1, 1),
        status: UserStatus.normal,
      );

      final updatedState = initialState.copyWith(user: user);

      expect(updatedState.user, user);
      expect(updatedState.terminalOutput, initialState.terminalOutput);
      expect(updatedState.systemIntegrity, initialState.systemIntegrity);
    });

    test('should support copyWith method for terminal output', () {
      const initialState = HackerState(terminalOutput: ['Initial message']);

      final updatedState = initialState.copyWith(
        terminalOutput: ['Initial message', 'New command executed'],
      );

      expect(updatedState.terminalOutput, ['Initial message', 'New command executed']);
      expect(updatedState.user, initialState.user);
    });

    test('should support copyWith method for system states', () {
      const initialState = HackerState();

      final updatedState = initialState.copyWith(
        isMatrixMode: true,
        isGhostMode: true,
        isRedAlert: true,
        systemIntegrity: 50.0,
      );

      expect(updatedState.isMatrixMode, true);
      expect(updatedState.isGhostMode, true);
      expect(updatedState.isRedAlert, true);
      expect(updatedState.systemIntegrity, 50.0);
    });

    test('should support copyWith method for collections', () {
      const initialState = HackerState();

      final mission = Mission(
        id: 'mission-1',
        name: 'Test Mission',
        description: 'Test description',
        type: MissionType.infiltration,
        difficulty: 5,
        reward: 100,
        requirements: const [],
      );

      final target = Target(
        id: 'target-1',
        name: 'Test Target',
        ipAddress: '192.168.1.1',
        securityLevel: 5,
        status: TargetStatus.scanning,
        vulnerabilities: const [],
        exploitData: const {},
        lastScanned: DateTime(2025, 1, 1),
      );

      const tool = Tool(
        id: 'nmap',
        name: 'Nmap',
        description: 'Network scanner',
        type: ToolType.scanner,
        powerLevel: 5,
        requiredSkills: [],
      );

      const networkNode = NetworkNode(
        id: 'node-1',
        address: '192.168.1.1',
        type: NodeType.router,
        securityLevel: 5,
        connectedNodes: [],
        metadata: {},
      );

      final updatedState = initialState.copyWith(
        missions: [mission],
        targets: [target],
        tools: [tool],
        networkNodes: [networkNode],
        activeHacks: ['SYSTEM_BREACH'],
      );

      expect(updatedState.missions, [mission]);
      expect(updatedState.targets, [target]);
      expect(updatedState.tools, [tool]);
      expect(updatedState.networkNodes, [networkNode]);
      expect(updatedState.activeHacks, ['SYSTEM_BREACH']);
    });

    test('should support copyWith method for data maps', () {
      const initialState = HackerState();

      final updatedState = initialState.copyWith(
        cryptoAnalysis: {'AES-256': 'cracked'},
        malwareData: {'trojan_1': 'analyzed'},
        blockchainData: {'bitcoin_addr': 'traced'},
        neuralNetworkData: {'cnn_1': 'trained'},
      );

      expect(updatedState.cryptoAnalysis, {'AES-256': 'cracked'});
      expect(updatedState.malwareData, {'trojan_1': 'analyzed'});
      expect(updatedState.blockchainData, {'bitcoin_addr': 'traced'});
      expect(updatedState.neuralNetworkData, {'cnn_1': 'trained'});
    });

    test('should support copyWith method for data streams', () {
      const initialState = HackerState();

      final updatedState = initialState.copyWith(
        dataStream: ['Data packet intercepted'],
        systemLogs: ['[INFO] System started'],
        networkTraffic: ['192.168.1.1 -> 192.168.1.2'],
      );

      expect(updatedState.dataStream, ['Data packet intercepted']);
      expect(updatedState.systemLogs, ['[INFO] System started']);
      expect(updatedState.networkTraffic, ['192.168.1.1 -> 192.168.1.2']);
    });

    test('should support copyWith method for loading and error states', () {
      const initialState = HackerState();

      final loadingState = initialState.copyWith(isLoading: true);
      expect(loadingState.isLoading, true);
      expect(loadingState.error, null);

      final errorState = loadingState.copyWith(
        isLoading: false,
        error: 'Network connection failed',
      );
      expect(errorState.isLoading, false);
      expect(errorState.error, 'Network connection failed');
    });

    test('should support equality comparison', () {
      const state1 = HackerState(
        systemIntegrity: 100.0,
        isMatrixMode: false,
        hackingLevel: 1,
      );

      const state2 = HackerState(
        systemIntegrity: 100.0,
        isMatrixMode: false,
        hackingLevel: 1,
      );

      expect(state1, equals(state2));
    });

    test('should not be equal with different properties', () {
      const state1 = HackerState(systemIntegrity: 100.0);
      const state2 = HackerState(systemIntegrity: 50.0);

      expect(state1, isNot(equals(state2)));
    });

    test('should include all properties in props for equality', () {
      final user = HackerUser(
        id: 'test-id',
        username: 'test_user',
        level: 1,
        experience: 0,
        achievements: const [],
        lastLoginTime: DateTime(2025, 1, 1),
        status: UserStatus.normal,
      );

      final state = HackerState(
        user: user,
        terminalOutput: ['test'],
        dataStream: ['data'],
        systemLogs: ['log'],
        networkTraffic: ['traffic'],
        missions: const [],
        targets: const [],
        tools: const [],
        networkNodes: const [],
        activeHacks: ['hack'],
        systemIntegrity: 75.0,
        isMatrixMode: true,
        isGhostMode: false,
        isRedAlert: true,
        isSystemTakeover: false,
        cryptoAnalysis: const {'test': 'value'},
        malwareData: const {'malware': 'data'},
        blockchainData: const {'blockchain': 'info'},
        neuralNetworkData: const {'neural': 'network'},
        hackingLevel: 5,
        currentCommand: 'scan',
        isLoading: true,
        error: 'test error',
      );

      // Verify all properties are included in props
      final props = state.props;
      expect(props.length, 23); // Should include all properties
      expect(props.contains(user), true);
      expect(props.contains(state.terminalOutput), true);
      expect(props.contains(state.systemIntegrity), true);
      expect(props.contains(state.isMatrixMode), true);
    });

    test('should maintain immutability when copying with null values', () {
      final user = HackerUser(
        id: 'test-id',
        username: 'test_user',
        level: 1,
        experience: 0,
        achievements: const [],
        lastLoginTime: DateTime(2025, 1, 1),
        status: UserStatus.normal,
      );

      final initialState = HackerState(
        user: user,
        isMatrixMode: true,
        systemIntegrity: 50.0,
      );

      final copiedState = initialState.copyWith(
        terminalOutput: ['new output'],
        // user and other properties should remain the same
      );

      expect(copiedState.user, user);
      expect(copiedState.isMatrixMode, true);
      expect(copiedState.systemIntegrity, 50.0);
      expect(copiedState.terminalOutput, ['new output']);
    });
  });
}
