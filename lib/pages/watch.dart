import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/chart.dart';
import '../widgets/map.dart';
import '../services/mirai_tracker.dart';

class WatchPage extends StatefulWidget {
  final String? deviceId;

  const WatchPage({super.key, this.deviceId});

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  // so that all the child states would be reloaded on my setState()
  var _childrenKey = UniqueKey();

  Widget _hintRow(Color color, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      child: Row(
        children: [
          Container(
            color: color,
            padding: const EdgeInsets.all(8.0),
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

  Widget _content() {
    final tracker =
        widget.deviceId != null ? MiraiTracker(widget.deviceId!) : null;

    if (tracker == null) {
      // TODO: beautify text
      return const Center(
        child: Text("Provide deviceId"),
      );
    }

    return SingleChildScrollView(
      child: Column(
        key: _childrenKey,
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              '[ ${widget.deviceId!} ]',
              style: TextStyle(
                fontSize: 20.0,
                color: Theme.of(context).hintColor,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _hintRow(Colors.blue, 'Humidity'),
          _hintRow(Colors.red, 'Temperature'),
          HumidityAndTemperatureChart(tracker: tracker),
          const SizedBox(
            width: 200,
            child: Divider(),
          ),
          TrackerMap(tracker: tracker),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mirai Tracker'),
        centerTitle: true,
      ),
      body: kIsWeb // no refresh indicator on web platform
          ? _content()
          : RefreshIndicator(
              onRefresh: () async => setState(() {
                _childrenKey = UniqueKey();
              }),
              child: _content(),
            ),
    );
  }
}
