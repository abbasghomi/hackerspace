import 'package:equatable/equatable.dart';
import '../models/hacker_models.dart';

class HackerState extends Equatable {
  final HackerUser? user;
  final List<String> terminalOutput;
  final List<String> dataStream;
  final List<String> systemLogs;
  final List<String> networkTraffic;
  final List<Mission> missions;
  final List<Target> targets;
  final List<Tool> tools;
  final List<NetworkNode> networkNodes;
  final List<String> activeHacks;
  final double systemIntegrity;
  final bool isMatrixMode;
  final bool isGhostMode;
  final bool isRedAlert;
  final bool isSystemTakeover;
  final Map<String, dynamic> cryptoAnalysis;
  final Map<String, dynamic> malwareData;
  final Map<String, dynamic> blockchainData;
  final Map<String, dynamic> neuralNetworkData;
  final int hackingLevel;
  final String currentCommand;
  final bool isLoading;
  final String? error;

  const HackerState({
    this.user,
    this.terminalOutput = const [],
    this.dataStream = const [],
    this.systemLogs = const [],
    this.networkTraffic = const [],
    this.missions = const [],
    this.targets = const [],
    this.tools = const [],
    this.networkNodes = const [],
    this.activeHacks = const [],
    this.systemIntegrity = 100.0,
    this.isMatrixMode = false,
    this.isGhostMode = false,
    this.isRedAlert = false,
    this.isSystemTakeover = false,
    this.cryptoAnalysis = const {},
    this.malwareData = const {},
    this.blockchainData = const {},
    this.neuralNetworkData = const {},
    this.hackingLevel = 1,
    this.currentCommand = '',
    this.isLoading = false,
    this.error,
  });

  HackerState copyWith({
    HackerUser? user,
    List<String>? terminalOutput,
    List<String>? dataStream,
    List<String>? systemLogs,
    List<String>? networkTraffic,
    List<Mission>? missions,
    List<Target>? targets,
    List<Tool>? tools,
    List<NetworkNode>? networkNodes,
    List<String>? activeHacks,
    double? systemIntegrity,
    bool? isMatrixMode,
    bool? isGhostMode,
    bool? isRedAlert,
    bool? isSystemTakeover,
    Map<String, dynamic>? cryptoAnalysis,
    Map<String, dynamic>? malwareData,
    Map<String, dynamic>? blockchainData,
    Map<String, dynamic>? neuralNetworkData,
    int? hackingLevel,
    String? currentCommand,
    bool? isLoading,
    String? error,
  }) {
    return HackerState(
      user: user ?? this.user,
      terminalOutput: terminalOutput ?? this.terminalOutput,
      dataStream: dataStream ?? this.dataStream,
      systemLogs: systemLogs ?? this.systemLogs,
      networkTraffic: networkTraffic ?? this.networkTraffic,
      missions: missions ?? this.missions,
      targets: targets ?? this.targets,
      tools: tools ?? this.tools,
      networkNodes: networkNodes ?? this.networkNodes,
      activeHacks: activeHacks ?? this.activeHacks,
      systemIntegrity: systemIntegrity ?? this.systemIntegrity,
      isMatrixMode: isMatrixMode ?? this.isMatrixMode,
      isGhostMode: isGhostMode ?? this.isGhostMode,
      isRedAlert: isRedAlert ?? this.isRedAlert,
      isSystemTakeover: isSystemTakeover ?? this.isSystemTakeover,
      cryptoAnalysis: cryptoAnalysis ?? this.cryptoAnalysis,
      malwareData: malwareData ?? this.malwareData,
      blockchainData: blockchainData ?? this.blockchainData,
      neuralNetworkData: neuralNetworkData ?? this.neuralNetworkData,
      hackingLevel: hackingLevel ?? this.hackingLevel,
      currentCommand: currentCommand ?? this.currentCommand,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    user,
    terminalOutput,
    dataStream,
    systemLogs,
    networkTraffic,
    missions,
    targets,
    tools,
    networkNodes,
    activeHacks,
    systemIntegrity,
    isMatrixMode,
    isGhostMode,
    isRedAlert,
    isSystemTakeover,
    cryptoAnalysis,
    malwareData,
    blockchainData,
    neuralNetworkData,
    hackingLevel,
    currentCommand,
    isLoading,
    error,
  ];
}
