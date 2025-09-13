import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/hacker_bloc.dart';
import '../bloc/hacker_state.dart';
import 'package:google_fonts/google_fonts.dart';

class SystemMonitorPanel extends StatelessWidget {
  const SystemMonitorPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HackerBloc, HackerState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              // System status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'STATUS:',
                    style: GoogleFonts.sourceCodePro(
                      color: Colors.green,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'COMPROMISED',
                    style: GoogleFonts.sourceCodePro(
                      color: Colors.red,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // System logs
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    border: Border.all(
                      color: Colors.green.withOpacity(0.3),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: ListView.builder(
                    reverse: true,
                    itemCount: state.systemLogs.length,
                    itemBuilder: (context, index) {
                      final reversedIndex = state.systemLogs.length - 1 - index;
                      final log = state.systemLogs[reversedIndex];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Text(
                          log,
                          style: GoogleFonts.sourceCodePro(
                            color: _getLogColor(log),
                            fontSize: 9,
                            height: 1.2,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Quick stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'UPTIME',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.green.withOpacity(0.7),
                          fontSize: 8,
                        ),
                      ),
                      Text(
                        '127:42:18',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.green,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'ALERTS',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.green.withOpacity(0.7),
                          fontSize: 8,
                        ),
                      ),
                      Text(
                        '247',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.red,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getLogColor(String log) {
    if (log.contains('[ALERT]') || log.contains('[CRITICAL]')) {
      return Colors.red;
    } else if (log.contains('[WARNING]')) {
      return Colors.orange;
    } else if (log.contains('[SUCCESS]')) {
      return Colors.lightGreen;
    } else if (log.contains('[ERROR]')) {
      return Colors.red.withOpacity(0.8);
    } else if (log.contains('[INFO]') || log.contains('[STATUS]')) {
      return Colors.cyan;
    } else if (log.contains('[TRACE]') || log.contains('[DEBUG]')) {
      return Colors.green.withOpacity(0.6);
    }
    return Colors.green.withOpacity(0.8);
  }
}
