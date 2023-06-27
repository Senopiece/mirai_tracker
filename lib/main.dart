import 'package:flutter/material.dart';
import 'chart.dart';
import 'services/mirai_tracker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const tracker = MiraiTracker("aremfincs1uk8m4rvrk9");

  const MyApp({super.key});

  Widget _hintRow(Color color, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Container(
            color: color,
            padding: const EdgeInsets.all(10.0),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mirai Tracker',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Report History'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            _hintRow(Colors.blue, 'Humidity'),
            _hintRow(Colors.red, 'Temperature'),
            const HumidityAndTemperatureChart(
              tracker: tracker,
            ),
          ],
        ),
      ),
    );
  }
}
