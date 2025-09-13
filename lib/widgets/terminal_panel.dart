import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/hacker_bloc.dart';
import '../bloc/hacker_state.dart';
import '../bloc/hacker_event.dart';

class TerminalPanel extends StatefulWidget {
  const TerminalPanel({super.key});

  @override
  State<TerminalPanel> createState() => _TerminalPanelState();
}

class _TerminalPanelState extends State<TerminalPanel> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HackerBloc, HackerState>(
      builder: (context, state) {
        _scrollToBottom();

        return Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  border: Border.all(color: const Color(0xFF00FF00).withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'LVL ${state.hackingLevel}',
                      style: GoogleFonts.sourceCodePro(
                        color: const Color(0xFF00FF00),
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${state.activeHacks.length} ACTIVE',
                      style: GoogleFonts.sourceCodePro(
                        color: const Color(0xFF00FF00).withOpacity(0.8),
                        fontSize: 8,
                      ),
                    ),
                    Text(
                      'INT: ${state.systemIntegrity.toStringAsFixed(0)}%',
                      style: GoogleFonts.sourceCodePro(
                        color: state.systemIntegrity < 50
                            ? Colors.red
                            : const Color(0xFF00FF00),
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'XP: ${state.user?.experience ?? 0}',
                      style: GoogleFonts.sourceCodePro(
                        color: Colors.yellow,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.9),
                    border: Border.all(
                      color: const Color(0xFF00FF00).withOpacity(0.4),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00FF00).withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.terminalOutput.length,
                    itemBuilder: (context, index) {
                      final line = state.terminalOutput[index];
                      Color textColor = const Color(0xFF00FF00);

                      if (line.startsWith('>')) {
                        textColor = const Color(0xFF00FF41);
                      } else if (line.contains('ERROR') || line.contains('CRITICAL')) {
                        textColor = const Color(0xFFFF0000);
                      } else if (line.contains('WARNING') || line.contains('ALERT')) {
                        textColor = const Color(0xFFFF6600);
                      } else if (line.contains('SUCCESS') || line.contains('COMPLETE')) {
                        textColor = const Color(0xFF00FF00);
                      } else if (line.contains('>>>')) {
                        textColor = const Color(0xFF00FFFF);
                      } else if (line.contains('🏆')) {
                        textColor = Colors.yellow;
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Text(
                          line,
                          style: GoogleFonts.sourceCodePro(
                            color: textColor,
                            fontSize: 10,
                            height: 1.2,
                            fontWeight: line.startsWith('>') || line.contains('>>>')
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.9),
                  border: Border.all(
                    color: state.isGhostMode
                        ? const Color(0xFF00FFFF)
                        : const Color(0xFF00FF00).withOpacity(0.8),
                    width: state.isGhostMode ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: (state.isGhostMode
                          ? const Color(0xFF00FFFF)
                          : const Color(0xFF00FF00)).withOpacity(0.3),
                      blurRadius: state.isGhostMode ? 10 : 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        state.isGhostMode ? '>>>' : '[\$]',
                        style: GoogleFonts.sourceCodePro(
                          color: state.isGhostMode
                              ? const Color(0xFF00FFFF)
                              : const Color(0xFF00FF41),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        style: GoogleFonts.sourceCodePro(
                          color: const Color(0xFF00FF00),
                          fontSize: 11,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: state.isGhostMode
                              ? 'Ghost protocol active...'
                              : 'Enter command...',
                          hintStyle: TextStyle(
                            color: const Color(0xFF00FF00).withOpacity(0.5),
                            fontSize: 10,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 12,
                          ),
                        ),
                        onSubmitted: (command) {
                          if (command.trim().isNotEmpty) {
                            context.read<HackerBloc>().add(ExecuteCommand(command));
                            _controller.clear();
                          }
                          _focusNode.requestFocus();
                        },
                        cursorColor: const Color(0xFF00FF00),
                        enableSuggestions: false,
                        autocorrect: false,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),
              Flexible(
                child: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    _buildQuickButton('scan', Icons.search, context),
                    _buildQuickButton('missions', Icons.assignment, context),
                    _buildQuickButton('tools', Icons.build, context),
                    _buildQuickButton('targets', Icons.gps_fixed, context),
                    _buildQuickButton('network', Icons.hub, context),
                    _buildQuickButton('crypto', Icons.enhanced_encryption, context),
                    _buildQuickButton('neural', Icons.psychology, context),
                    _buildQuickButton('quantum', Icons.science, context),
                    _buildQuickButton('help', Icons.help_outline, context),
                  ],
                ),
              ),

              if (state.activeHacks.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    border: Border.all(color: const Color(0xFF00FF00).withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ACTIVE EXPLOITS:',
                        style: GoogleFonts.sourceCodePro(
                          color: const Color(0xFF00FF00),
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Wrap(
                        spacing: 4,
                        runSpacing: 2,
                        children: state.activeHacks.map((hack) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF00FF00).withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(2),
                            color: const Color(0xFF00FF00).withOpacity(0.1),
                          ),
                          child: Text(
                            hack,
                            style: GoogleFonts.sourceCodePro(
                              color: const Color(0xFF00FF00),
                              fontSize: 7,
                            ),
                          ),
                        )).toList(),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickButton(String command, IconData icon, BuildContext context) {
    return BlocBuilder<HackerBloc, HackerState>(
      builder: (context, state) {
        bool isActive = false;
        Color buttonColor = const Color(0xFF00FF00);

        switch (command) {
          case 'ghost':
            isActive = state.isGhostMode;
            buttonColor = isActive ? const Color(0xFF00FFFF) : const Color(0xFF00FF00);
            break;
          case 'matrix':
            isActive = state.isMatrixMode;
            buttonColor = isActive ? const Color(0xFF00FF41) : const Color(0xFF00FF00);
            break;
          default:
            buttonColor = const Color(0xFF00FF00);
        }

        return InkWell(
          onTap: () {
            context.read<HackerBloc>().add(ExecuteCommand(command));
            _focusNode.requestFocus();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(
                color: buttonColor.withOpacity(0.6),
                width: isActive ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(2),
              color: buttonColor.withOpacity(isActive ? 0.2 : 0.1),
              boxShadow: isActive ? [
                BoxShadow(
                  color: buttonColor.withOpacity(0.4),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ] : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: buttonColor,
                  size: 10,
                ),
                const SizedBox(width: 4),
                Text(
                  command.toUpperCase(),
                  style: GoogleFonts.sourceCodePro(
                    color: buttonColor,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
