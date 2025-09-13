import 'package:flutter_test/flutter_test.dart';
import 'package:hackerspace/models/hacker_models.dart';

void main() {
  group('HackerUser', () {
    test('should create HackerUser with required properties', () {
      final user = HackerUser(
        id: 'test-id',
        username: 'test_user',
        level: 5,
        experience: 1000,
        achievements: ['first_hack', 'elite_hacker'],
        lastLoginTime: DateTime(2025, 1, 1),
        status: UserStatus.normal,
      );

      expect(user.id, 'test-id');
      expect(user.username, 'test_user');
      expect(user.level, 5);
      expect(user.experience, 1000);
      expect(user.achievements, ['first_hack', 'elite_hacker']);
      expect(user.status, UserStatus.normal);
    });

    test('should support copyWith method', () {
      final user = HackerUser(
        id: 'test-id',
        username: 'test_user',
        level: 5,
        experience: 1000,
        achievements: const [],
        lastLoginTime: DateTime(2025, 1, 1),
        status: UserStatus.normal,
      );

      final updatedUser = user.copyWith(
        level: 6,
        experience: 1500,
        status: UserStatus.ghost,
      );

      expect(updatedUser.id, 'test-id');
      expect(updatedUser.username, 'test_user');
      expect(updatedUser.level, 6);
      expect(updatedUser.experience, 1500);
      expect(updatedUser.status, UserStatus.ghost);
    });

    test('should support equality comparison', () {
      final user1 = HackerUser(
        id: 'test-id',
        username: 'test_user',
        level: 5,
        experience: 1000,
        achievements: const [],
        lastLoginTime: DateTime(2025, 1, 1),
        status: UserStatus.normal,
      );

      final user2 = HackerUser(
        id: 'test-id',
        username: 'test_user',
        level: 5,
        experience: 1000,
        achievements: const [],
        lastLoginTime: DateTime(2025, 1, 1),
        status: UserStatus.normal,
      );

      expect(user1, equals(user2));
    });
  });

  group('Mission', () {
    test('should create Mission with required properties', () {
      final mission = Mission(
        id: 'mission-1',
        name: 'Corporate Infiltration',
        description: 'Hack into corporate server',
        type: MissionType.infiltration,
        difficulty: 8,
        reward: 500,
        requirements: ['stealth', 'social_engineering'],
      );

      expect(mission.id, 'mission-1');
      expect(mission.name, 'Corporate Infiltration');
      expect(mission.type, MissionType.infiltration);
      expect(mission.difficulty, 8);
      expect(mission.reward, 500);
      expect(mission.isCompleted, false);
      expect(mission.completedAt, null);
    });

    test('should support copyWith for completion', () {
      final mission = Mission(
        id: 'mission-1',
        name: 'Test Mission',
        description: 'Test description',
        type: MissionType.infiltration,
        difficulty: 5,
        reward: 100,
        requirements: const [],
      );

      final completedMission = mission.copyWith(
        isCompleted: true,
        completedAt: DateTime(2025, 1, 1),
      );

      expect(completedMission.isCompleted, true);
      expect(completedMission.completedAt, DateTime(2025, 1, 1));
      expect(completedMission.id, mission.id);
    });

    test('should test all MissionType enum values', () {
      expect(MissionType.values, [
        MissionType.infiltration,
        MissionType.cryptography,
        MissionType.socialEngineering,
        MissionType.malwareAnalysis,
        MissionType.networkPenetration,
      ]);
    });
  });

  group('Target', () {
    test('should create Target with required properties', () {
      final target = Target(
        id: 'target-1',
        name: 'Corporate Server',
        ipAddress: '192.168.1.100',
        securityLevel: 8,
        status: TargetStatus.scanning,
        vulnerabilities: ['CVE-2023-1234'],
        exploitData: {'method': 'buffer_overflow'},
        lastScanned: DateTime(2025, 1, 1),
      );

      expect(target.id, 'target-1');
      expect(target.name, 'Corporate Server');
      expect(target.ipAddress, '192.168.1.100');
      expect(target.securityLevel, 8);
      expect(target.status, TargetStatus.scanning);
      expect(target.vulnerabilities, ['CVE-2023-1234']);
    });

    test('should support status changes through copyWith', () {
      final target = Target(
        id: 'target-1',
        name: 'Test Server',
        ipAddress: '192.168.1.1',
        securityLevel: 5,
        status: TargetStatus.scanning,
        vulnerabilities: const [],
        exploitData: const {},
        lastScanned: DateTime(2025, 1, 1),
      );

      final compromisedTarget = target.copyWith(
        status: TargetStatus.compromised,
        exploitData: {'compromise_time': '2025-01-01T12:00:00'},
      );

      expect(compromisedTarget.status, TargetStatus.compromised);
      expect(compromisedTarget.exploitData['compromise_time'], '2025-01-01T12:00:00');
    });

    test('should test all TargetStatus enum values', () {
      expect(TargetStatus.values, [
        TargetStatus.scanning,
        TargetStatus.vulnerable,
        TargetStatus.compromised,
        TargetStatus.secured,
        TargetStatus.offline,
      ]);
    });
  });

  group('Tool', () {
    test('should create Tool with required properties', () {
      const tool = Tool(
        id: 'nmap',
        name: 'Nmap',
        description: 'Network scanner',
        type: ToolType.scanner,
        powerLevel: 7,
        isUnlocked: true,
        requiredSkills: ['networking'],
        usageCount: 5,
      );

      expect(tool.id, 'nmap');
      expect(tool.name, 'Nmap');
      expect(tool.type, ToolType.scanner);
      expect(tool.powerLevel, 7);
      expect(tool.isUnlocked, true);
      expect(tool.usageCount, 5);
    });

    test('should support unlocking through copyWith', () {
      const tool = Tool(
        id: 'metasploit',
        name: 'Metasploit',
        description: 'Exploitation framework',
        type: ToolType.exploiter,
        powerLevel: 9,
        isUnlocked: false,
        requiredSkills: ['exploitation'],
      );

      final unlockedTool = tool.copyWith(isUnlocked: true);

      expect(unlockedTool.isUnlocked, true);
      expect(unlockedTool.id, tool.id);
    });

    test('should test all ToolType enum values', () {
      expect(ToolType.values, [
        ToolType.scanner,
        ToolType.exploiter,
        ToolType.cryptoTool,
        ToolType.socialTool,
        ToolType.stealth,
      ]);
    });
  });

  group('NetworkNode', () {
    test('should create NetworkNode with required properties', () {
      const node = NetworkNode(
        id: 'node-1',
        address: '192.168.1.1',
        type: NodeType.router,
        securityLevel: 6,
        isCompromised: false,
        connectedNodes: ['node-2', 'node-3'],
        metadata: {'manufacturer': 'Cisco'},
      );

      expect(node.id, 'node-1');
      expect(node.address, '192.168.1.1');
      expect(node.type, NodeType.router);
      expect(node.securityLevel, 6);
      expect(node.isCompromised, false);
      expect(node.connectedNodes, ['node-2', 'node-3']);
    });

    test('should support compromise through copyWith', () {
      const node = NetworkNode(
        id: 'node-1',
        address: '192.168.1.1',
        type: NodeType.server,
        securityLevel: 5,
        connectedNodes: [],
        metadata: {},
      );

      final compromisedNode = node.copyWith(
        isCompromised: true,
        metadata: {'compromise_time': '2025-01-01T12:00:00'},
      );

      expect(compromisedNode.isCompromised, true);
      expect(compromisedNode.metadata['compromise_time'], '2025-01-01T12:00:00');
    });

    test('should test all NodeType enum values', () {
      expect(NodeType.values, [
        NodeType.server,
        NodeType.workstation,
        NodeType.router,
        NodeType.firewall,
        NodeType.database,
        NodeType.iot,
      ]);
    });
  });

  group('UserStatus enum', () {
    test('should contain all expected values', () {
      expect(UserStatus.values, [
        UserStatus.ghost,
        UserStatus.matrix,
        UserStatus.normal,
        UserStatus.stealth,
        UserStatus.god,
      ]);
    });
  });
}
