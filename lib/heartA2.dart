import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Atrial Fibrillation ECG Animation'),
        ),
        body: ECGAnimation(),
      ),
    );
  }
}

class ECGAnimation extends StatefulWidget {
  @override
  _ECGAnimationState createState() => _ECGAnimationState();
}

class _ECGAnimationState extends State<ECGAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(300, 150),
        painter: ECGPainter(animation: _controller),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ECGPainter extends CustomPainter {
  final Animation<double> animation;

  ECGPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    final double centerY = size.height / 2;
    final double width = size.width;
    final double height = size.height;

    for (double t = 0.0; t < 1.0; t += 0.01) {
      final double x = lerpDouble(0, width, t)!;
      final double y = centerY + 20 * _getECGSignal(t);
      canvas.drawLine(Offset(x, centerY), Offset(x, y), paint);
    }
  }

  double _getECGSignal(double t) {
    // Adjust this function to simulate the irregular ECG signal of Atrial Fibrillation
    return 0.5 * (1.0 + 0.8 * sin(animation.value * 2 * pi * t));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
