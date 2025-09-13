import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hacker_event.dart';
import 'hacker_state.dart';
import '../models/hacker_models.dart';

class HackerBloc extends Bloc<HackerEvent, HackerState> {
  Timer? _dataStreamTimer;
  Timer? _systemLogTimer;
  Timer? _networkTimer;
  final Random _random = Random();
  final Uuid _uuid = const Uuid();

  final List<String> _systemMessages = [
    '[SYSTEM] Network scan initiated...',
    '[ALERT] Unauthorized access detected',
    '[INFO] Firewall bypass successful',
    '[WARNING] Connection unstable',
    '[SUCCESS] Target acquired',
    '[ERROR] Permission denied',
    '[TRACE] Packet injection complete',
    '[DEBUG] Buffer overflow detected',
    '[CRITICAL] System compromised',
    '[STATUS] Backdoor installed',
  ];

  final List<String> _dataMessages = [
    'Scanning ports: 21, 22, 23, 25, 53, 80, 110, 443, 993, 995',
    'Exploiting buffer overflow in service...',
    'Cracking password hash: \$1\$salt\$...',
    'Injecting payload into target system',
    'Establishing reverse shell connection',
    'Extracting sensitive data from database',
    'Privilege escalation in progress...',
    'Covering tracks and removing logs',
    'Mission accomplished - exfiltrating data',
    'Connection terminated - ghost mode active',
  ];

  HackerBloc() : super(const HackerState()) {
    on<InitializeSystem>(_onInitializeSystem);
    on<LoginUser>(_onLoginUser);
    on<LogoutUser>(_onLogoutUser);
    on<ChangeUserStatus>(_onChangeUserStatus);
    on<ExecuteCommand>(_onExecuteCommand);
    on<AddTerminalOutput>(_onAddTerminalOutput);
    on<ClearTerminal>(_onClearTerminal);
    on<LoadMissions>(_onLoadMissions);
    on<StartMission>(_onStartMission);
    on<CompleteMission>(_onCompleteMission);
    on<ScanTarget>(_onScanTarget);
    on<ExploitTarget>(_onExploitTarget);
    on<AddTarget>(_onAddTarget);
    on<UnlockTool>(_onUnlockTool);
    on<UseTool>(_onUseTool);
    on<ScanNetwork>(_onScanNetwork);
    on<CompromiseNode>(_onCompromiseNode);
    on<ToggleRedAlert>(_onToggleRedAlert);
    on<ToggleMatrixMode>(_onToggleMatrixMode);
    on<ToggleGhostMode>(_onToggleGhostMode);
    on<UpdateSystemIntegrity>(_onUpdateSystemIntegrity);
    on<StartSystemTakeover>(_onStartSystemTakeover);
    on<GainExperience>(_onGainExperience);
    on<UnlockAchievement>(_onUnlockAchievement);
    on<PerformCryptanalysis>(_onPerformCryptanalysis);
    on<LaunchSocialEngineering>(_onLaunchSocialEngineering);
    on<AnalyzeMalware>(_onAnalyzeMalware);
    on<CreateBackdoor>(_onCreateBackdoor);
    on<LaunchDDoSAttack>(_onLaunchDDoSAttack);
    on<PerformBlockchainAnalysis>(_onPerformBlockchainAnalysis);
    on<ExecuteQuantumDecryption>(_onExecuteQuantumDecryption);
    on<ActivateNeuralNetwork>(_onActivateNeuralNetwork);
    on<UpdateDataStream>(_onUpdateDataStream);
    on<UpdateNetworkTraffic>(_onUpdateNetworkTraffic);
    on<UpdateSystemLogs>(_onUpdateSystemLogs);

    _startAutomatedSystems();
  }

  void _startAutomatedSystems() {
    _dataStreamTimer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      add(UpdateDataStream());
    });

    _systemLogTimer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      add(UpdateSystemLogs());
    });

    _networkTimer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      add(UpdateNetworkTraffic());
    });
  }

  Future<void> _onInitializeSystem(InitializeSystem event, Emitter<HackerState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final prefs = await SharedPreferences.getInstance();
      final username = prefs.getString('username') ?? 'GHOST_PROTOCOL';
      final level = prefs.getInt('level') ?? 1;
      final experience = prefs.getInt('experience') ?? 0;

      final user = HackerUser(
        id: _uuid.v4(),
        username: username,
        level: level,
        experience: experience,
        achievements: const [],
        lastLoginTime: DateTime.now(),
        status: UserStatus.normal,
      );

      final tools = _getInitialTools();
      final missions = _getInitialMissions();
      final targets = _getInitialTargets();
      final networkNodes = _getInitialNetworkNodes();

      emit(state.copyWith(
        user: user,
        tools: tools,
        missions: missions,
        targets: targets,
        networkNodes: networkNodes,
        terminalOutput: [
          'HackerSpace Terminal v3.0.1 - Authenticated',
          'Loading neural network modules...',
          'Establishing secure connection...',
          'Quantum encryption initialized...',
          'Welcome back, ${user.username}',
          'System ready. Type commands to begin.',
          '',
        ],
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> _onLoginUser(LoginUser event, Emitter<HackerState> emit) async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 2));

    if (event.username.isNotEmpty && event.password.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', event.username);

      final user = HackerUser(
        id: _uuid.v4(),
        username: event.username,
        level: 1,
        experience: 0,
        achievements: const [],
        lastLoginTime: DateTime.now(),
        status: UserStatus.normal,
      );

      emit(state.copyWith(
        user: user,
        terminalOutput: [
          ...state.terminalOutput,
          '> login ${event.username}',
          'Authentication successful',
          'Welcome to the matrix, ${event.username}',
        ],
        isLoading: false,
      ));
    } else {
      emit(state.copyWith(
        error: 'Invalid credentials',
        terminalOutput: [
          ...state.terminalOutput,
          '> login ${event.username}',
          'Authentication failed: Invalid credentials',
        ],
        isLoading: false,
      ));
    }
  }

  void _onLogoutUser(LogoutUser event, Emitter<HackerState> emit) {
    emit(state.copyWith(
      user: null,
      terminalOutput: [
        ...state.terminalOutput,
        '> logout',
        'Session terminated',
        'Ghost protocol activated',
      ],
    ));
  }

  void _onChangeUserStatus(ChangeUserStatus event, Emitter<HackerState> emit) {
    if (state.user != null) {
      final updatedUser = state.user!.copyWith(status: event.status);
      emit(state.copyWith(
        user: updatedUser,
        isGhostMode: event.status == UserStatus.ghost,
        isMatrixMode: event.status == UserStatus.matrix,
        terminalOutput: [
          ...state.terminalOutput,
          'Status changed to: ${event.status.name.toUpperCase()}',
        ],
      ));
    }
  }

  void _onExecuteCommand(ExecuteCommand event, Emitter<HackerState> emit) {
    final command = event.command.trim().toLowerCase();
    final newOutput = [...state.terminalOutput, '> ${event.command}'];

    switch (command) {
      case 'help':
        emit(state.copyWith(
          terminalOutput: [
            ...newOutput,
            'Available commands:',
            '  scan - Network vulnerability scan',
            '  crack - Password cracking simulation',
            '  exploit - Run exploit framework',
            '  stealth - Enable stealth mode',
            '  matrix - Enter the matrix',
            '  ghost - Ghost protocol activation',
            '  missions - View available missions',
            '  tools - List available tools',
            '  targets - Show current targets',
            '  network - Display network map',
            '  crypto - Cryptanalysis tools',
            '  malware - Malware analysis lab',
            '  blockchain - Blockchain forensics',
            '  neural - Neural network control',
            '  quantum - Quantum decryption',
            '  social - Social engineering toolkit',
            '  ddos - DDoS attack simulator',
            '  clear - Clear terminal',
            '  exit - Close terminal',
          ],
        ));
        break;

      case 'scan':
        _performNetworkScan(emit);
        break;

      case 'missions':
        _showMissions(emit);
        break;

      case 'tools':
        _showTools(emit);
        break;

      case 'targets':
        _showTargets(emit);
        break;

      case 'network':
        _showNetworkMap(emit);
        break;

      case 'crypto':
        add(PerformCryptanalysis(algorithm: 'AES-256', ciphertext: 'encrypted_data'));
        break;

      case 'malware':
        add(AnalyzeMalware(malwareType: 'trojan', sample: 'suspicious_file_hash'));
        break;

      case 'blockchain':
        add(PerformBlockchainAnalysis('Bitcoin', '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa'));
        break;

      case 'neural':
        add(ActivateNeuralNetwork('Deep Learning', 'pattern_recognition'));
        break;

      case 'social':
        add(LaunchSocialEngineering(targetId: 'target@company.com', method: 'phishing'));
        break;

      case 'ddos':
        add(LaunchDDoSAttack(targetId: '192.168.1.100', attackType: 'volumetric'));
        break;

      case 'ghost':
        add(ToggleGhostMode());
        break;

      case 'matrix':
        add(ToggleMatrixMode());
        break;

      case 'redalert':
        add(ToggleRedAlert());
        break;

      case 'clear':
        add(ClearTerminal());
        break;

      default:
        if (command.startsWith('hack ')) {
          final target = command.substring(5);
          _hackTarget(target, emit);
        } else if (command.startsWith('exploit ')) {
          final targetId = command.substring(8);
          add(ExploitTarget(targetId: targetId, exploitType: 'buffer_overflow'));
        } else {
          emit(state.copyWith(
            terminalOutput: [
              ...newOutput,
              'Command not found: $command',
              'Type "help" for available commands.',
            ],
          ));
        }
    }
  }

  void _performNetworkScan(Emitter<HackerState> emit) {
    emit(state.copyWith(
      terminalOutput: [
        ...state.terminalOutput,
        'Initiating advanced network scan...',
        'Using quantum-enhanced algorithms...',
      ],
    ));

    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (timer.tick > 8) {
        timer.cancel();
        if (!emit.isDone) {
          final vulnerabilities = _random.nextInt(50) + 10;
          emit(state.copyWith(
            terminalOutput: [
              ...state.terminalOutput,
              'Scan complete. $vulnerabilities vulnerabilities found.',
              'High-risk targets identified.',
            ],
          ));
          add(GainExperience(20));
        }
        return;
      }

      if (!emit.isDone) {
        final ip = '${192 + timer.tick}.168.1.${_random.nextInt(255)}';
        emit(state.copyWith(
          terminalOutput: [
            ...state.terminalOutput,
            'Scanning $ip... [${['OPEN', 'FILTERED', 'CLOSED'][_random.nextInt(3)]}]',
          ],
        ));
      }
    });
  }

  void _hackTarget(String target, Emitter<HackerState> emit) {
    emit(state.copyWith(
      terminalOutput: [
        ...state.terminalOutput,
        'Initiating hack on $target...',
        'Deploying advanced payload...',
        'Bypassing security measures...',
        'Access granted. Welcome to $target mainframe.',
      ],
      activeHacks: [...state.activeHacks, target.toUpperCase()],
    ));
    add(GainExperience(50));
  }

  void _showMissions(Emitter<HackerState> emit) {
    final output = [...state.terminalOutput, 'Available Missions:'];
    for (final mission in state.missions) {
      final status = mission.isCompleted ? '[COMPLETED]' : '[AVAILABLE]';
      output.add('${mission.id}: ${mission.name} $status');
      output.add('  Difficulty: ${mission.difficulty}/10 | Reward: ${mission.reward} XP');
    }
    emit(state.copyWith(terminalOutput: output));
  }

  void _showTools(Emitter<HackerState> emit) {
    final output = [...state.terminalOutput, 'Available Tools:'];
    for (final tool in state.tools) {
      final status = tool.isUnlocked ? '[UNLOCKED]' : '[LOCKED]';
      output.add('${tool.name} $status - ${tool.description}');
    }
    emit(state.copyWith(terminalOutput: output));
  }

  void _showTargets(Emitter<HackerState> emit) {
    final output = [...state.terminalOutput, 'Current Targets:'];
    for (final target in state.targets) {
      output.add('${target.name} (${target.ipAddress}) - Security: ${target.securityLevel}/10');
      output.add('  Status: ${target.status.name.toUpperCase()}');
    }
    emit(state.copyWith(terminalOutput: output));
  }

  void _showNetworkMap(Emitter<HackerState> emit) {
    final output = [...state.terminalOutput, 'Network Topology:'];
    for (final node in state.networkNodes) {
      final status = node.isCompromised ? '[COMPROMISED]' : '[SECURE]';
      output.add('${node.address} (${node.type.name}) $status');
    }
    emit(state.copyWith(terminalOutput: output));
  }

  void _onPerformCryptanalysis(PerformCryptanalysis event, Emitter<HackerState> emit) {
    emit(state.copyWith(
      terminalOutput: [
        ...state.terminalOutput,
        'Starting cryptanalysis on ${event.algorithm}...',
        'Quantum algorithms engaged...',
        'Key recovered: 0x${_random.nextInt(0xFFFFFF).toRadixString(16)}',
      ],
      cryptoAnalysis: {
        ...state.cryptoAnalysis,
        event.algorithm: {
          'status': 'cracked',
          'key': _random.nextInt(0xFFFFFF).toRadixString(16),
          'timestamp': DateTime.now().toIso8601String(),
        },
      },
    ));
    add(GainExperience(75));
  }

  void _onAnalyzeMalware(AnalyzeMalware event, Emitter<HackerState> emit) {
    emit(state.copyWith(
      terminalOutput: [
        ...state.terminalOutput,
        'Analyzing malware sample: ${event.sample}',
        'Malware type: ${event.malwareType}',
        'Behavioral analysis in progress...',
        'Threat level: HIGH',
        'Family: Advanced Persistent Threat',
      ],
      malwareData: {
        ...state.malwareData,
        event.sample: {
          'type': event.malwareType,
          'family': 'APT',
          'threat_level': 'HIGH',
          'capabilities': ['keylogger', 'backdoor', 'data_exfiltration'],
          'timestamp': DateTime.now().toIso8601String(),
        },
      },
    ));
    add(GainExperience(40));
  }

  void _onGainExperience(GainExperience event, Emitter<HackerState> emit) {
    if (state.user != null) {
      final newExperience = state.user!.experience + event.amount;
      final newLevel = (newExperience / 100).floor() + 1;

      final updatedUser = state.user!.copyWith(
        experience: newExperience,
        level: newLevel,
      );

      emit(state.copyWith(
        user: updatedUser,
        hackingLevel: newLevel,
        terminalOutput: [
          ...state.terminalOutput,
          '+${event.amount} XP gained',
          if (newLevel > state.user!.level) 'LEVEL UP! Now level $newLevel',
        ],
      ));
    }
  }

  void _onUnlockAchievement(UnlockAchievement event, Emitter<HackerState> emit) {
    if (state.user != null && !state.user!.achievements.contains(event.achievementName)) {
      final updatedUser = state.user!.copyWith(
        achievements: [...state.user!.achievements, event.achievementName],
      );

      emit(state.copyWith(
        user: updatedUser,
        terminalOutput: [
          ...state.terminalOutput,
          '🏆 Achievement Unlocked: ${event.achievementName}',
        ],
      ));
    }
  }

  List<Tool> _getInitialTools() {
    return [
      const Tool(
        id: 'nmap',
        name: 'Nmap',
        description: 'Network discovery and security auditing',
        type: ToolType.scanner,
        powerLevel: 3,
        isUnlocked: true,
        requiredSkills: [],
      ),
      const Tool(
        id: 'metasploit',
        name: 'Metasploit',
        description: 'Penetration testing framework',
        type: ToolType.exploiter,
        powerLevel: 8,
        isUnlocked: false,
        requiredSkills: ['exploitation', 'reverse_engineering'],
      ),
    ];
  }

  List<Mission> _getInitialMissions() {
    return [
      Mission(
        id: 'mission_001',
        name: 'Corporate Infiltration',
        description: 'Penetrate corporate network and extract financial data',
        type: MissionType.infiltration,
        difficulty: 7,
        reward: 500,
        requirements: ['stealth', 'social_engineering'],
      ),
    ];
  }

  List<Target> _getInitialTargets() {
    return [
      Target(
        id: 'target_001',
        name: 'Mega Corp Server',
        ipAddress: '192.168.1.100',
        securityLevel: 8,
        status: TargetStatus.scanning,
        vulnerabilities: ['CVE-2023-1234', 'CVE-2023-5678'],
        exploitData: {},
        lastScanned: DateTime.now(),
      ),
    ];
  }

  List<NetworkNode> _getInitialNetworkNodes() {
    return [
      const NetworkNode(
        id: 'node_001',
        address: '192.168.1.1',
        type: NodeType.router,
        securityLevel: 5,
        connectedNodes: ['node_002', 'node_003'],
        metadata: {'manufacturer': 'Cisco', 'model': 'RV340'},
      ),
    ];
  }

  void _onUpdateDataStream(UpdateDataStream event, Emitter<HackerState> emit) {
    final message = _dataMessages[_random.nextInt(_dataMessages.length)];
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final newStream = [...state.dataStream, '[$timestamp] $message'];

    if (newStream.length > 20) {
      newStream.removeAt(0);
    }

    emit(state.copyWith(dataStream: newStream));
  }

  void _onUpdateSystemLogs(UpdateSystemLogs event, Emitter<HackerState> emit) {
    final message = _systemMessages[_random.nextInt(_systemMessages.length)];
    final time = DateTime.now().toString().substring(11, 19);
    final newLogs = [...state.systemLogs, '$time $message'];

    if (newLogs.length > 15) {
      newLogs.removeAt(0);
    }

    emit(state.copyWith(systemLogs: newLogs));
  }

  void _onUpdateNetworkTraffic(UpdateNetworkTraffic event, Emitter<HackerState> emit) {
    final sourceIP = '192.168.${_random.nextInt(255)}.${_random.nextInt(255)}';
    final destIP = '10.0.${_random.nextInt(255)}.${_random.nextInt(255)}';
    final port = 80 + _random.nextInt(8000);
    final bytes = _random.nextInt(9999);

    final newTraffic = [...state.networkTraffic, '$sourceIP:$port -> $destIP:$port [$bytes bytes]'];

    if (newTraffic.length > 12) {
      newTraffic.removeAt(0);
    }

    emit(state.copyWith(networkTraffic: newTraffic));
  }

  void _onAddTerminalOutput(AddTerminalOutput event, Emitter<HackerState> emit) {
    emit(state.copyWith(
      terminalOutput: [...state.terminalOutput, event.output],
    ));
  }

  void _onClearTerminal(ClearTerminal event, Emitter<HackerState> emit) {
    emit(state.copyWith(
      terminalOutput: [
        'HackerSpace Terminal v3.0.1 - Authenticated',
        'System ready. Type commands to begin.',
        '',
      ],
    ));
  }

  void _onToggleRedAlert(ToggleRedAlert event, Emitter<HackerState> emit) {
    emit(state.copyWith(
      isRedAlert: !state.isRedAlert,
      terminalOutput: [
        ...state.terminalOutput,
        state.isRedAlert ? 'Red alert DEACTIVATED' : 'Red alert ACTIVATED',
        'Security level: ${state.isRedAlert ? 'STANDARD' : 'MAXIMUM'}',
      ],
    ));
  }

  void _onToggleMatrixMode(ToggleMatrixMode event, Emitter<HackerState> emit) {
    emit(state.copyWith(
      isMatrixMode: !state.isMatrixMode,
      terminalOutput: [
        ...state.terminalOutput,
        state.isMatrixMode ? 'Exiting the Matrix...' : 'Welcome to the Matrix...',
        'Reality perception: ${state.isMatrixMode ? 'NORMAL' : 'ALTERED'}',
      ],
    ));
  }

  void _onToggleGhostMode(ToggleGhostMode event, Emitter<HackerState> emit) {
    emit(state.copyWith(
      isGhostMode: !state.isGhostMode,
      terminalOutput: [
        ...state.terminalOutput,
        state.isGhostMode ? 'Ghost Protocol DEACTIVATED' : 'Ghost Protocol ACTIVATED',
        'All traces will be erased...',
      ],
    ));

    if (state.user != null) {
      add(ChangeUserStatus(state.isGhostMode ? UserStatus.normal : UserStatus.ghost));
    }
  }

  void _onUpdateSystemIntegrity(UpdateSystemIntegrity event, Emitter<HackerState> emit) {
    final newIntegrity = (state.systemIntegrity + event.integrity).clamp(0.0, 100.0);
    emit(state.copyWith(
      systemIntegrity: newIntegrity,
      terminalOutput: [
        ...state.terminalOutput,
        'System integrity: ${newIntegrity.toStringAsFixed(1)}%',
        if (newIntegrity < 50) 'WARNING: System compromised!',
      ],
    ));
  }

  void _onStartSystemTakeover(StartSystemTakeover event, Emitter<HackerState> emit) {
    emit(state.copyWith(
      terminalOutput: [
        ...state.terminalOutput,
        'Initiating complete system takeover...',
        'Bypassing all security measures...',
      ],
    ));

    Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (timer.tick > 5) {
        timer.cancel();
        emit(state.copyWith(
          terminalOutput: [
            ...state.terminalOutput,
            'TAKEOVER COMPLETE',
            'You now have FULL CONTROL',
            'Welcome to the machine, ${state.user?.username ?? 'HACKER'}',
          ],
          systemIntegrity: 0,
          isSystemTakeover: true,
          activeHacks: [...state.activeHacks, 'ADMIN_ACCESS', 'ROOT_SHELL', 'KERNEL_CONTROL'],
        ));
        add(GainExperience(200));
        add(UnlockAchievement('System Overlord'));
        return;
      }

      final systems = ['Firewall', 'Antivirus', 'Encryption', 'Authentication', 'Monitoring'];
      emit(state.copyWith(
        terminalOutput: [
          ...state.terminalOutput,
          'Compromising ${systems[timer.tick - 1]}... SUCCESS',
        ],
      ));
    });
  }

  void _onUpdateSystemTakeoverProgress(UpdateSystemTakeoverProgress event, Emitter<HackerState> emit) {
    if (event.step > 5) {
      emit(state.copyWith(
        terminalOutput: [
          ...state.terminalOutput,
          'TAKEOVER COMPLETE',
          'You now have FULL CONTROL',
          'Welcome to the machine, ${state.user?.username ?? 'HACKER'}',
        ],
        systemIntegrity: 0,
        isSystemTakeover: true,
        activeHacks: [...state.activeHacks, 'ADMIN_ACCESS', 'ROOT_SHELL', 'KERNEL_CONTROL'],
      ));
      add(GainExperience(200));
      add(UnlockAchievement('System Overlord'));
    } else {
      final systems = ['Firewall', 'Antivirus', 'Encryption', 'Authentication', 'Monitoring'];
      emit(state.copyWith(
        terminalOutput: [
          ...state.terminalOutput,
          'Compromising ${systems[event.step - 1]}... SUCCESS',
        ],
      ));
    }
  }

  void _onLoadMissions(LoadMissions event, Emitter<HackerState> emit) {
    emit(state.copyWith(
      terminalOutput: [
        ...state.terminalOutput,
        'Loading mission database...',
        'Decrypting classified operations...',
        'Mission briefings updated.',
      ],
    ));

    Timer(const Duration(milliseconds: 1000), () {
      final additionalMissions = [
        Mission(
          id: 'mission_cyber_heist',
          name: 'Digital Bank Heist',
          description: 'Infiltrate banking systems and transfer funds to offshore accounts',
          type: MissionType.infiltration,
          difficulty: 9,
          reward: 1500,
          requirements: ['advanced_cryptography', 'network_infiltration'],
        ),
        Mission(
          id: 'mission_data_liberation',
          name: 'Corporate Data Liberation',
          description: 'Extract sensitive corporate documents from secure servers',
          type: MissionType.networkPenetration,
          difficulty: 6,
          reward: 800,
          requirements: ['stealth', 'data_mining'],
        ),
      ];

      emit(state.copyWith(
        missions: [...state.missions, ...additionalMissions],
        terminalOutput: [
          ...state.terminalOutput,
          '${additionalMissions.length} new missions acquired.',
          'Total available missions: ${state.missions.length + additionalMissions.length}',
        ],
      ));
      add(GainExperience(25));
    });
  }

  void _onStartMission(StartMission event, Emitter<HackerState> emit) {
    final mission = state.missions.firstWhere(
      (m) => m.id == event.missionId,
      orElse: () => throw Exception('Mission not found'),
    );

    if (mission.isCompleted) {
      emit(state.copyWith(
        terminalOutput: [
          ...state.terminalOutput,
          'Mission already completed: ${mission.name}',
        ],
      ));
      return;
    }

    emit(state.copyWith(
      terminalOutput: [
        ...state.terminalOutput,
        'Starting mission: ${mission.name}',
        'Difficulty: ${mission.difficulty}/10',
        'Reward: ${mission.reward} XP',
        'Initializing mission parameters...',
        'Establishing secure connection...',
        'Mission briefing downloaded.',
      ],
      activeHacks: [...state.activeHacks, 'MISSION_${mission.id.toUpperCase()}'],
    ));

    Timer.periodic(const Duration(milliseconds: 1200), (timer) {
      if (timer.tick > 5) {
        timer.cancel();
        emit(state.copyWith(
          terminalOutput: [
            ...state.terminalOutput,
            'Mission objectives loaded.',
            'Ready to begin operation.',
            'Type commands to execute mission tasks.',
          ],
        ));
        return;
      }

      final progressMessages = [
        'Analyzing target infrastructure...',
        'Mapping network topology...',
        'Identifying security vulnerabilities...',
        'Preparing exploitation tools...',
        'Setting up command & control...',
      ];

      emit(state.copyWith(
        terminalOutput: [
          ...state.terminalOutput,
          progressMessages[timer.tick - 1],
        ],
      ));
    });
  }

  void _onCompleteMission(CompleteMission event, Emitter<HackerState> emit) {
    final missionIndex = state.missions.indexWhere((m) => m.id == event.missionId);
    if (missionIndex == -1) {
      emit(state.copyWith(
        terminalOutput: [
          ...state.terminalOutput,
          'Error: Mission not found.',
        ],
      ));
      return;
    }

    final mission = state.missions[missionIndex];
    if (mission.isCompleted) {
      emit(state.copyWith(
        terminalOutput: [
          ...state.terminalOutput,
          'Mission already completed.',
        ],
      ));
      return;
    }

    final completedMission = mission.copyWith(
      isCompleted: true,
      completedAt: DateTime.now(),
    );

    final updatedMissions = List<Mission>.from(state.missions);
    updatedMissions[missionIndex] = completedMission;

    emit(state.copyWith(
      missions: updatedMissions,
      terminalOutput: [
        ...state.terminalOutput,
        '🎯 MISSION COMPLETED: ${mission.name}',
        'Operation status: SUCCESS',
        'Data extracted successfully.',
        'Traces erased.',
        'Payment received: ${mission.reward} XP',
      ],
      activeHacks: state.activeHacks.where((hack) => hack != 'MISSION_${mission.id.toUpperCase()}').toList(),
    ));

    add(GainExperience(mission.reward));
    add(UnlockAchievement('Mission Specialist'));

    if (mission.difficulty >= 8) {
      add(UnlockAchievement('Elite Operative'));
    }
  }

  void _onScanTarget(ScanTarget event, Emitter<HackerState> emit) {
    final targetIndex = state.targets.indexWhere((t) => t.id == event.targetId);
    if (targetIndex == -1) {
      emit(state.copyWith(
        terminalOutput: [
          ...state.terminalOutput,
          'Target not found: ${event.targetId}',
        ],
      ));
      return;
    }

    final target = state.targets[targetIndex];
    emit(state.copyWith(
      terminalOutput: [
        ...state.terminalOutput,
        'Initiating deep scan on ${target.name}...',
        'Target IP: ${target.ipAddress}',
        'Security Level: ${target.securityLevel}/10',
      ],
    ));

    Timer.periodic(const Duration(milliseconds: 600), (timer) {
      if (timer.tick > 8) {
        timer.cancel();

        final newVulnerabilities = [
          'CVE-2024-${_random.nextInt(9999).toString().padLeft(4, '0')}',
          'Buffer overflow in service port ${22 + _random.nextInt(1000)}',
          'Weak encryption detected',
        ];

        final scannedTarget = target.copyWith(
          status: TargetStatus.vulnerable,
          vulnerabilities: [...target.vulnerabilities, ...newVulnerabilities],
          lastScanned: DateTime.now(),
        );

        final updatedTargets = List<Target>.from(state.targets);
        updatedTargets[targetIndex] = scannedTarget;

        emit(state.copyWith(
          targets: updatedTargets,
          terminalOutput: [
            ...state.terminalOutput,
            'Scan complete.',
            '${newVulnerabilities.length} new vulnerabilities discovered:',
            ...newVulnerabilities.map((v) => '  - $v'),
            'Target status updated to VULNERABLE.',
          ],
        ));
        add(GainExperience(30));
        return;
      }

      final scanMessages = [
        'Port scanning: 21, 22, 23, 25, 53, 80, 443, 993, 995...',
        'Service enumeration in progress...',
        'OS fingerprinting...',
        'Vulnerability assessment...',
        'Analyzing network protocols...',
        'Checking for backdoors...',
        'Testing authentication mechanisms...',
        'Evaluating encryption strength...',
      ];

      if (timer.tick <= scanMessages.length) {
        emit(state.copyWith(
          terminalOutput: [
            ...state.terminalOutput,
            scanMessages[timer.tick - 1],
          ],
        ));
      }
    });
  }

  void _onExploitTarget(ExploitTarget event, Emitter<HackerState> emit) {
    final targetIndex = state.targets.indexWhere((t) => t.id == event.targetId);
    if (targetIndex == -1) {
      emit(state.copyWith(
        terminalOutput: [
          ...state.terminalOutput,
          'Target not found: ${event.targetId}',
        ],
      ));
      return;
    }

    final target = state.targets[targetIndex];
    if (target.status != TargetStatus.vulnerable) {
      emit(state.copyWith(
        terminalOutput: [
          ...state.terminalOutput,
          'Target must be scanned and vulnerable before exploitation.',
          'Current status: ${target.status.name.toUpperCase()}',
        ],
      ));
      return;
    }

    emit(state.copyWith(
      terminalOutput: [
        ...state.terminalOutput,
        'Launching ${event.exploitType} exploit against ${target.name}...',
        'Payload: Advanced persistent threat module',
        'Bypassing security measures...',
      ],
    ));

    Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (timer.tick > 6) {
        timer.cancel();

        final exploitedTarget = target.copyWith(
          status: TargetStatus.compromised,
          exploitData: {
            ...target.exploitData,
            'exploit_type': event.exploitType,
            'compromise_time': DateTime.now().toIso8601String(),
            'access_level': 'admin',
            'persistence': true,
          },
        );

        final updatedTargets = List<Target>.from(state.targets);
        updatedTargets[targetIndex] = exploitedTarget;

        emit(state.copyWith(
          targets: updatedTargets,
          terminalOutput: [
            ...state.terminalOutput,
            '🚨 EXPLOITATION SUCCESSFUL!',
            'Administrative access gained.',
            'Persistence established.',
            'Target compromised: ${target.name}',
          ],
          activeHacks: [...state.activeHacks, target.name.toUpperCase()],
        ));

        add(GainExperience(75));
        add(UpdateSystemIntegrity(-10));
        add(UnlockAchievement('System Breaker'));
        return;
      }

      final exploitMessages = [
        'Injecting shellcode...',
        'Escalating privileges...',
        'Installing backdoor...',
        'Establishing persistence...',
        'Covering tracks...',
        'Verifying access...',
      ];

      if (timer.tick <= exploitMessages.length) {
        emit(state.copyWith(
          terminalOutput: [
            ...state.terminalOutput,
            exploitMessages[timer.tick - 1],
          ],
        ));
      }
    });
  }

  void _onAddTarget(AddTarget event, Emitter<HackerState> emit) {
    final newTarget = Target(
      id: 'target_${_uuid.v4().substring(0, 8)}',
      name: event.name,
      ipAddress: event.ipAddress,
      securityLevel: _random.nextInt(10) + 1,
      status: TargetStatus.scanning,
      vulnerabilities: [],
      exploitData: {},
      lastScanned: DateTime.now(),
    );

    final existingTarget = state.targets.any((t) => t.ipAddress == newTarget.ipAddress);
    if (existingTarget) {
      emit(state.copyWith(
        terminalOutput: [
          ...state.terminalOutput,
          'Target already exists: ${newTarget.ipAddress}',
        ],
      ));
      return;
    }

    emit(state.copyWith(
      targets: [...state.targets, newTarget],
      terminalOutput: [
        ...state.terminalOutput,
        'New target added: ${newTarget.name}',
        'IP Address: ${newTarget.ipAddress}',
        'Security Level: ${newTarget.securityLevel}/10',
        'Status: ${newTarget.status.name.toUpperCase()}',
        'Target database updated.',
      ],
    ));
    add(GainExperience(15));
  }

  void _onUnlockTool(UnlockTool event, Emitter<HackerState> emit) {
    final toolIndex = state.tools.indexWhere((t) => t.id == event.toolId);
    if (toolIndex == -1) {
      emit(state.copyWith(
        terminalOutput: [
          ...state.terminalOutput,
          'Tool not found: ${event.toolId}',
        ],
      ));
      return;
    }

    final tool = state.tools[toolIndex];
    if (tool.isUnlocked) {
      emit(state.copyWith(
        terminalOutput: [
          ...state.terminalOutput,
          'Tool already unlocked: ${tool.name}',
        ],
      ));
      return;
    }

    final unlockedTool = tool.copyWith(isUnlocked: true);
    final updatedTools = List<Tool>.from(state.tools);
    updatedTools[toolIndex] = unlockedTool;

    emit(state.copyWith(
      tools: updatedTools,
      terminalOutput: [
        ...state.terminalOutput,
        '🔓 TOOL UNLOCKED: ${tool.name}',
        'Description: ${tool.description}',
        'Power Level: ${tool.powerLevel}/10',
        'Type: ${tool.type.name.toUpperCase()}',
        'Tool is now available for use.',
      ],
    ));
    add(GainExperience(40));
  }

  void _onUseTool(UseTool event, Emitter<HackerState> emit) {
    final tool = state.tools.firstWhere(
      (t) => t.id == event.toolId,
      orElse: () => throw Exception('Tool not found'),
    );

    final target = state.targets.firstWhere(
      (t) => t.id == event.targetId,
      orElse: () => throw Exception('Target not found'),
    );

    if (!tool.isUnlocked) {
      emit(state.copyWith(
        terminalOutput: [
          ...state.terminalOutput,
          'Tool not unlocked: ${tool.name}',
          'Complete missions to unlock advanced tools.',
        ],
      ));
      return;
    }

    emit(state.copyWith(
      terminalOutput: [
        ...state.terminalOutput,
        'Deploying ${tool.name} against ${target.name}...',
        'Tool power level: ${tool.powerLevel}/10',
        'Target security: ${target.securityLevel}/10',
      ],
    ));

    final successChance = (tool.powerLevel - target.securityLevel + 5) / 10;
    final isSuccessful = _random.nextDouble() < successChance;

    Timer(const Duration(milliseconds: 2000), () {
      if (isSuccessful) {
        final toolIndex = state.tools.indexWhere((t) => t.id == event.toolId);
        final updatedTool = tool.copyWith(usageCount: tool.usageCount + 1);
        final updatedTools = List<Tool>.from(state.tools);
        updatedTools[toolIndex] = updatedTool;

        emit(state.copyWith(
          tools: updatedTools,
          terminalOutput: [
            ...state.terminalOutput,
            '✅ Tool deployment successful!',
            'Target affected by ${tool.name}',
            'Tool usage count: ${tool.usageCount + 1}',
          ],
        ));
        add(GainExperience(25));
      } else {
        emit(state.copyWith(
          terminalOutput: [
            ...state.terminalOutput,
            '❌ Tool deployment failed.',
            'Target defenses too strong.',
            'Consider using more powerful tools or weakening target first.',
          ],
        ));
      }
    });
  }

  void _onScanNetwork(ScanNetwork event, Emitter<HackerState> emit) {
    emit(state.copyWith(
      terminalOutput: [
        ...state.terminalOutput,
        'Initiating comprehensive network scan...',
        'Mapping network topology...',
        'Analyzing traffic patterns...',
      ],
    ));

    Timer.periodic(const Duration(milliseconds: 700), (timer) {
      if (timer.tick > 10) {
        timer.cancel();

        final newNodes = [
          NetworkNode(
            id: 'node_${_uuid.v4().substring(0, 8)}',
            address: '192.168.${_random.nextInt(255)}.${_random.nextInt(255)}',
            type: NodeType.values[_random.nextInt(NodeType.values.length)],
            securityLevel: _random.nextInt(10) + 1,
            connectedNodes: [],
            metadata: {
              'discovered': DateTime.now().toIso8601String(),
              'services': ['ssh', 'http', 'ftp'][_random.nextInt(3)],
            },
          ),
        ];

        emit(state.copyWith(
          networkNodes: [...state.networkNodes, ...newNodes],
          terminalOutput: [
            ...state.terminalOutput,
            'Network scan complete.',
            '${newNodes.length} new nodes discovered.',
            'Network map updated.',
            'Total nodes in topology: ${state.networkNodes.length + newNodes.length}',
          ],
        ));
        add(GainExperience(35));
        return;
      }

      final scanningIPs = [
        '192.168.1.${_random.nextInt(255)}',
        '10.0.0.${_random.nextInt(255)}',
        '172.16.${_random.nextInt(255)}.${_random.nextInt(255)}',
      ];

      emit(state.copyWith(
        terminalOutput: [
          ...state.terminalOutput,
          'Scanning ${scanningIPs[_random.nextInt(scanningIPs.length)]}... [${['ALIVE', 'TIMEOUT', 'FILTERED'][_random.nextInt(3)]}]',
        ],
      ));
    });
  }

  void _onCompromiseNode(CompromiseNode event, Emitter<HackerState> emit) {
    final nodeIndex = state.networkNodes.indexWhere((n) => n.id == event.nodeId);
    if (nodeIndex == -1) {
      emit(state.copyWith(
        terminalOutput: [
          ...state.terminalOutput,
          'Network node not found: ${event.nodeId}',
        ],
      ));
      return;
    }

    final node = state.networkNodes[nodeIndex];
    if (node.isCompromised) {
      emit(state.copyWith(
        terminalOutput: [
          ...state.terminalOutput,
          'Node already compromised: ${node.address}',
        ],
      ));
      return;
    }

    emit(state.copyWith(
      terminalOutput: [
        ...state.terminalOutput,
        'Attempting to compromise node: ${node.address}',
        'Node type: ${node.type.name.toUpperCase()}',
        'Security level: ${node.securityLevel}/10',
        'Deploying exploit payload...',
      ],
    ));

    Timer.periodic(const Duration(milliseconds: 900), (timer) {
      if (timer.tick > 5) {
        timer.cancel();

        final compromisedNode = node.copyWith(
          isCompromised: true,
          metadata: {
            ...node.metadata,
            'compromise_time': DateTime.now().toIso8601String(),
            'access_level': 'root',
            'backdoor_installed': true,
          },
        );

        final updatedNodes = List<NetworkNode>.from(state.networkNodes);
        updatedNodes[nodeIndex] = compromisedNode;

        emit(state.copyWith(
          networkNodes: updatedNodes,
          terminalOutput: [
            ...state.terminalOutput,
            '🚨 NODE COMPROMISED!',
            'Full administrative access gained.',
            'Backdoor installed for persistence.',
            'Node ${node.address} under control.',
          ],
          activeHacks: [...state.activeHacks, 'NODE_${node.address}'],
        ));

        add(GainExperience(60));
        add(UpdateSystemIntegrity(-5));
        return;
      }

      final compromiseMessages = [
        'Exploiting vulnerabilities...',
        'Bypassing authentication...',
        'Escalating privileges...',
        'Installing rootkit...',
        'Establishing persistence...',
      ];

      if (timer.tick <= compromiseMessages.length) {
        emit(state.copyWith(
          terminalOutput: [
            ...state.terminalOutput,
            compromiseMessages[timer.tick - 1],
          ],
        ));
      }
    });
  }

  void _onLaunchSocialEngineering(LaunchSocialEngineering event, Emitter<HackerState> emit) {
    emit(state.copyWith(
      terminalOutput: [
        ...state.terminalOutput,
        'Initiating social engineering attack...',
        'Target: ${event.targetId}',
        'Method: ${event.method.toUpperCase()}',
        'Crafting convincing persona...',
      ],
    ));

    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (timer.tick > 6) {
        timer.cancel();

        final success = _random.nextBool();
        if (success) {
          emit(state.copyWith(
            terminalOutput: [
              ...state.terminalOutput,
              '🎭 SOCIAL ENGINEERING SUCCESSFUL!',
              'Target manipulated successfully.',
              'Credentials obtained: admin:${_random.nextInt(9999).toString().padLeft(4, '0')}',
              'Trust established with target.',
            ],
          ));
          add(GainExperience(80));
          add(UnlockAchievement('Master Manipulator'));
        } else {
          emit(state.copyWith(
            terminalOutput: [
              ...state.terminalOutput,
              '❌ Social engineering attempt failed.',
              'Target became suspicious.',
              'Aborting operation to avoid detection.',
            ],
          ));
        }
        return;
      }

      final socialMessages = [
        'Building rapport with target...',
        'Gathering personal information...',
        'Creating believable backstory...',
        'Executing psychological pressure...',
        'Requesting sensitive information...',
        'Analyzing target response...',
      ];

      if (timer.tick <= socialMessages.length) {
        emit(state.copyWith(
          terminalOutput: [
            ...state.terminalOutput,
            socialMessages[timer.tick - 1],
          ],
        ));
      }
    });
  }

  void _onCreateBackdoor(CreateBackdoor event, Emitter<HackerState> emit) {
    emit(state.copyWith(
      terminalOutput: [
        ...state.terminalOutput,
        'Creating backdoor for target: ${event.targetId}',
        'Backdoor type: ${event.backdoorType.toUpperCase()}',
        'Compiling stealth payload...',
      ],
    ));

    Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (timer.tick > 5) {
        timer.cancel();

        final backdoorId = 'bd_${_uuid.v4().substring(0, 8)}';
        emit(state.copyWith(
          terminalOutput: [
            ...state.terminalOutput,
            '🚪 BACKDOOR CREATED SUCCESSFULLY!',
            'Backdoor ID: $backdoorId',
            'Access method: Encrypted tunnel',
            'Persistence: Kernel-level hook',
            'Detection probability: <0.1%',
            'Backdoor ready for deployment.',
          ],
          activeHacks: [...state.activeHacks, 'BACKDOOR_$backdoorId'],
        ));
        add(GainExperience(50));
        return;
      }

      final backdoorMessages = [
        'Generating encryption keys...',
        'Obfuscating code signature...',
        'Implementing anti-detection...',
        'Testing payload integrity...',
        'Finalizing backdoor package...',
      ];

      if (timer.tick <= backdoorMessages.length) {
        emit(state.copyWith(
          terminalOutput: [
            ...state.terminalOutput,
            backdoorMessages[timer.tick - 1],
          ],
        ));
      }
    });
  }

  void _onLaunchDDoSAttack(LaunchDDoSAttack event, Emitter<HackerState> emit) {
    emit(state.copyWith(
      terminalOutput: [
        ...state.terminalOutput,
        'Launching DDoS attack...',
        'Target: ${event.targetId}',
        'Attack type: ${event.attackType.toUpperCase()}',
        'Mobilizing botnet...',
      ],
    ));

    Timer.periodic(const Duration(milliseconds: 600), (timer) {
      if (timer.tick > 8) {
        timer.cancel();

        emit(state.copyWith(
          terminalOutput: [
            ...state.terminalOutput,
            '💥 DDoS ATTACK SUCCESSFUL!',
            'Target overwhelmed with traffic.',
            'Service availability: 0%',
            'Attack duration: ${_random.nextInt(60) + 30} minutes',
            'Botnet size: ${_random.nextInt(50000) + 10000} nodes',
          ],
        ));
        add(GainExperience(45));
        add(UpdateSystemIntegrity(-15));
        return;
      }

      final ddosMessages = [
        'Coordinating bot army...',
        'Amplifying traffic volume...',
        'Targeting critical services...',
        'Overwhelming bandwidth...',
        'Saturating server resources...',
        'Monitoring target response...',
        'Adjusting attack vectors...',
        'Maintaining attack pressure...',
      ];

      if (timer.tick <= ddosMessages.length) {
        final packets = _random.nextInt(100000) + 50000;
        emit(state.copyWith(
          terminalOutput: [
            ...state.terminalOutput,
            '${ddosMessages[timer.tick - 1]} [$packets packets/sec]',
          ],
        ));
      }
    });
  }

  void _onPerformBlockchainAnalysis(PerformBlockchainAnalysis event, Emitter<HackerState> emit) {
    emit(state.copyWith(
      terminalOutput: [
        ...state.terminalOutput,
        'Analyzing blockchain: ${event.blockchain}',
        'Target address: ${event.address}',
        'Initializing blockchain forensics...',
      ],
    ));

    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (timer.tick > 5) {
        timer.cancel();

        final balance = (_random.nextDouble() * 100).toStringAsFixed(8);
        final transactions = _random.nextInt(500) + 50;

        emit(state.copyWith(
          terminalOutput: [
            ...state.terminalOutput,
            '🔗 BLOCKCHAIN ANALYSIS COMPLETE',
            'Address balance: $balance ${event.blockchain}',
            'Transaction count: $transactions',
            'First activity: ${DateTime.now().subtract(Duration(days: _random.nextInt(1000))).toString().substring(0, 10)}',
            'Risk score: ${_random.nextInt(100)}%',
            'Connected addresses identified: ${_random.nextInt(20) + 5}',
          ],
          blockchainData: {
            ...state.blockchainData,
            event.address: {
              'blockchain': event.blockchain,
              'balance': balance,
              'transactions': transactions,
              'risk_score': _random.nextInt(100),
              'analysis_time': DateTime.now().toIso8601String(),
            },
          },
        ));
        add(GainExperience(65));
        return;
      }

      final analysisMessages = [
        'Querying blockchain nodes...',
        'Parsing transaction history...',
        'Analyzing transaction patterns...',
        'Identifying wallet clusters...',
        'Calculating risk metrics...',
      ];

      if (timer.tick <= analysisMessages.length) {
        emit(state.copyWith(
          terminalOutput: [
            ...state.terminalOutput,
            analysisMessages[timer.tick - 1],
          ],
        ));
      }
    });
  }

  void _onExecuteQuantumDecryption(ExecuteQuantumDecryption event, Emitter<HackerState> emit) {
    emit(state.copyWith(
      terminalOutput: [
        ...state.terminalOutput,
        'Initializing quantum decryption protocol...',
        'Target data: ${event.encryptedData}',
        'Quantum state preparation...',
      ],
    ));

    Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (timer.tick > 7) {
        timer.cancel();

        final decryptedData = 'CLASSIFIED_${_random.nextInt(999999).toString().padLeft(6, '0')}';
        emit(state.copyWith(
          terminalOutput: [
            ...state.terminalOutput,
            '⚛️ QUANTUM DECRYPTION SUCCESSFUL!',
            'Quantum superposition collapsed.',
            'Decrypted data: $decryptedData',
            'Encryption broken using Shor\'s algorithm.',
            'Quantum advantage achieved.',
          ],
        ));
        add(GainExperience(100));
        add(UnlockAchievement('Quantum Supremacist'));
        return;
      }

      final quantumMessages = [
        'Creating quantum entanglement...',
        'Applying Grover\'s algorithm...',
        'Measuring quantum states...',
        'Processing superposition...',
        'Executing quantum gates...',
        'Analyzing probability amplitudes...',
        'Collapsing wave function...',
      ];

      if (timer.tick <= quantumMessages.length) {
        emit(state.copyWith(
          terminalOutput: [
            ...state.terminalOutput,
            quantumMessages[timer.tick - 1],
          ],
        ));
      }
    });
  }

  void _onActivateNeuralNetwork(ActivateNeuralNetwork event, Emitter<HackerState> emit) {
    emit(state.copyWith(
      terminalOutput: [
        ...state.terminalOutput,
        'Activating neural network...',
        'Network type: ${event.networkType}',
        'Task: ${event.task}',
        'Loading neural weights...',
      ],
    ));

    Timer.periodic(const Duration(milliseconds: 900), (timer) {
      if (timer.tick > 6) {
        timer.cancel();

        final accuracy = (85 + _random.nextInt(15)).toString();
        final nodes = _random.nextInt(10000) + 5000;

        emit(state.copyWith(
          terminalOutput: [
            ...state.terminalOutput,
            '🧠 NEURAL NETWORK ACTIVATED!',
            'Network nodes: $nodes',
            'Training accuracy: $accuracy%',
            'Learning rate optimized.',
            'Pattern recognition online.',
            'AI assistant ready for deployment.',
          ],
          neuralNetworkData: {
            ...state.neuralNetworkData,
            event.networkType: {
              'task': event.task,
              'accuracy': accuracy,
              'nodes': nodes,
              'activation_time': DateTime.now().toIso8601String(),
              'status': 'active',
            },
          },
        ));
        add(GainExperience(70));
        add(UnlockAchievement('Neural Architect'));
        return;
      }

      final neuralMessages = [
        'Initializing neural layers...',
        'Loading training data...',
        'Optimizing weights and biases...',
        'Testing forward propagation...',
        'Validating network architecture...',
        'Calibrating activation functions...',
      ];

      if (timer.tick <= neuralMessages.length) {
        emit(state.copyWith(
          terminalOutput: [
            ...state.terminalOutput,
            neuralMessages[timer.tick - 1],
          ],
        ));
      }
    });
  }

  @override
  Future<void> close() {
    _dataStreamTimer?.cancel();
    _systemLogTimer?.cancel();
    _networkTimer?.cancel();
    return super.close();
  }
}
