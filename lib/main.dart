import 'package:flutter/material.dart';
import 'chart.dart';
import 'map.dart';
import 'services/mirai_tracker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static const tracker = MiraiTracker("aremfincs1uk8m4rvrk9");

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // so that all the child states would be reloaded on my setState()
  var _childrenKey = UniqueKey();

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
          title: const Text('Mirai Tracker'),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async => setState(() {
            _childrenKey = UniqueKey();
          }),
          child: SingleChildScrollView(
            child: Column(
              key: _childrenKey,
              children: [
                const SizedBox(
                  height: 20,
                ),
                _hintRow(Colors.blue, 'Humidity'),
                _hintRow(Colors.red, 'Temperature'),
                const HumidityAndTemperatureChart(tracker: MyApp.tracker),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: const TrackerMap(tracker: MyApp.tracker),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
