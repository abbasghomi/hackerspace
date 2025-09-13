import 'package:equatable/equatable.dart';

// Enhanced models for the hacker system
class HackerUser extends Equatable {
  final String id;
  final String username;
  final int level;
  final int experience;
  final List<String> achievements;
  final DateTime lastLoginTime;
  final UserStatus status;

  const HackerUser({
    required this.id,
    required this.username,
    required this.level,
    required this.experience,
    required this.achievements,
    required this.lastLoginTime,
    required this.status,
  });

  HackerUser copyWith({
    String? id,
    String? username,
    int? level,
    int? experience,
    List<String>? achievements,
    DateTime? lastLoginTime,
    UserStatus? status,
  }) {
    return HackerUser(
      id: id ?? this.id,
      username: username ?? this.username,
      level: level ?? this.level,
      experience: experience ?? this.experience,
      achievements: achievements ?? this.achievements,
      lastLoginTime: lastLoginTime ?? this.lastLoginTime,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, username, level, experience, achievements, lastLoginTime, status];
}

enum UserStatus { ghost, matrix, normal, stealth, god }

class Mission extends Equatable {
  final String id;
  final String name;
  final String description;
  final MissionType type;
  final int difficulty;
  final int reward;
  final bool isCompleted;
  final DateTime? completedAt;
  final List<String> requirements;

  const Mission({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.difficulty,
    required this.reward,
    this.isCompleted = false,
    this.completedAt,
    required this.requirements,
  });

  Mission copyWith({
    String? id,
    String? name,
    String? description,
    MissionType? type,
    int? difficulty,
    int? reward,
    bool? isCompleted,
    DateTime? completedAt,
    List<String>? requirements,
  }) {
    return Mission(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      difficulty: difficulty ?? this.difficulty,
      reward: reward ?? this.reward,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      requirements: requirements ?? this.requirements,
    );
  }

  @override
  List<Object?> get props => [id, name, description, type, difficulty, reward, isCompleted, completedAt, requirements];
}

enum MissionType { infiltration, cryptography, socialEngineering, malwareAnalysis, networkPenetration }

class Target extends Equatable {
  final String id;
  final String name;
  final String ipAddress;
  final int securityLevel;
  final TargetStatus status;
  final List<String> vulnerabilities;
  final Map<String, dynamic> exploitData;
  final DateTime lastScanned;

  const Target({
    required this.id,
    required this.name,
    required this.ipAddress,
    required this.securityLevel,
    required this.status,
    required this.vulnerabilities,
    required this.exploitData,
    required this.lastScanned,
  });

  Target copyWith({
    String? id,
    String? name,
    String? ipAddress,
    int? securityLevel,
    TargetStatus? status,
    List<String>? vulnerabilities,
    Map<String, dynamic>? exploitData,
    DateTime? lastScanned,
  }) {
    return Target(
      id: id ?? this.id,
      name: name ?? this.name,
      ipAddress: ipAddress ?? this.ipAddress,
      securityLevel: securityLevel ?? this.securityLevel,
      status: status ?? this.status,
      vulnerabilities: vulnerabilities ?? this.vulnerabilities,
      exploitData: exploitData ?? this.exploitData,
      lastScanned: lastScanned ?? this.lastScanned,
    );
  }

  @override
  List<Object?> get props => [id, name, ipAddress, securityLevel, status, vulnerabilities, exploitData, lastScanned];
}

enum TargetStatus { scanning, vulnerable, compromised, secured, offline }

class Tool extends Equatable {
  final String id;
  final String name;
  final String description;
  final ToolType type;
  final int powerLevel;
  final bool isUnlocked;
  final List<String> requiredSkills;
  final int usageCount;

  const Tool({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.powerLevel,
    this.isUnlocked = false,
    required this.requiredSkills,
    this.usageCount = 0,
  });

  Tool copyWith({
    String? id,
    String? name,
    String? description,
    ToolType? type,
    int? powerLevel,
    bool? isUnlocked,
    List<String>? requiredSkills,
    int? usageCount,
  }) {
    return Tool(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      powerLevel: powerLevel ?? this.powerLevel,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      requiredSkills: requiredSkills ?? this.requiredSkills,
      usageCount: usageCount ?? this.usageCount,
    );
  }

  @override
  List<Object?> get props => [id, name, description, type, powerLevel, isUnlocked, requiredSkills, usageCount];
}

enum ToolType { scanner, exploiter, cryptoTool, socialTool, stealth }

class NetworkNode extends Equatable {
  final String id;
  final String address;
  final NodeType type;
  final int securityLevel;
  final bool isCompromised;
  final List<String> connectedNodes;
  final Map<String, dynamic> metadata;

  const NetworkNode({
    required this.id,
    required this.address,
    required this.type,
    required this.securityLevel,
    this.isCompromised = false,
    required this.connectedNodes,
    required this.metadata,
  });

  NetworkNode copyWith({
    String? id,
    String? address,
    NodeType? type,
    int? securityLevel,
    bool? isCompromised,
    List<String>? connectedNodes,
    Map<String, dynamic>? metadata,
  }) {
    return NetworkNode(
      id: id ?? this.id,
      address: address ?? this.address,
      type: type ?? this.type,
      securityLevel: securityLevel ?? this.securityLevel,
      isCompromised: isCompromised ?? this.isCompromised,
      connectedNodes: connectedNodes ?? this.connectedNodes,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [id, address, type, securityLevel, isCompromised, connectedNodes, metadata];
}

enum NodeType { server, workstation, router, firewall, database, iot }
