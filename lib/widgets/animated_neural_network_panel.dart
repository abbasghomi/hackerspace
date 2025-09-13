import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedNeuralNetworkPanel extends StatefulWidget {
  const AnimatedNeuralNetworkPanel({super.key});

  @override
  State<AnimatedNeuralNetworkPanel> createState() => _AnimatedNeuralNetworkPanelState();
}

class _AnimatedNeuralNetworkPanelState extends State<AnimatedNeuralNetworkPanel>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _connectionController;
  Timer? _updateTimer;
  final Random _random = Random();

  List<NetworkNode> nodes = [];
  List<Connection> connections = [];
  double _systemActivity = 0.0;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _connectionController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _generateNodes();
    _generateConnections();

    _updateTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _updateNodeActivity();
          _systemActivity = _random.nextDouble();
        });
      }
    });
  }

  void _generateNodes() {
    nodes.clear();
    for (int i = 0; i < 12; i++) {
      nodes.add(NetworkNode(
        id: 'node_$i',
        x: _random.nextDouble() * 280 + 20,
        y: _random.nextDouble() * 180 + 20,
        activity: _random.nextDouble(),
        nodeType: NodeType.values[_random.nextInt(NodeType.values.length)],
      ));
    }
  }

  void _generateConnections() {
    connections.clear();
    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        if (_random.nextDouble() > 0.7) {
          connections.add(Connection(
            from: nodes[i],
            to: nodes[j],
            strength: _random.nextDouble(),
            isActive: _random.nextBool(),
          ));
        }
      }
    }
  }

  void _updateNodeActivity() {
    for (var node in nodes) {
      node.activity = (_random.nextDouble() * 0.3 + 0.7).clamp(0.0, 1.0);
    }

    for (var connection in connections) {
      connection.isActive = _random.nextDouble() > 0.6;
      connection.strength = _random.nextDouble();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _connectionController.dispose();
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
                const Icon(Icons.psychology, color: Color(0xFF00FF41), size: 16),
                const SizedBox(width: 8),
                const Text(
                  'NEURAL NETWORK',
                  style: TextStyle(
                    color: Color(0xFF00FF41),
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _systemActivity > 0.7 ? Colors.red :
                          _systemActivity > 0.4 ? Colors.orange : const Color(0xFF00FF41),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: AnimatedBuilder(
                animation: Listenable.merge([_pulseController, _connectionController]),
                builder: (context, child) {
                  return CustomPaint(
                    painter: NeuralNetworkPainter(
                      nodes: nodes,
                      connections: connections,
                      pulseAnimation: _pulseController,
                      connectionAnimation: _connectionController,
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
                      'Activity:',
                      style: TextStyle(
                        color: Color(0xFF00FF41),
                        fontFamily: 'monospace',
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      '${(_systemActivity * 100).toInt()}%',
                      style: TextStyle(
                        color: _systemActivity > 0.7 ? Colors.red : const Color(0xFF00FF41),
                        fontFamily: 'monospace',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: _systemActivity,
                  backgroundColor: Colors.black,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _systemActivity > 0.7 ? Colors.red : const Color(0xFF00FF41),
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

class NetworkNode {
  final String id;
  double x;
  double y;
  double activity;
  final NodeType nodeType;

  NetworkNode({
    required this.id,
    required this.x,
    required this.y,
    required this.activity,
    required this.nodeType,
  });
}

class Connection {
  final NetworkNode from;
  final NetworkNode to;
  double strength;
  bool isActive;

  Connection({
    required this.from,
    required this.to,
    required this.strength,
    required this.isActive,
  });
}

enum NodeType { cpu, memory, network, storage, ai }

class NeuralNetworkPainter extends CustomPainter {
  final List<NetworkNode> nodes;
  final List<Connection> connections;
  final Animation<double> pulseAnimation;
  final Animation<double> connectionAnimation;

  NeuralNetworkPainter({
    required this.nodes,
    required this.connections,
    required this.pulseAnimation,
    required this.connectionAnimation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw connections first
    for (var connection in connections) {
      if (connection.isActive) {
        _drawConnection(canvas, connection, size);
      }
    }

    // Draw nodes on top
    for (var node in nodes) {
      _drawNode(canvas, node, size);
    }
  }

  void _drawConnection(Canvas canvas, Connection connection, Size size) {
    final paint = Paint()
      ..color = Color(0xFF00FF41).withOpacity(
        connection.strength * 0.8 * connectionAnimation.value
      )
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Animated pulse effect along the connection
    final pulseOffset = connectionAnimation.value;
    final path = Path();
    path.moveTo(connection.from.x, connection.from.y);
    path.lineTo(connection.to.x, connection.to.y);

    canvas.drawPath(path, paint);

    // Draw pulse dot
    if (connection.isActive) {
      final pulseX = connection.from.x +
          (connection.to.x - connection.from.x) * pulseOffset;
      final pulseY = connection.from.y +
          (connection.to.y - connection.from.y) * pulseOffset;

      final pulsePaint = Paint()
        ..color = Color(0xFF00FF41).withOpacity(0.9)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(pulseX, pulseY),
        2.0 * connection.strength,
        pulsePaint,
      );
    }
  }

  void _drawNode(Canvas canvas, NetworkNode node, Size size) {
    final nodeSize = 8.0 + (node.activity * 8.0) * pulseAnimation.value;

    // Outer glow
    final glowPaint = Paint()
      ..color = _getNodeColor(node.nodeType).withOpacity(0.3)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(node.x, node.y),
      nodeSize + 4,
      glowPaint,
    );

    // Main node
    final nodePaint = Paint()
      ..color = _getNodeColor(node.nodeType).withOpacity(0.9)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(node.x, node.y),
      nodeSize,
      nodePaint,
    );

    // Inner core
    final corePaint = Paint()
      ..color = Colors.white.withOpacity(node.activity)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(node.x, node.y),
      nodeSize * 0.3,
      corePaint,
    );

    // Activity ring
    if (node.activity > 0.7) {
      final ringPaint = Paint()
        ..color = _getNodeColor(node.nodeType)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      canvas.drawCircle(
        Offset(node.x, node.y),
        nodeSize + 6 + (4 * pulseAnimation.value),
        ringPaint,
      );
    }
  }

  Color _getNodeColor(NodeType type) {
    switch (type) {
      case NodeType.cpu:
        return const Color(0xFF00FF41);
      case NodeType.memory:
        return const Color(0xFF0099FF);
      case NodeType.network:
        return const Color(0xFFFF6600);
      case NodeType.storage:
        return const Color(0xFFFF00FF);
      case NodeType.ai:
        return const Color(0xFFFFFF00);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
