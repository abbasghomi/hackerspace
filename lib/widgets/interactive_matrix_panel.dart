import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class InteractiveMatrixPanel extends StatefulWidget {
  const InteractiveMatrixPanel({super.key});

  @override
  State<InteractiveMatrixPanel> createState() => _InteractiveMatrixPanelState();
}

class _InteractiveMatrixPanelState extends State<InteractiveMatrixPanel>
    with TickerProviderStateMixin {
  late AnimationController _rainController;
  Timer? _updateTimer;
  final Random _random = Random();

  List<MatrixColumn> columns = [];
  bool _isActive = true;
  double _intensity = 0.8;

  @override
  void initState() {
    super.initState();

    _rainController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    )..repeat();

    _generateColumns();

    _updateTimer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      if (mounted && _isActive) {
        setState(() {
          _updateMatrix();
        });
      }
    });
  }

  void _generateColumns() {
    columns.clear();
    for (int i = 0; i < 20; i++) {
      columns.add(MatrixColumn(
        x: i * 15.0,
        chars: _generateRandomChars(20),
        speed: _random.nextDouble() * 2 + 1,
        opacity: _random.nextDouble() * 0.8 + 0.2,
      ));
    }
  }

  List<String> _generateRandomChars(int count) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜｦﾝ';
    return List.generate(count, (index) => chars[_random.nextInt(chars.length)]);
  }

  void _updateMatrix() {
    for (var column in columns) {
      // Update characters
      for (int i = 0; i < column.chars.length; i++) {
        if (_random.nextDouble() < 0.1 * _intensity) {
          column.chars[i] = _generateRandomChars(1)[0];
        }
      }

      // Update column properties
      if (_random.nextDouble() < 0.05) {
        column.speed = _random.nextDouble() * 2 + 1;
        column.opacity = _random.nextDouble() * 0.8 + 0.2;
      }
    }
  }

  @override
  void dispose() {
    _rainController.dispose();
    _updateTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
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
                const Icon(Icons.grid_view, color: Color(0xFF00FF41), size: 16),
                const SizedBox(width: 8),
                const Text(
                  'MATRIX INTERFACE',
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
                      _isActive = !_isActive;
                    });
                  },
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isActive ? const Color(0xFF00FF41) : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _intensity = _intensity > 0.5 ? 0.3 : 1.0;
                  _generateColumns();
                });
              },
              child: AnimatedBuilder(
                animation: _rainController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: MatrixPainter(
                      columns: columns,
                      animation: _rainController,
                      intensity: _intensity,
                    ),
                    size: Size.infinite,
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'REALITY DISTORTION:',
                  style: TextStyle(
                    color: Color(0xFF00FF41),
                    fontFamily: 'monospace',
                    fontSize: 9,
                  ),
                ),
                Text(
                  '${(_intensity * 100).toInt()}%',
                  style: const TextStyle(
                    color: Color(0xFF00FF41),
                    fontFamily: 'monospace',
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MatrixColumn {
  final double x;
  final List<String> chars;
  double speed;
  double opacity;

  MatrixColumn({
    required this.x,
    required this.chars,
    required this.speed,
    required this.opacity,
  });
}

class MatrixPainter extends CustomPainter {
  final List<MatrixColumn> columns;
  final Animation<double> animation;
  final double intensity;

  MatrixPainter({
    required this.columns,
    required this.animation,
    required this.intensity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var column in columns) {
      _drawColumn(canvas, column, size);
    }
  }

  void _drawColumn(Canvas canvas, MatrixColumn column, Size size) {
    const textStyle = TextStyle(
      color: Color(0xFF00FF41),
      fontFamily: 'monospace',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );

    for (int i = 0; i < column.chars.length; i++) {
      final y = (i * 15.0 + animation.value * 100 * column.speed) % size.height;

      // Fade effect based on position
      final fadePosition = y / size.height;
      final opacity = (column.opacity * intensity *
          (1.0 - fadePosition * 0.7)).clamp(0.0, 1.0);

      if (opacity > 0.1) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: column.chars[i],
            style: textStyle.copyWith(
              color: Color(0xFF00FF41).withOpacity(opacity),
            ),
          ),
          textDirection: TextDirection.ltr,
        );

        textPainter.layout();
        textPainter.paint(canvas, Offset(column.x, y));

        // Add glow effect for bright characters
        if (opacity > 0.7) {
          final glowPainter = TextPainter(
            text: TextSpan(
              text: column.chars[i],
              style: textStyle.copyWith(
                color: Color(0xFF00FF41).withOpacity(0.3),
                fontSize: 14,
              ),
            ),
            textDirection: TextDirection.ltr,
          );

          glowPainter.layout();
          glowPainter.paint(canvas, Offset(column.x - 1, y - 1));
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
