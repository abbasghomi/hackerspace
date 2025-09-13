import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class MatrixPanel extends StatefulWidget {
  const MatrixPanel({super.key});

  @override
  State<MatrixPanel> createState() => _MatrixPanelState();
}

class _MatrixPanelState extends State<MatrixPanel> with TickerProviderStateMixin {
  late AnimationController _animationController;
  final List<MatrixColumn> _columns = [];
  final Random _random = Random();
  Timer? _columnTimer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    )..repeat();

    _columnTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (mounted) {
        setState(() {
          _updateColumns();
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _columnTimer?.cancel();
    super.dispose();
  }

  void _updateColumns() {
    // Add new columns randomly
    if (_random.nextDouble() < 0.3 && _columns.length < 50) {
      _columns.add(MatrixColumn(
        x: _random.nextDouble(),
        speed: 0.5 + _random.nextDouble() * 2,
        length: 5 + _random.nextInt(15),
        chars: _generateRandomChars(5 + _random.nextInt(15)),
      ));
    }

    // Update existing columns
    _columns.removeWhere((column) {
      column.y += column.speed * 0.02;
      return column.y > 1.2;
    });
  }

  List<String> _generateRandomChars(int length) {
    const chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZアイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン';
    return List.generate(length, (index) => chars[_random.nextInt(chars.length)]);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return CustomPaint(
          painter: MatrixPainter(_columns),
          size: Size.infinite,
        );
      },
    );
  }
}

class MatrixColumn {
  double x;
  double y;
  double speed;
  int length;
  List<String> chars;

  MatrixColumn({
    required this.x,
    this.y = -0.1,
    required this.speed,
    required this.length,
    required this.chars,
  });
}

class MatrixPainter extends CustomPainter {
  final List<MatrixColumn> columns;

  MatrixPainter(this.columns);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (final column in columns) {
      final x = column.x * size.width;
      final startY = column.y * size.height;

      for (int i = 0; i < column.chars.length; i++) {
        final y = startY + (i * 20);
        if (y < -20 || y > size.height + 20) continue;

        // Calculate opacity based on position in column
        double opacity = 1.0;
        if (i == 0) {
          opacity = 1.0; // Head of the column (brightest)
        } else if (i < 3) {
          opacity = 0.8 - (i * 0.2);
        } else {
          opacity = 0.4 - (i * 0.05);
        }
        opacity = opacity.clamp(0.0, 1.0);

        paint.color = Color.fromRGBO(0, 255, 0, opacity * 0.3);

        final textPainter = TextPainter(
          text: TextSpan(
            text: column.chars[i],
            style: TextStyle(
              color: paint.color,
              fontSize: 14,
              fontFamily: 'Courier',
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        );

        textPainter.layout();
        textPainter.paint(canvas, Offset(x, y));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
