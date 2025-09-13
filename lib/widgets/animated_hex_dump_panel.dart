import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedHexDumpPanel extends StatefulWidget {
  const AnimatedHexDumpPanel({super.key});

  @override
  State<AnimatedHexDumpPanel> createState() => _AnimatedHexDumpPanelState();
}

class _AnimatedHexDumpPanelState extends State<AnimatedHexDumpPanel>
    with TickerProviderStateMixin {
  late AnimationController _scrollController;
  Timer? _updateTimer;
  final Random _random = Random();

  List<HexLine> hexLines = [];
  int _currentOffset = 0;
  bool _isAnalyzing = false;

  @override
  void initState() {
    super.initState();

    _scrollController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _generateHexData();

    _updateTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (mounted) {
        setState(() {
          _updateHexData();
        });
      }
    });
  }

  void _generateHexData() {
    hexLines.clear();
    for (int i = 0; i < 15; i++) {
      hexLines.add(HexLine(
        offset: _currentOffset + (i * 16),
        hexData: _generateRandomHex(16),
        asciiData: _generateRandomAscii(16),
        isHighlighted: _random.nextDouble() > 0.8,
        isSuspicious: _random.nextDouble() > 0.9,
      ));
    }
  }

  String _generateRandomHex(int count) {
    const hexChars = '0123456789ABCDEF';
    String result = '';
    for (int i = 0; i < count; i++) {
      if (i > 0 && i % 2 == 0) result += ' ';
      result += hexChars[_random.nextInt(16)];
      result += hexChars[_random.nextInt(16)];
    }
    return result;
  }

  String _generateRandomAscii(int count) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()_+-=[]{}|;:,.<>?';
    String result = '';
    for (int i = 0; i < count; i++) {
      if (_random.nextDouble() > 0.3) {
        result += chars[_random.nextInt(chars.length)];
      } else {
        result += '.';
      }
    }
    return result;
  }

  void _updateHexData() {
    _currentOffset += 16;

    hexLines.removeAt(0);
    hexLines.add(HexLine(
      offset: _currentOffset + (14 * 16),
      hexData: _generateRandomHex(16),
      asciiData: _generateRandomAscii(16),
      isHighlighted: _random.nextDouble() > 0.8,
      isSuspicious: _random.nextDouble() > 0.9,
    ));

    for (var line in hexLines) {
      if (_random.nextDouble() < 0.1) {
        line.isHighlighted = !line.isHighlighted;
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _updateTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        border: Border.all(color: const Color(0xFF00FF41), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFF003300),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.memory, color: Color(0xFF00FF41), size: 16),
                const SizedBox(width: 8),
                const Text(
                  'HEX ANALYZER',
                  style: TextStyle(
                    color: Color(0xFF00FF41),
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isAnalyzing = !_isAnalyzing;
                      if (_isAnalyzing) {
                        _generateHexData();
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _isAnalyzing ? Colors.red : const Color(0xFF003300),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: const Color(0xFF00FF41)),
                    ),
                    child: Text(
                      _isAnalyzing ? 'SCAN' : 'IDLE',
                      style: const TextStyle(
                        color: Color(0xFF00FF41),
                        fontFamily: 'monospace',
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: hexLines.map((line) => _buildHexLine(line)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHexLine(HexLine line) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          // Offset
          Container(
            width: 60,
            child: Text(
              '${line.offset.toRadixString(16).toUpperCase().padLeft(8, '0')}:',
              style: TextStyle(
                color: line.isSuspicious ? Colors.red : const Color(0xFF666666),
                fontFamily: 'monospace',
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Hex data
          Expanded(
            flex: 2,
            child: Text(
              line.hexData,
              style: TextStyle(
                color: line.isHighlighted
                    ? Colors.yellow
                    : line.isSuspicious
                        ? Colors.red
                        : const Color(0xFF00FF41),
                fontFamily: 'monospace',
                fontSize: 9,
                backgroundColor: line.isHighlighted
                    ? Colors.yellow.withOpacity(0.2)
                    : null,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // ASCII data
          Expanded(
            child: Text(
              line.asciiData,
              style: TextStyle(
                color: line.isHighlighted
                    ? Colors.yellow
                    : const Color(0xFF00FF41).withOpacity(0.7),
                fontFamily: 'monospace',
                fontSize: 9,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HexLine {
  final int offset;
  final String hexData;
  final String asciiData;
  bool isHighlighted;
  final bool isSuspicious;

  HexLine({
    required this.offset,
    required this.hexData,
    required this.asciiData,
    required this.isHighlighted,
    required this.isSuspicious,
  });
}
