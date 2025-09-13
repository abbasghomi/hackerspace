import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/hacker_bloc.dart';
import '../bloc/hacker_state.dart';
import '../bloc/hacker_event.dart';

class ToolsPanel extends StatelessWidget {
  const ToolsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HackerBloc, HackerState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'CYBER ARSENAL',
                    style: GoogleFonts.sourceCodePro(
                      color: const Color(0xFF00FF00),
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${state.tools.where((t) => t.isUnlocked).length}/${state.tools.length} UNLOCKED',
                    style: GoogleFonts.sourceCodePro(
                      color: const Color(0xFF00FF00).withOpacity(0.8),
                      fontSize: 8,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Expanded(
                child: state.tools.isEmpty
                    ? Center(
                        child: Text(
                          'Loading arsenal...\nQuantum tools initializing...',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sourceCodePro(
                            color: const Color(0xFF00FF00).withOpacity(0.6),
                            fontSize: 9,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: state.tools.length,
                        itemBuilder: (context, index) {
                          final tool = state.tools[index];
                          return InkWell(
                            onTap: tool.isUnlocked
                                ? () => context.read<HackerBloc>().add(UseTool(toolId: tool.id, targetId: 'default'))
                                : () => context.read<HackerBloc>().add(UnlockTool(tool.id)),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 4),
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                border: Border.all(
                                  color: tool.isUnlocked
                                      ? const Color(0xFF00FF00).withOpacity(0.6)
                                      : Colors.grey.withOpacity(0.3),
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          tool.name,
                                          style: GoogleFonts.sourceCodePro(
                                            color: tool.isUnlocked
                                                ? const Color(0xFF00FF00)
                                                : Colors.grey,
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                                            decoration: BoxDecoration(
                                              color: _getPowerLevelColor(tool.powerLevel).withOpacity(0.2),
                                              border: Border.all(
                                                color: _getPowerLevelColor(tool.powerLevel).withOpacity(0.6),
                                              ),
                                              borderRadius: BorderRadius.circular(1),
                                            ),
                                            child: Text(
                                              'PWR ${tool.powerLevel}',
                                              style: GoogleFonts.sourceCodePro(
                                                color: _getPowerLevelColor(tool.powerLevel),
                                                fontSize: 6,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Icon(
                                            tool.isUnlocked ? Icons.lock_open : Icons.lock,
                                            color: tool.isUnlocked
                                                ? const Color(0xFF00FF00)
                                                : Colors.grey,
                                            size: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    tool.description,
                                    style: GoogleFonts.sourceCodePro(
                                      color: const Color(0xFF00FF00).withOpacity(0.7),
                                      fontSize: 7,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (tool.usageCount > 0)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        'Used: ${tool.usageCount} times',
                                        style: GoogleFonts.sourceCodePro(
                                          color: Colors.cyan,
                                          fontSize: 6,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getPowerLevelColor(int powerLevel) {
    if (powerLevel >= 8) return Colors.red;
    if (powerLevel >= 6) return Colors.orange;
    if (powerLevel >= 4) return Colors.yellow;
    return Colors.green;
  }
}
