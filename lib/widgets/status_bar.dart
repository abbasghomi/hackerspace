import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:async';

class StatusBar extends StatefulWidget {
  const StatusBar({super.key});

  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  String _currentTime = '';
  Timer? _timeTimer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  @override
  void dispose() {
    _timeTimer?.cancel();
    super.dispose();
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime = '${now.hour.toString().padLeft(2, '0')}:'
          '${now.minute.toString().padLeft(2, '0')}:'
          '${now.second.toString().padLeft(2, '0')}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.9),
            Colors.green.withOpacity(0.1),
            Colors.black.withOpacity(0.9),
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: Colors.green.withOpacity(0.4),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            // System status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                border: Border.all(color: Colors.red.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                'SYSTEM COMPROMISED',
                style: GoogleFonts.sourceCodePro(
                  color: Colors.red,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Animated status message
            Expanded(
              child: DefaultTextStyle(
                style: GoogleFonts.sourceCodePro(
                  color: Colors.green,
                  fontSize: 11,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText('NEURAL NETWORK ACTIVE...'),
                    TyperAnimatedText('DECRYPTION IN PROGRESS...'),
                    TyperAnimatedText('FIREWALL BYPASSED...'),
                    TyperAnimatedText('ACCESS GRANTED...'),
                    TyperAnimatedText('GHOST PROTOCOL ENABLED...'),
                  ],
                  repeatForever: true,
                  pause: const Duration(milliseconds: 2000),
                ),
              ),
            ),

            // Connection status
            Row(
              children: [
                Icon(
                  Icons.wifi,
                  color: Colors.green,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  'TOR NETWORK',
                  style: GoogleFonts.sourceCodePro(
                    color: Colors.green,
                    fontSize: 10,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 16),

            // CPU usage
            Text(
              'CPU: 87%',
              style: GoogleFonts.sourceCodePro(
                color: Colors.orange,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(width: 16),

            // Memory usage
            Text(
              'MEM: 94%',
              style: GoogleFonts.sourceCodePro(
                color: Colors.red,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(width: 16),

            // Current time
            Text(
              _currentTime,
              style: GoogleFonts.sourceCodePro(
                color: Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(width: 16),

            // Exit button
            InkWell(
              onTap: () {
                // Add exit functionality if needed
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  'X',
                  style: GoogleFonts.sourceCodePro(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
