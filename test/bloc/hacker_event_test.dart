import 'package:flutter_test/flutter_test.dart';
import 'package:hackerspace/bloc/hacker_event.dart';
import 'package:hackerspace/models/hacker_models.dart';

void main() {
  group('HackerEvent', () {
    group('User Management Events', () {
      test('LoginUser should have correct props', () {
        const event = LoginUser('testuser', 'password123');

        expect(event.username, 'testuser');
        expect(event.password, 'password123');
        expect(event.props, ['testuser', 'password123']);
      });

      test('LogoutUser should be equatable', () {
        const event1 = LogoutUser();
        const event2 = LogoutUser();

        expect(event1, equals(event2));
        expect(event1.props, []);
      });

      test('ChangeUserStatus should have correct props', () {
        const event = ChangeUserStatus(UserStatus.ghost);

        expect(event.status, UserStatus.ghost);
        expect(event.props, [UserStatus.ghost]);
      });

      test('GainExperience should have correct props', () {
        const event = GainExperience(100);

        expect(event.amount, 100);
        expect(event.props, [100]);
      });

      test('UnlockAchievement should have correct props', () {
        const event = UnlockAchievement('First Hack');

        expect(event.achievementName, 'First Hack');
        expect(event.props, ['First Hack']);
      });
    });

    group('Terminal Events', () {
      test('ExecuteCommand should have correct props', () {
        const event = ExecuteCommand('scan network');

        expect(event.command, 'scan network');
        expect(event.props, ['scan network']);
      });

      test('AddTerminalOutput should have correct props', () {
        const event = AddTerminalOutput('Scan complete');

        expect(event.output, 'Scan complete');
        expect(event.props, ['Scan complete']);
      });

      test('ClearTerminal should be equatable', () {
        const event1 = ClearTerminal();
        const event2 = ClearTerminal();

        expect(event1, equals(event2));
      });
    });

    group('Mission Events', () {
      test('LoadMissions should be equatable', () {
        const event1 = LoadMissions();
        const event2 = LoadMissions();

        expect(event1, equals(event2));
      });

      test('StartMission should have correct props', () {
        const event = StartMission('mission-1');

        expect(event.missionId, 'mission-1');
        expect(event.props, ['mission-1']);
      });

      test('CompleteMission should have correct props', () {
        const event = CompleteMission('mission-1');

        expect(event.missionId, 'mission-1');
        expect(event.props, ['mission-1']);
      });
    });

    group('Target Management Events', () {
      test('ScanTarget should have correct props', () {
        const event = ScanTarget('target-1');

        expect(event.targetId, 'target-1');
        expect(event.props, ['target-1']);
      });

      test('ExploitTarget should have correct props', () {
        const event = ExploitTarget(
          targetId: 'target-1',
          exploitType: 'buffer_overflow',
        );

        expect(event.targetId, 'target-1');
        expect(event.exploitType, 'buffer_overflow');
        expect(event.props, ['target-1', 'buffer_overflow']);
      });

      test('AddTarget should have correct props', () {
        const event = AddTarget('Test Server', '192.168.1.1');

        expect(event.name, 'Test Server');
        expect(event.ipAddress, '192.168.1.1');
        expect(event.props, ['Test Server', '192.168.1.1']);
      });
    });

    group('Tool Events', () {
      test('UnlockTool should have correct props', () {
        const event = UnlockTool('nmap');

        expect(event.toolId, 'nmap');
        expect(event.props, ['nmap']);
      });

      test('UseTool should have correct props', () {
        const event = UseTool(toolId: 'nmap', targetId: 'target-1');

        expect(event.toolId, 'nmap');
        expect(event.targetId, 'target-1');
        expect(event.props, ['nmap', 'target-1']);
      });
    });

    group('Network Events', () {
      test('ScanNetwork should be equatable', () {
        const event1 = ScanNetwork();
        const event2 = ScanNetwork();

        expect(event1, equals(event2));
      });

      test('CompromiseNode should have correct props', () {
        const event = CompromiseNode('node-1');

        expect(event.nodeId, 'node-1');
        expect(event.props, ['node-1']);
      });
    });

    group('System Events', () {
      test('ToggleRedAlert should be equatable', () {
        const event1 = ToggleRedAlert();
        const event2 = ToggleRedAlert();

        expect(event1, equals(event2));
      });

      test('ToggleMatrixMode should be equatable', () {
        const event1 = ToggleMatrixMode();
        const event2 = ToggleMatrixMode();

        expect(event1, equals(event2));
      });

      test('ToggleGhostMode should be equatable', () {
        const event1 = ToggleGhostMode();
        const event2 = ToggleGhostMode();

        expect(event1, equals(event2));
      });

      test('UpdateSystemIntegrity should have correct props', () {
        const event = UpdateSystemIntegrity(75.5);

        expect(event.integrity, 75.5);
        expect(event.props, [75.5]);
      });

      test('StartSystemTakeover should be equatable', () {
        const event1 = StartSystemTakeover();
        const event2 = StartSystemTakeover();

        expect(event1, equals(event2));
      });

      test('InitializeSystem should be equatable', () {
        const event1 = InitializeSystem();
        const event2 = InitializeSystem();

        expect(event1, equals(event2));
      });
    });

    group('Data Stream Events', () {
      test('UpdateDataStream should be equatable', () {
        const event1 = UpdateDataStream();
        const event2 = UpdateDataStream();

        expect(event1, equals(event2));
      });

      test('UpdateNetworkTraffic should be equatable', () {
        const event1 = UpdateNetworkTraffic();
        const event2 = UpdateNetworkTraffic();

        expect(event1, equals(event2));
      });

      test('UpdateSystemLogs should be equatable', () {
        const event1 = UpdateSystemLogs();
        const event2 = UpdateSystemLogs();

        expect(event1, equals(event2));
      });
    });

    group('Advanced Events', () {
      test('PerformCryptanalysis should have correct props', () {
        const event = PerformCryptanalysis(
          algorithm: 'AES-256',
          ciphertext: 'encrypted_data',
        );

        expect(event.algorithm, 'AES-256');
        expect(event.ciphertext, 'encrypted_data');
        expect(event.props, ['AES-256', 'encrypted_data']);
      });

      test('ExecuteQuantumDecryption should have correct props', () {
        const event = ExecuteQuantumDecryption('quantum_data');

        expect(event.encryptedData, 'quantum_data');
        expect(event.props, ['quantum_data']);
      });

      test('LaunchSocialEngineering should have correct props', () {
        const event = LaunchSocialEngineering(
          targetId: 'target@company.com',
          method: 'phishing',
        );

        expect(event.targetId, 'target@company.com');
        expect(event.method, 'phishing');
        expect(event.props, ['target@company.com', 'phishing']);
      });

      test('AnalyzeMalware should have correct props', () {
        const event = AnalyzeMalware(
          malwareType: 'ransomware',
          sample: 'sample_hash',
        );

        expect(event.malwareType, 'ransomware');
        expect(event.sample, 'sample_hash');
        expect(event.props, ['ransomware', 'sample_hash']);
      });

      test('CreateBackdoor should have correct props', () {
        const event = CreateBackdoor(
          targetId: 'target-1',
          backdoorType: 'kernel_hook',
        );

        expect(event.targetId, 'target-1');
        expect(event.backdoorType, 'kernel_hook');
        expect(event.props, ['target-1', 'kernel_hook']);
      });

      test('LaunchDDoSAttack should have correct props', () {
        const event = LaunchDDoSAttack(
          targetId: '192.168.1.100',
          attackType: 'volumetric',
        );

        expect(event.targetId, '192.168.1.100');
        expect(event.attackType, 'volumetric');
        expect(event.props, ['192.168.1.100', 'volumetric']);
      });

      test('PerformBlockchainAnalysis should have correct props', () {
        const event = PerformBlockchainAnalysis('Bitcoin', 'wallet_address');

        expect(event.blockchain, 'Bitcoin');
        expect(event.address, 'wallet_address');
        expect(event.props, ['Bitcoin', 'wallet_address']);
      });

      test('ActivateNeuralNetwork should have correct props', () {
        const event = ActivateNeuralNetwork('CNN', 'image_recognition');

        expect(event.networkType, 'CNN');
        expect(event.task, 'image_recognition');
        expect(event.props, ['CNN', 'image_recognition']);
      });
    });

    group('Event Equality', () {
      test('events with same properties should be equal', () {
        const event1 = LoginUser('test', 'pass');
        const event2 = LoginUser('test', 'pass');

        expect(event1, equals(event2));
      });

      test('events with different properties should not be equal', () {
        const event1 = LoginUser('test1', 'pass');
        const event2 = LoginUser('test2', 'pass');

        expect(event1, isNot(equals(event2)));
      });
    });
  });
}
