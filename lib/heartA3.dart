import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ECG Animation'),
        ),
        body: EcgAnimation(),
      ),
    );
  }
}

class EcgAnimation extends StatefulWidget {
  @override
  _EcgAnimationState createState() => _EcgAnimationState();
}

class _EcgAnimationState extends State<EcgAnimation> {
  late Timer _timer;
  late List<double> _ecgData;
  double _currentValue = 0.5;

  @override
  void initState() {
    super.initState();
    _ecgData = List.generate(100, (index) => 0.5);
    _startSimulation();
  }

  void _startSimulation() {
    const Duration duration = Duration(milliseconds: 200);
    _timer = Timer.periodic(duration, (timer) {
      _updateEcgData();
    });
  }

  void _updateEcgData() {
    setState(() {
      _ecgData.removeAt(0);
      _currentValue = 0.5 + Random().nextDouble() * 0.1 - 0.05;
      _ecgData.add(_currentValue);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 200,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: CustomPaint(
          painter: EcgPainter(_ecgData),
        ),
      ),
    );
  }
}

class EcgPainter extends CustomPainter {
  final List<double> ecgData;

  EcgPainter(this.ecgData);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 5;

    final Path path = Path();

    for (int i = 0; i < ecgData.length; i++) {
      final double x = i * size.width / ecgData.length;
      final double y = size.height - ecgData[i] * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
