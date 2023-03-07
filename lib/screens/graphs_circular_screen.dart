import 'package:flutter/material.dart';

import '../widgets/radial_progress.dart';

class GraphsCircularScreen extends StatefulWidget {
  const GraphsCircularScreen({Key? key}) : super(key: key);

  @override
  State<GraphsCircularScreen> createState() => _GraphsCircularScreenState();
}

class _GraphsCircularScreenState extends State<GraphsCircularScreen> {
  double percentage = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRadiasProgress(
                percentage: percentage,
                color: Colors.red,
              ),
              CustomRadiasProgress(
                percentage: percentage,
                color: Colors.blue,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRadiasProgress(
                percentage: percentage,
                color: Colors.green,
              ),
              CustomRadiasProgress(
                percentage: percentage,
                color: Colors.purple,
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            percentage += 10;
            if (percentage > 100) {
              percentage = 0;
            }
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class CustomRadiasProgress extends StatelessWidget {
  const CustomRadiasProgress({
    super.key,
    required this.percentage,
    required this.color,
  });

  final double percentage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: Stack(children: [
        RadialProgress(
          percentage: percentage,
          primaryColor: color,
        ),
        Center(
          child: Text('$percentage%'),
        )
      ]),
    );
  }
}
