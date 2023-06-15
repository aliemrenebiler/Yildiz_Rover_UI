import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import 'database/methods.dart';
import 'database/variables.dart';
import 'screens/homesreen.dart';
import 'screens/datascreen.dart';
import 'screens/camerascreen.dart';
import 'screens/archivescreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  rosUrl = await findNetworkIp();
  print(rosUrl);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      title: 'Yildiz Rover UI',
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
To run the code
- Use: flutter run --no-sound-null-safety

No need if you do this on VS Code
- Go to File > Preferences > Settings
- Search 'Dart: Flutter Run Additional Args' and click 'Add Item'
- Add '--no-sound-null-safety'

To enable Mac/Windows/Linux app
- Use: flutter config --enable-linux-desktop
*/