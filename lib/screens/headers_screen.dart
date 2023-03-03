import 'package:flutter/material.dart';
import 'package:ui_app/widgets/headers.dart';

class HeadersScreen extends StatelessWidget {
  const HeadersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HeaderWave(),
    );
  }
}