import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/hacker_bloc.dart';
import '../bloc/hacker_state.dart';
import '../bloc/hacker_event.dart';

class MissionsPanel extends StatelessWidget {
  const MissionsPanel({super.key});

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
                    'ACTIVE MISSIONS',
                    style: GoogleFonts.sourceCodePro(
                      color: const Color(0xFF00FF00),
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${state.missions.where((m) => !m.isCompleted).length}/${state.missions.length}',
                    style: GoogleFonts.sourceCodePro(
                      color: const Color(0xFF00FF00).withOpacity(0.8),
                      fontSize: 8,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Expanded(
                child: state.missions.isEmpty
                    ? Center(
                        child: Text(
                          'No missions available\nType "missions" to refresh',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sourceCodePro(
                            color: const Color(0xFF00FF00).withOpacity(0.6),
                            fontSize: 9,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: state.missions.length,
                        itemBuilder: (context, index) {
                          final mission = state.missions[index];
                          return InkWell(
                            onTap: () => context.read<HackerBloc>().add(StartMission(mission.id)),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 4),
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                border: Border.all(
                                  color: mission.isCompleted
                                      ? Colors.grey.withOpacity(0.3)
                                      : const Color(0xFF00FF00).withOpacity(0.4),
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
                                          mission.name,
                                          style: GoogleFonts.sourceCodePro(
                                            color: mission.isCompleted
                                                ? Colors.grey
                                                : const Color(0xFF00FF00),
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: _getDifficultyColor(mission.difficulty).withOpacity(0.2),
                                          border: Border.all(
                                            color: _getDifficultyColor(mission.difficulty).withOpacity(0.6),
                                          ),
                                          borderRadius: BorderRadius.circular(1),
                                        ),
                                        child: Text(
                                          'LVL ${mission.difficulty}',
                                          style: GoogleFonts.sourceCodePro(
                                            color: _getDifficultyColor(mission.difficulty),
                                            fontSize: 6,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    mission.description,
                                    style: GoogleFonts.sourceCodePro(
                                      color: const Color(0xFF00FF00).withOpacity(0.7),
                                      fontSize: 7,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Reward: ${mission.reward} XP',
                                        style: GoogleFonts.sourceCodePro(
                                          color: Colors.yellow,
                                          fontSize: 6,
                                        ),
                                      ),
                                      if (mission.isCompleted)
                                        Text(
                                          'COMPLETED',
                                          style: GoogleFonts.sourceCodePro(
                                            color: Colors.green,
                                            fontSize: 6,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                    ],
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

  Color _getDifficultyColor(int difficulty) {
    if (difficulty >= 8) return Colors.red;
    if (difficulty >= 6) return Colors.orange;
    if (difficulty >= 4) return Colors.yellow;
    return Colors.green;
  }
}
