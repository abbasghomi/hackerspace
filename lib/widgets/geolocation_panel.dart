import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class GeolocationPanel extends StatefulWidget {
  const GeolocationPanel({super.key});

  @override
  State<GeolocationPanel> createState() => _GeolocationPanelState();
}

class _GeolocationPanelState extends State<GeolocationPanel>
    with TickerProviderStateMixin {
  late AnimationController _radarController;
  late AnimationController _pulseController;
  Timer? _updateTimer;
  final Random _random = Random();

  List<Target> targets = [];
  double _radarAngle = 0;
  bool _isScanning = true;

  @override
  void initState() {
    super.initState();

    _radarController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _generateTargets();

    _updateTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted && _isScanning) {
        setState(() {
          _updateTargets();
          _radarAngle = _radarController.value * 2 * pi;
        });
      }
    });
  }

  void _generateTargets() {
    targets.clear();
    for (int i = 0; i < 8; i++) {
      targets.add(Target(
        id: 'T${i.toString().padLeft(3, '0')}',
        x: _random.nextDouble() * 160 + 20,
        y: _random.nextDouble() * 160 + 20,
        strength: _random.nextDouble(),
        type: TargetType.values[_random.nextInt(TargetType.values.length)],
        isActive: _random.nextBool(),
        lastSeen: DateTime.now(),
      ));
    }
  }

  void _updateTargets() {
    for (var target in targets) {
      // Random movement
      target.x += (_random.nextDouble() - 0.5) * 10;
      target.y += (_random.nextDouble() - 0.5) * 10;

      // Keep in bounds
      target.x = target.x.clamp(10.0, 190.0);
      target.y = target.y.clamp(10.0, 190.0);

      // Update properties
      if (_random.nextDouble() < 0.3) {
        target.isActive = _random.nextBool();
        target.strength = _random.nextDouble();
      }
    }

    // Occasionally add/remove targets
    if (_random.nextDouble() < 0.1) {
      if (targets.length < 10) {
        targets.add(Target(
          id: 'T${targets.length.toString().padLeft(3, '0')}',
          x: _random.nextDouble() * 160 + 20,
          y: _random.nextDouble() * 160 + 20,
          strength: _random.nextDouble(),
          type: TargetType.values[_random.nextInt(TargetType.values.length)],
          isActive: true,
          lastSeen: DateTime.now(),
        ));
      }
    }
  }

  @override
  void dispose() {
    _radarController.dispose();
    _pulseController.dispose();
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
                const Icon(Icons.radar, color: Color(0xFF00FF41), size: 16),
                const SizedBox(width: 8),
                const Text(
                  'GEOLOCATION RADAR',
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
                      _isScanning = !_isScanning;
                    });
                  },
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isScanning ? const Color(0xFF00FF41) : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: AnimatedBuilder(
                animation: Listenable.merge([_radarController, _pulseController]),
                builder: (context, child) {
                  return CustomPaint(
                    painter: RadarPainter(
                      targets: targets,
                      radarAngle: _radarAngle,
                      pulseAnimation: _pulseController,
                      isScanning: _isScanning,
                    ),
                    size: Size.infinite,
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'TARGETS:',
                      style: TextStyle(
                        color: Color(0xFF00FF41),
                        fontFamily: 'monospace',
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      '${targets.where((t) => t.isActive).length}/${targets.length}',
                      style: const TextStyle(
                        color: Color(0xFF00FF41),
                        fontFamily: 'monospace',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'RANGE:',
                      style: TextStyle(
                        color: Color(0xFF00FF41),
                        fontFamily: 'monospace',
                        fontSize: 10,
                      ),
                    ),
                    const Text(
                      '2.5 KM',
                      style: TextStyle(
                        color: Color(0xFF00FF41),
                        fontFamily: 'monospace',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Target {
  final String id;
  double x;
  double y;
  double strength;
  final TargetType type;
  bool isActive;
  final DateTime lastSeen;

  Target({
    required this.id,
    required this.x,
    required this.y,
    required this.strength,
    required this.type,
    required this.isActive,
    required this.lastSeen,
  });
}

enum TargetType { mobile, vehicle, aircraft, unknown }

class RadarPainter extends CustomPainter {
  final List<Target> targets;
  final double radarAngle;
  final Animation<double> pulseAnimation;
  final bool isScanning;

  RadarPainter({
    required this.targets,
    required this.radarAngle,
    required this.pulseAnimation,
    required this.isScanning,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 10;

    // Draw radar background
    _drawRadarBackground(canvas, center, radius);

    // Draw radar sweep
    if (isScanning) {
      _drawRadarSweep(canvas, center, radius);
    }

    // Draw pulse rings
    _drawPulseRings(canvas, center, radius);

    // Draw targets
    for (var target in targets) {
      if (target.isActive) {
        _drawTarget(canvas, target, center, radius, size);
      }
    }

    // Draw center dot
    final centerPaint = Paint()
      ..color = const Color(0xFF00FF41)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 3, centerPaint);
  }

  void _drawRadarBackground(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = const Color(0xFF00FF41).withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw concentric circles
    for (int i = 1; i <= 4; i++) {
      canvas.drawCircle(center, radius * i / 4, paint);
    }

    // Draw crosshairs
    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx + radius, center.dy),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy + radius),
      paint,
    );
  }

  void _drawRadarSweep(Canvas canvas, Offset center, double radius) {
    final sweepPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF00FF41).withOpacity(0.5),
          const Color(0xFF00FF41).withOpacity(0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    final path = Path();
    path.moveTo(center.dx, center.dy);
    path.arcTo(
      Rect.fromCircle(center: center, radius: radius),
      radarAngle - 0.3,
      0.6,
      false,
    );
    path.close();

    canvas.drawPath(path, sweepPaint);
  }

  void _drawPulseRings(Canvas canvas, Offset center, double radius) {
    final pulsePaint = Paint()
      ..color = const Color(0xFF00FF41).withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final pulseRadius = radius * pulseAnimation.value;
    canvas.drawCircle(center, pulseRadius, pulsePaint);
  }

  void _drawTarget(Canvas canvas, Target target, Offset center, double radius, Size size) {
    final targetPos = Offset(target.x, target.y);
    final color = _getTargetColor(target.type);

    // Target dot
    final targetPaint = Paint()
      ..color = color.withOpacity(target.strength)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(targetPos, 3, targetPaint);

    // Target ring
    final ringPaint = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(targetPos, 6, ringPaint);

    // Target ID
    final textPainter = TextPainter(
      text: TextSpan(
        text: target.id,
        style: TextStyle(
          color: color.withOpacity(0.8),
          fontFamily: 'monospace',
          fontSize: 8,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset(targetPos.dx + 8, targetPos.dy - 4));
  }

  Color _getTargetColor(TargetType type) {
    switch (type) {
      case TargetType.mobile:
        return const Color(0xFF00FF41);
      case TargetType.vehicle:
        return const Color(0xFF0099FF);
      case TargetType.aircraft:
        return const Color(0xFFFF6600);
      case TargetType.unknown:
        return Colors.red;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
