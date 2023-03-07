import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final double percentage;
  final Color primaryColor;
  final Color secondaryColor;
  final double strokePrimary;
  final double strokeSecondary;
  // final double startPosition; // TODO añadir las opciones [LEFT, RIGHT, TOP, BOTTOM]

  const RadialProgress(
      {super.key,
      required this.percentage,
      this.primaryColor = Colors.blue,
      this.secondaryColor = Colors.grey,
      this.strokeSecondary = 4,
      this.strokePrimary = 10});

  @override
  State<RadialProgress> createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late double lastPercentage;

  @override
  void initState() {
    lastPercentage = widget.percentage;
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0);

    final diff = widget.percentage - lastPercentage;
    lastPercentage = widget.percentage;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: _MyRadialProgressGradient(
                (widget.percentage - diff) + (diff * controller.value),
                widget.primaryColor,
                widget.secondaryColor,
                widget.strokeSecondary,
                widget.strokePrimary),
          ),
        );
      },
    );
  }
}

class _MyRadialProgress extends CustomPainter {
  final double percentage;
  final Color primaryColor;
  final Color secondaryColor;
  final double strokePrimary;
  final double strokeSecondary;

  _MyRadialProgress(this.percentage, this.primaryColor, this.secondaryColor,
      this.strokeSecondary, this.strokePrimary);

  @override
  void paint(Canvas canvas, Size size) {
    // Circulo completado
    final paint = Paint()
      ..strokeWidth = strokeSecondary
      ..color = secondaryColor
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double radius = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radius, paint);

    // Arco
    final paintArc = Paint()
      ..strokeWidth = strokePrimary
      ..color = primaryColor
      ..strokeCap = StrokeCap.round
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

class _MyRadialProgressGradient extends CustomPainter {
  final double percentage;
  final Color primaryColor;
  final Color secondaryColor;
  final double strokePrimary;
  final double strokeSecondary;

  _MyRadialProgressGradient(this.percentage, this.primaryColor,
      this.secondaryColor, this.strokeSecondary, this.strokePrimary);

  @override
  void paint(Canvas canvas, Size size) {
    const Gradient gradient =  LinearGradient(
      colors: [
        Color(0xffC012FF),
        Color(0xff6D05E8),
        Colors.red,
      ],
    );
    final Rect rect = Rect.fromCircle(center: const Offset(0, 0), radius: 180);

    // Circulo completado
    final paint = Paint()
      ..strokeWidth = strokeSecondary
      ..color = secondaryColor
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double radius = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radius, paint);

    // Arco
    final paintArc = Paint()
      ..strokeWidth = strokePrimary
      // ..color = primaryColor
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round
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
