import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import 'backend/methods.dart';
import 'backend/variables.dart';

import 'screens/homesreen.dart';
import 'screens/datascreen.dart';
import 'screens/camerascreen.dart';
import 'screens/archivescreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer? dataTimer;

  @override
  void initState() {
    super.initState();
    dataTimer = Timer.periodic(
      const Duration(seconds: 1),
      (dataTimer) => getData("http://$connectedIP:$dataHttpPort/"),
    );
  }

  @override
  void dispose() {
    super.dispose();
    dataTimer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yildiz Rover UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Ubuntu-Regular",
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/homescreen':
            return PageTransition(
              child: const HomeScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/datascreen':
            return PageTransition(
              child: const DataScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/camerascreen':
            return PageTransition(
              child: const CameraScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/archivescreen':
            return PageTransition(
              child: const ArchiveScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          default:
            return PageTransition(
              child: const HomeScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
        }
      },
    );
  }
}

/*
To enable/disable Mac/Windows/Linux app
- Use: flutter config --enable-linux-desktop
- Use: flutter config --no-enable-linux-desktop
*/