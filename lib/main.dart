import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'chart.dart';
import 'map.dart';
import 'services/mirai_tracker.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    // carshlytics is not supported on web
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
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

  Widget _content() {
    return SingleChildScrollView(
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
            child: TrackerMap(tracker: MyApp.tracker),
          )
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
        body: kIsWeb // no refresh indicator on web platform
            ? _content()
            : RefreshIndicator(
                onRefresh: () async => setState(() {
                  _childrenKey = UniqueKey();
                }),
                child: _content(),
              ),
      ),
    );
  }
}
