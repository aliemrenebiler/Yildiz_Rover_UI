import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:roslib/roslib.dart';

import '../database/theme.dart';
import '../database/methods.dart';
import '../database/variables.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          primary: false,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: AspectRatio(
                      aspectRatio: 2.3,
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/yildizrover_logo.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                    child: Column(
                      children: [
                        Text(
                          'User Interface',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: roverFontL,
                          ),
                        ),
                        Text(
                          '(Version 1.0)',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(roverGrey),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: roverFontM,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const ConnectButton(),
                  const StartButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ConnectButton extends StatelessWidget {
  const ConnectButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: StreamBuilder<Object>(
        stream: ros.statusStream,
        builder: (contextRos, snapshotRos) {
          return InkWell(
            onTap: () async {
              print(snapshotRos.data);
              if (snapshotRos.data == Status.CONNECTED) {
                ros.close();
                // print('DISCONNECTED');
              } else {
                ros.connect();
                // print('CONNECTED: $rosUrl');
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              decoration: BoxDecoration(
                color: snapshotRos.data == Status.CONNECTED
                    ? Color(roverDarkCoral)
                    : Color(roverDarkRed),
                borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
              ),
              child: Text(
                snapshotRos.data == Status.CONNECTED ? 'DISCONNECT' : 'CONNECT',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: roverFontM,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: StreamBuilder<Object>(
        stream: ros.statusStream,
        builder: (contextRos, snapshotRos) {
          return InkWell(
            onTap: () {
              if (snapshotRos.data == Status.CONNECTED) {
                currentScreenIndex = 0;
                subscribeDataPage();
                Navigator.pushNamed(context, '/datascreen');
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              decoration: BoxDecoration(
                color: snapshotRos.data == Status.CONNECTED
                    ? Color(roverCoral)
                    : Color(roverGrey),
                borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
              ),
              child: Text(
                'START',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: roverFontM,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
