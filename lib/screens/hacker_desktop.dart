import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:window_manager/window_manager.dart';
import '../bloc/hacker_bloc.dart';
import '../bloc/hacker_state.dart';
import '../bloc/hacker_event.dart';
import '../widgets/terminal_panel.dart';
import '../widgets/data_stream_panel.dart';
import '../widgets/system_monitor_panel.dart';
import '../widgets/network_panel.dart';
import '../widgets/matrix_panel.dart';
import '../widgets/status_bar.dart';
import '../widgets/hex_dump_panel.dart';
import '../widgets/vulnerability_scanner_panel.dart';
import '../widgets/crypto_panel.dart';
import '../widgets/geolocation_panel.dart';
import '../widgets/process_monitor_panel.dart';
import '../widgets/missions_panel.dart';
import '../widgets/tools_panel.dart';
import '../widgets/blockchain_panel.dart';
import '../widgets/neural_network_panel.dart';
import '../widgets/quantum_panel.dart';

class HackerDesktop extends StatefulWidget {
  const HackerDesktop({super.key});

  @override
  State<HackerDesktop> createState() => _HackerDesktopState();
}

class _HackerDesktopState extends State<HackerDesktop>
    with TickerProviderStateMixin {
  late AnimationController _glitchController;
  late AnimationController _scanlineController;
  late AnimationController _pulseController;
  late AnimationController _onionController;
  late AnimationController _cryptoFlickerController;
  late AnimationController _darkWebPulseController;

  // Store timer to dispose properly
  Timer? _messageTimer;

  // Dark web creepy messages
  final List<String> _darkWebMessages = [
    ">>> ACCESSING HIDDEN SERVICES <<<",
    ">>> TOR CIRCUIT ESTABLISHED <<<",
    ">>> ONION ROUTING ACTIVE <<<",
    ">>> ENCRYPTED MARKETPLACE DETECTED <<<",
    ">>> ANONYMOUS TRANSACTION COMPLETE <<<",
    ">>> ZERO-KNOWLEDGE PROOF VERIFIED <<<",
    ">>> SILK ROAD 3.0 ACCESSED <<<",
    ">>> DIGITAL CONTRABAND ACQUIRED <<<",
    ">>> UNTRACEABLE COMMUNICATION ACTIVE <<<",
    ">>> DEEP WEB CRAWLER DEPLOYED <<<",
    ">>> DARKNET IDENTITY SPOOFED <<<",
    ">>> BLOCKCHAIN MIXER ACTIVATED <<<",
    ">>> ENCRYPTED CHAT ROOMS INFILTRATED <<<",
    ">>> CRYPTOCURRENCY TUMBLER ONLINE <<<",
  ];

  int _currentMessageIndex = 0;

  @override
  void initState() {
    super.initState();
    _glitchController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();

    _scanlineController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    // Dark web specific animations
    _onionController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    _cryptoFlickerController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    )..repeat(reverse: true);

    _darkWebPulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    // Cycle through dark web messages - store timer for proper disposal
    _messageTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          _currentMessageIndex =
              (_currentMessageIndex + 1) % _darkWebMessages.length;
        });
      }
    });
  }

  @override
  void dispose() {
    // Cancel timer to prevent memory leak
    _messageTimer?.cancel();

    // Dispose all animation controllers
    _glitchController.dispose();
    _scanlineController.dispose();
    _pulseController.dispose();
    _onionController.dispose();
    _cryptoFlickerController.dispose();
    _darkWebPulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A), // Darker background
      body: BlocBuilder<HackerBloc, HackerState>(
        builder: (context, state) {
          return Stack(
            children: [
              // Enhanced matrix rain with dark web colors
              Positioned.fill(
                child: Opacity(
                  opacity: state.isMatrixMode ? 0.9 : 0.4,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 2.0,
                        colors: [
                          Color(0xFF1A0D1A), // Dark purple
                          Color(0xFF0D0D1A), // Dark blue
                          Colors.black,
                        ],
                      ),
                    ),
                    child: const MatrixPanel(),
                  ),
                ),
              ),

              // Dark web onion layers effect
              AnimatedBuilder(
                animation: _onionController,
                builder: (context, child) {
                  return Positioned.fill(
                    child: CustomPaint(
                      painter: OnionLayersPainter(_onionController.value),
                    ),
                  );
                },
              ),

              // Enhanced red alert with dark web vibes
              if (state.isRedAlert)
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment.center,
                            radius: 2.0,
                            colors: [
                              Color(0xFF8B0000).withValues(
                                alpha: _pulseController.value * 0.15,
                              ),
                              // Dark red
                              Color(
                                0xFF4B0000,
                              ).withValues(alpha: _pulseController.value * 0.1),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

              // Creepy scanline with dark web colors
              AnimatedBuilder(
                animation: _scanlineController,
                builder: (context, child) {
                  return Positioned(
                    top:
                        MediaQuery.of(context).size.height *
                        _scanlineController.value,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 3,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.transparent,
                            Color(0xFF9400D3), // Dark violet
                            Color(0xFF4B0082), // Indigo
                            Colors.transparent,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF9400D3,
                            ).withValues(alpha: 0.6),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              // Dark web encrypted message overlay
              _buildDarkWebMessageOverlay(),

              // Main content with enhanced dark web effects
              AnimatedBuilder(
                animation: _glitchController,
                builder: (context, child) {
                  final glitchOffset =
                      (state.systemIntegrity < 50 &&
                          (_glitchController.value * 100) % 1 > 0.95)
                      ? const Offset(5, 0)
                      : Offset.zero;

                  return Transform.translate(
                    offset: glitchOffset,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.center,
                          radius: 1.8,
                          colors: [
                            const Color(0xFF0A0A0A).withOpacity(0.9),
                            Color(
                              0xFF1A0D1A,
                            ).withOpacity(state.isMatrixMode ? 0.2 : 0.1),
                            // Dark purple
                            const Color(0xFF0D0D1A).withOpacity(0.15),
                            // Dark blue
                            Colors.black,
                          ],
                          stops: const [0.0, 0.3, 0.7, 1.0],
                        ),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return _buildAdvancedResponsiveLayout(
                            constraints,
                            state,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),

              // Enhanced status bar with dark web elements
              const Positioned(top: 0, left: 0, right: 0, child: StatusBar()),

              // Dark web crypto flicker effect
              _buildCryptoFlickerEffect(),

              // Close button with dark web styling
              Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                  onTap: () async {
                    await windowManager.close();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A0A0A).withOpacity(0.9),
                      border: Border.all(
                        color: const Color(0xFF8B0000).withOpacity(0.8),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF8B0000).withOpacity(0.5),
                          blurRadius: 15,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Color(0xFF8B0000),
                      size: 24,
                    ),
                  ),
                ),
              ),

              _buildDarkWebCornerControls(state),

              // Enhanced floating action panel with dark web vibes
              _buildDarkWebFloatingPanel(state),

              // Loading overlay with dark web styling
              if (state.isLoading)
                Positioned.fill(
                  child: Container(
                    color: const Color(0xFF0A0A0A).withOpacity(0.95),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedBuilder(
                            animation: _darkWebPulseController,
                            builder: (context, child) {
                              return Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color.lerp(
                                      const Color(0xFF9400D3),
                                      const Color(0xFF4B0082),
                                      _darkWebPulseController.value,
                                    )!,
                                    width: 3,
                                  ),
                                ),
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xFF9400D3),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                'ESTABLISHING TOR CONNECTION...',
                                textStyle: GoogleFonts.sourceCodePro(
                                  color: const Color(0xFF9400D3),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                speed: const Duration(milliseconds: 100),
                              ),
                              TypewriterAnimatedText(
                                'ROUTING THROUGH ONION LAYERS...',
                                textStyle: GoogleFonts.sourceCodePro(
                                  color: const Color(0xFF4B0082),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                speed: const Duration(milliseconds: 100),
                              ),
                              TypewriterAnimatedText(
                                'ACCESSING HIDDEN SERVICES...',
                                textStyle: GoogleFonts.sourceCodePro(
                                  color: const Color(0xFF6A0DAD),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                speed: const Duration(milliseconds: 100),
                              ),
                            ],
                            repeatForever: true,
                            pause: const Duration(milliseconds: 500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAdvancedResponsiveLayout(
    BoxConstraints constraints,
    HackerState state,
  ) {
    double width = constraints.maxWidth;
    double height = constraints.maxHeight - 40;

    // Enhanced adaptive algorithm with dark web panels
    int columns;
    List<Widget> panels;

    if (width < 800) {
      columns = 1;
      panels = _getDarkWebCorePanels(state);
    } else if (width < 1200) {
      columns = 2;
      panels = _getDarkWebStandardPanels(state);
    } else if (width < 1600) {
      columns = 3;
      panels = _getDarkWebExtendedPanels(state);
    } else if (width < 2400) {
      columns = 4;
      panels = _getDarkWebAdvancedPanels(state);
    } else {
      columns = 5;
      panels = _getDarkWebUltraWidePanels(state);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 4, right: 4, bottom: 80),
      child: _buildDynamicGrid(panels, columns, width, height),
    );
  }

  Widget _buildDynamicGrid(
    List<Widget> panels,
    int columns,
    double width,
    double height,
  ) {
    double panelWidth = (width - (columns + 1) * 4) / columns;
    double panelHeight = (height - 80) / 3;

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: panels
          .map(
            (panel) =>
                SizedBox(width: panelWidth, height: panelHeight, child: panel),
          )
          .toList(),
    );
  }

  List<Widget> _getDarkWebCorePanels(HackerState state) {
    return [
      _buildDarkWebPanel(
        title: 'TOR TERMINAL',
        subtitle:
            'ANON: ${state.user?.username ?? 'SHADOW'} | ONION LVL ${state.hackingLevel}',
        child: const TerminalPanel(),
        isMain: true,
        state: state,
        panelId: 'terminal',
      ),
      _buildDarkWebPanel(
        title: 'DARKNET INTRUSION',
        subtitle:
            'ENCRYPTED TRAFFIC | ${state.networkTraffic.length} HIDDEN ROUTES',
        child: const NetworkPanel(),
        state: state,
        panelId: 'network',
      ),
      _buildDarkWebPanel(
        title: 'SYSTEM COMPROMISE',
        subtitle:
            'INTEGRITY: ${state.systemIntegrity.toStringAsFixed(0)}% | ${state.activeHacks.length} EXPLOITS',
        child: const SystemMonitorPanel(),
        state: state,
        panelId: 'system',
      ),
      _buildDarkWebPanel(
        title: 'DATA HARVESTING',
        subtitle: 'AI SCRAPER | QUANTUM OBFUSCATION',
        child: const DataStreamPanel(),
        state: state,
        panelId: 'data',
      ),
    ];
  }

  List<Widget> _getDarkWebStandardPanels(HackerState state) {
    return [
      ..._getDarkWebCorePanels(state),
      _buildDarkWebPanel(
        title: 'BLACK OPS MISSIONS',
        subtitle:
            '${state.missions.where((m) => !m.isCompleted).length} UNDERGROUND TASKS',
        child: const MissionsPanel(),
        state: state,
        panelId: 'missions',
      ),
      _buildDarkWebPanel(
        title: 'HACKER TOOLKIT',
        subtitle:
            '${state.tools.where((t) => t.isUnlocked).length}/${state.tools.length} EXPLOITS',
        child: const ToolsPanel(),
        state: state,
        panelId: 'tools',
      ),
    ];
  }

  List<Widget> _getDarkWebExtendedPanels(HackerState state) {
    return [
      ..._getDarkWebStandardPanels(state),
      _buildDarkWebPanel(
        title: 'ZERO-DAY SCANNER',
        subtitle: 'UNDERGROUND EXPLOIT DATABASE',
        child: const VulnerabilityScannerPanel(),
        state: state,
        panelId: 'vuln',
      ),
      _buildDarkWebPanel(
        title: 'CRYPTO BREAKER',
        subtitle: 'QUANTUM CIPHER CRACKING',
        child: const CryptoPanel(),
        state: state,
        panelId: 'crypto',
      ),
      _buildDarkWebPanel(
        title: 'BLOCKCHAIN MIXER',
        subtitle: 'ANONYMOUS TRANSACTIONS',
        child: const BlockchainPanel(),
        state: state,
        panelId: 'blockchain',
      ),
    ];
  }

  List<Widget> _getDarkWebAdvancedPanels(HackerState state) {
    return [
      ..._getDarkWebExtendedPanels(state),
      _buildDarkWebPanel(
        title: 'AI BOTNET',
        subtitle: 'NEURAL NETWORK HIJACKING',
        child: const NeuralNetworkPanel(),
        state: state,
        panelId: 'neural',
      ),
      _buildDarkWebPanel(
        title: 'QUANTUM STEALTH',
        subtitle: 'UNHACKABLE ENCRYPTION',
        child: const QuantumPanel(),
        state: state,
        panelId: 'quantum',
      ),
    ];
  }

  List<Widget> _getDarkWebUltraWidePanels(HackerState state) {
    return [
      ..._getDarkWebAdvancedPanels(state),
      _buildDarkWebPanel(
        title: 'MEMORY DUMP',
        subtitle: 'SHADOW FORENSICS',
        child: const HexDumpPanel(),
        state: state,
        panelId: 'hex',
      ),
      _buildDarkWebPanel(
        title: 'GHOST PROCESSES',
        subtitle: 'STEALTH INJECTION',
        child: const ProcessMonitorPanel(),
        state: state,
        panelId: 'process',
      ),
      _buildDarkWebPanel(
        title: 'PHANTOM TRACKER',
        subtitle: 'UNTRACEABLE GEOLOCATION',
        child: const GeolocationPanel(),
        state: state,
        panelId: 'geo',
      ),
    ];
  }

  Widget _buildDarkWebPanel({
    required String title,
    required String subtitle,
    required Widget child,
    bool isMain = false,
    required HackerState state,
    required String panelId,
  }) {
    Color borderColor = _getDarkWebPanelColor(state);

    return BlocBuilder<HackerBloc, HackerState>(
      builder: (context, blocState) {
        return InkWell(
          onTap: () => context.read<HackerBloc>().add(
            AddTerminalOutput('>>> $panelId MODULE ACTIVATED <<<'),
          ),
          onDoubleTap: () => context.read<HackerBloc>().add(
            AddTerminalOutput('>>> DARKNET BREACH INITIATED <<<'),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor.withOpacity(0.8),
                width: isMain ? 3 : 2,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: borderColor.withOpacity(0.4),
                  blurRadius: isMain ? 25 : 15,
                  spreadRadius: isMain ? 4 : 2,
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF0A0A0A).withOpacity(0.95),
                  borderColor.withOpacity(0.05),
                  const Color(0xFF0A0A0A).withOpacity(0.98),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Enhanced dark web title bar
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: borderColor.withOpacity(0.7),
                        width: 2,
                      ),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        borderColor.withOpacity(0.3),
                        borderColor.withOpacity(0.1),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: GoogleFonts.sourceCodePro(
                                color: borderColor,
                                fontSize: isMain ? 12 : 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Warning indicator
                          InkWell(
                            onTap: () => context.read<HackerBloc>().add(
                              AddTerminalOutput(
                                '>>> DARK WEB ANOMALY DETECTED <<<',
                              ),
                            ),
                            child: Icon(
                              Icons.warning,
                              color: borderColor,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: GoogleFonts.sourceCodePro(
                          color: borderColor.withOpacity(0.8),
                          fontSize: 8,
                          letterSpacing: 0.8,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(child: child),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getDarkWebPanelColor(HackerState state) {
    if (state.isRedAlert) return const Color(0xFF8B0000); // Dark red
    if (state.systemIntegrity < 30)
      return const Color(0xFFFF4500); // Orange red
    if (state.isGhostMode) return const Color(0xFF9400D3); // Dark violet
    return const Color(0xFF4B0082); // Indigo
  }

  Widget _buildDarkWebMessageOverlay() {
    return Positioned(
      top: 60,
      left: 20,
      right: 20,
      child: AnimatedBuilder(
        animation: _darkWebPulseController,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              border: Border.all(
                color: Color.lerp(
                  const Color(0xFF9400D3),
                  const Color(0xFF4B0082),
                  _darkWebPulseController.value,
                )!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF9400D3).withOpacity(0.6),
                  blurRadius: 15,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.security, color: Color(0xFF9400D3), size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _darkWebMessages[_currentMessageIndex],
                    textAlign: TextAlign.left,
                    style: GoogleFonts.sourceCodePro(
                      color: const Color(0xFF9400D3),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCryptoFlickerEffect() {
    return Positioned(
      bottom: 120,
      left: 20,
      child: AnimatedBuilder(
        animation: _cryptoFlickerController,
        builder: (context, child) {
          return Opacity(
            opacity: (_cryptoFlickerController.value > 0.5) ? 1.0 : 0.4,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF9400D3), width: 3),
                gradient: const RadialGradient(
                  colors: [Color(0x4D9400D3), Colors.transparent],
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.currency_bitcoin,
                  color: Color(0xFF9400D3),
                  size: 40,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDarkWebCornerControls(HackerState state) {
    Color cornerColor = _getDarkWebPanelColor(state);

    return Stack(
      children: [
        // System Integrity with computer icon
        Positioned(
          top: 60,
          left: 15,
          child: InkWell(
            onTap: () =>
                context.read<HackerBloc>().add(UpdateSystemIntegrity(-15)),
            child: _buildDarkWebCornerControl(
              'SYS\n${state.systemIntegrity.toInt()}%',
              cornerColor,
              Icons.computer,
            ),
          ),
        ),
        // Alert Level with warning
        Positioned(
          top: 60,
          right: 15,
          child: InkWell(
            onTap: () => context.read<HackerBloc>().add(ToggleRedAlert()),
            child: _buildDarkWebCornerControl(
              'ALERT\n${state.isRedAlert ? 'HIGH' : 'LOW'}',
              cornerColor,
              Icons.warning,
            ),
          ),
        ),
        // Ghost Protocol with phantom icon
        Positioned(
          bottom: 110,
          left: 15,
          child: InkWell(
            onTap: () => context.read<HackerBloc>().add(ToggleGhostMode()),
            child: _buildDarkWebCornerControl(
              'GHOST\n${state.isGhostMode ? 'ON' : 'OFF'}',
              state.isGhostMode ? const Color(0xFF9400D3) : cornerColor,
              Icons.visibility_off,
            ),
          ),
        ),
        // Matrix Mode with dark web icon
        Positioned(
          bottom: 110,
          right: 15,
          child: InkWell(
            onTap: () => context.read<HackerBloc>().add(ToggleMatrixMode()),
            child: _buildDarkWebCornerControl(
              'MATRIX\n${state.isMatrixMode ? 'ON' : 'OFF'}',
              state.isMatrixMode ? const Color(0xFF4B0082) : cornerColor,
              Icons.blur_on,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDarkWebCornerControl(String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.8), width: 2),
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF0A0A0A).withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.sourceCodePro(
              color: color,
              fontSize: 8,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDarkWebFloatingPanel(HackerState state) {
    return BlocBuilder<HackerBloc, HackerState>(
      builder: (context, blocState) {
        return Positioned(
          bottom: 15,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A).withValues(alpha: 0.95),
                border: Border.all(
                  color: const Color(0xFF9400D3).withValues(alpha: 0.8),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF9400D3).withValues(alpha: 0.5),
                    blurRadius: 25,
                    spreadRadius: 8,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDarkWebActionButton(
                    'TOR',
                    Icons.vpn_lock,
                    context,
                    () => context.read<HackerBloc>().add(
                      const ExecuteCommand('tor'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildDarkWebActionButton(
                    'MARKETPLACE',
                    Icons.store,
                    context,
                    () => context.read<HackerBloc>().add(
                      const ExecuteCommand('marketplace'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildDarkWebActionButton(
                    'CRYPTO',
                    Icons.currency_bitcoin,
                    context,
                    () => context.read<HackerBloc>().add(
                      const ExecuteCommand('crypto'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildDarkWebActionButton(
                    'DARKNET',
                    Icons.dark_mode,
                    context,
                    () => context.read<HackerBloc>().add(
                      const ExecuteCommand('darknet'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildDarkWebActionButton(
                    'EXPLOIT',
                    Icons.bug_report,
                    context,
                    () => context.read<HackerBloc>().add(
                      const ExecuteCommand('exploit'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildDarkWebActionButton(
                    'BREACH',
                    Icons.security,
                    context,
                    () => context.read<HackerBloc>().add(StartSystemTakeover()),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDarkWebActionButton(
    String label,
    IconData icon,
    BuildContext context,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF9400D3).withValues(alpha: 0.8),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Color(0x409400D3), Color(0x264B0082)],
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFF9400D3), size: 16),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.sourceCodePro(
                color: const Color(0xFF9400D3),
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Full screen control methods
  void _toggleFullScreen() async {
    bool isFullScreen = await windowManager.isFullScreen();
    if (isFullScreen) {
      await windowManager.setFullScreen(false);
    } else {
      await windowManager.setFullScreen(true);
    }
  }

  void _exitFullScreen() async {
    await windowManager.setFullScreen(false);
  }
}

class OnionLayersPainter extends CustomPainter {
  final double animationValue;

  OnionLayersPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double maxRadius = size.width / 4;

    // Create more dramatic onion layers with varying opacity and size
    for (int i = 0; i < 8; i++) {
      double progress = (animationValue + (i * 0.2)) % 1.0;
      double radius = maxRadius * progress;

      if (radius > 10) {
        Paint paint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0 - (i * 0.3)
          ..color = Color.lerp(
            const Color(0xFF9400D3),
            const Color(0xFF4B0082),
            i / 8,
          )!.withOpacity((1.0 - progress) * 0.6);

        canvas.drawCircle(Offset(centerX, centerY), radius, paint);

        // Add inner glow effect
        Paint glowPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6.0 - (i * 0.5)
          ..color = Color.lerp(
            const Color(0xFF9400D3),
            const Color(0xFF4B0082),
            i / 8,
          )!.withOpacity((1.0 - progress) * 0.2)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5.0);

        canvas.drawCircle(Offset(centerX, centerY), radius, glowPaint);
      }
    }

    // Add central pulsing core
    double coreRadius = 20 + (10 * (0.5 + 0.5 * (animationValue * 2 % 1.0)));
    Paint corePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF9400D3).withOpacity(0.3 + 0.2 * (animationValue * 3 % 1.0));

    canvas.drawCircle(Offset(centerX, centerY), coreRadius, corePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
