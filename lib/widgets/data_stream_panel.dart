import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../bloc/hacker_bloc.dart';
import '../bloc/hacker_state.dart';

class DataStreamPanel extends StatelessWidget {
  const DataStreamPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HackerBloc, HackerState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              // Header with animated text
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(4),
                child: DefaultTextStyle(
                  style: GoogleFonts.sourceCodePro(
                    color: Colors.green,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText('ACCESSING DATABASE...'),
                      TyperAnimatedText('DECRYPTING FILES...'),
                      TyperAnimatedText('EXTRACTING DATA...'),
                      TyperAnimatedText('ANALYZING PATTERNS...'),
                    ],
                    repeatForever: true,
                    pause: const Duration(milliseconds: 1000),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Data stream
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
                    itemCount: state.dataStream.length,
                    itemBuilder: (context, index) {
                      final reversedIndex = state.dataStream.length - 1 - index;
                      final entry = state.dataStream[reversedIndex];

                      // Parse timestamp and message
                      final parts = entry.split('] ');
                      final timestamp = parts[0].substring(1);
                      final message = parts.length > 1 ? parts[1] : entry;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Timestamp
                            Text(
                              '[${timestamp.length >= 6 ? timestamp.substring(timestamp.length - 6) : timestamp}]',
                              style: GoogleFonts.sourceCodePro(
                                color: Colors.green.withOpacity(0.6),
                                fontSize: 8,
                              ),
                            ),
                            const SizedBox(width: 4),

                            // Message
                            Expanded(
                              child: Text(
                                message,
                                style: GoogleFonts.sourceCodePro(
                                  color: _getMessageColor(message),
                                  fontSize: 9,
                                  height: 1.2,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Progress indicators
              const SizedBox(height: 8),
              Column(
                children: [
                  _buildProgressBar('DOWNLOAD', 0.7),
                  const SizedBox(height: 4),
                  _buildProgressBar('DECRYPT', 0.4),
                  const SizedBox(height: 4),
                  _buildProgressBar('ANALYZE', 0.9),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getMessageColor(String message) {
    if (message.toLowerCase().contains('error') || message.toLowerCase().contains('failed')) {
      return Colors.red;
    } else if (message.toLowerCase().contains('warning') || message.toLowerCase().contains('unstable')) {
      return Colors.orange;
    } else if (message.toLowerCase().contains('success') || message.toLowerCase().contains('complete')) {
      return Colors.lightGreen;
    } else if (message.toLowerCase().contains('critical') || message.toLowerCase().contains('compromised')) {
      return Colors.red.withOpacity(0.8);
    } else if (message.toLowerCase().contains('scanning') || message.toLowerCase().contains('cracking')) {
      return Colors.cyan;
    }
    return Colors.green.withOpacity(0.8);
  }

  Widget _buildProgressBar(String label, double progress) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: GoogleFonts.sourceCodePro(
              color: Colors.green.withOpacity(0.7),
              fontSize: 8,
            ),
          ),
        ),
        Expanded(
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.green.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(
              progress > 0.8 ? Colors.lightGreen : Colors.green,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '${(progress * 100).toInt()}%',
          style: GoogleFonts.sourceCodePro(
            color: Colors.green,
            fontSize: 8,
          ),
        ),
      ],
    );
  }
}
