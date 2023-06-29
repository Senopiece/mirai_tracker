import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/auth.dart';
import 'pages/watch.dart';

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
  runApp(const MiraiTracker());
}

class MiraiTracker extends StatelessWidget {
  const MiraiTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        final uri = settings.name != null ? Uri.parse(settings.name!) : null;
        if (uri != null && uri.path == "/watch") {
          // requires parameter "/watch?deviceId=<id>"
          String? deviceId;
          if (uri.queryParameters.containsKey('deviceId')) {
            deviceId = uri.queryParameters['deviceId']!;
          }

          return MaterialPageRoute(
            builder: (context) {
              return WatchPage(deviceId: deviceId);
            },
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const AuthPage(),
          );
        }
      },
    );
  }
}
