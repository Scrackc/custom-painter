import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularProgresScreen extends StatefulWidget {
  const CircularProgresScreen({Key? key}) : super(key: key);

  @override
  State<CircularProgresScreen> createState() => _CircularProgresScreenState();
}

class _CircularProgresScreenState extends State<CircularProgresScreen> with SingleTickerProviderStateMixin{
  
  late AnimationController controller;
  double percentage = 0.0;
  double newPercentage = 0.0;

  @override
  void initState() {

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    controller.addListener(() {
      // print('valor controller: ${controller.value}');
      setState(() {
        percentage = lerpDouble(percentage, newPercentage, controller.value)!;
      });
    });
    
    super.initState();

  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(5),
          width: 300,
          height: 300,
          child: CustomPaint(
            painter: _MyRadialProgress(percentage),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          percentage = newPercentage;
          newPercentage += 10;
          if(newPercentage > 100){
            newPercentage = 0;
            percentage = 0;
          }
          controller.forward( from: 0.0);
          setState(() {});
        },
        child: Icon(Icons.refresh),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

class _MyRadialProgress extends CustomPainter {
  final double percentage;

  _MyRadialProgress(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    // Circulo completado
    final paint = Paint()
      ..strokeWidth = 4
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double radius = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radius, paint);

    // Arco
    final paintArc = Paint()
      ..strokeWidth = 10
      ..color = Colors.pink
      ..style = PaintingStyle.stroke;

    // Parte que se debera ir llenando
    double arcAngle = 2 * pi * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      paintArc,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
