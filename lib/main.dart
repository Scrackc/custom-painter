import 'package:flutter/material.dart';
import 'package:ui_app/screens/graphs_circular_screen.dart';
// import 'package:ui_app/labs/circular_progress_screen.dart';
// import 'package:ui_app/retos/cuadrado_animado_screen.dart';
// import 'package:ui_app/screens/animaciones_screen.dart';
// import 'package:ui_app/screens/headers_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ui app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        useMaterial3: true
      ),
      home: const GraphsCircularScreen(),
    );
  }
}