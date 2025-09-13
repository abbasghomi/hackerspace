import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'dart:async';

class HexDumpPanel extends StatefulWidget {
  const HexDumpPanel({super.key});

  @override
  State<HexDumpPanel> createState() => _HexDumpPanelState();
}

class _HexDumpPanelState extends State<HexDumpPanel> {
  final List<String> _hexLines = [];
  Timer? _hexTimer;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _generateInitialHexDump();
    _hexTimer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      _addHexLine();
    });
  }

  @override
  void dispose() {
    _hexTimer?.cancel();
    super.dispose();
  }

  void _generateInitialHexDump() {
    for (int i = 0; i < 12; i++) {
      _hexLines.add(_generateHexLine(i * 16));
    }
  }

  void _addHexLine() {
    if (_hexLines.length > 20) {
      _hexLines.removeAt(0);
    }
    _hexLines.add(_generateHexLine(_hexLines.length * 16));
    if (mounted) setState(() {});
  }

  String _generateHexLine(int offset) {
    final hexOffset = offset.toRadixString(16).padLeft(8, '0').toUpperCase();
    final hexBytes = List.generate(16, (i) => _random.nextInt(256).toRadixString(16).padLeft(2, '0').toUpperCase()).join(' ');
    final ascii = List.generate(16, (i) {
      final byte = _random.nextInt(256);
      return (byte >= 32 && byte <= 126) ? String.fromCharCode(byte) : '.';
    }).join('');

    return '$hexOffset: $hexBytes |$ascii|';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'MEMORY OFFSET',
                style: GoogleFonts.sourceCodePro(
                  color: Colors.cyan,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'ANALYZING',
                style: GoogleFonts.sourceCodePro(
                  color: Colors.orange,
                  fontSize: 9,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                border: Border.all(color: Colors.cyan.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(2),
              ),
              child: ListView.builder(
                itemCount: _hexLines.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Text(
                      _hexLines[index],
                      style: GoogleFonts.sourceCodePro(
                        color: Colors.cyan.withOpacity(0.8),
                        fontSize: 8,
                        height: 1.1,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'BUFFER OVERFLOW DETECTED AT 0x7FFE0000',
            style: GoogleFonts.sourceCodePro(
              color: Colors.red,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}
