import 'package:flutter/material.dart';

import '../backend/methods/general_methods.dart';
import '../backend/theme.dart';

class TopNavBar extends StatelessWidget {
  const TopNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(roverDarkRed),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(5),
                height: 45,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.centerLeft,
                    image: AssetImage('assets/yildizrover_ytu_logo.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(5),
              child: const BatteryBox(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(5),
              child:
                  const TopNavBarButton(text: 'DATA', nextRoute: '/datascreen'),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(5),
              child: const TopNavBarButton(
                  text: 'CAMERA', nextRoute: '/camerascreen'),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(5),
              child: const TopNavBarButton(
                  text: 'ARCHIVE', nextRoute: '/archivescreen'),
            ),
          ),
        ],
      ),
    );
  }
}

class BatteryBox extends StatelessWidget {
  const BatteryBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
      ),
      child: StreamBuilder(
        stream: batteryStream,
        builder: (context, snapshot) {
          String batteryText;
          int batteryPrecent;
          String batteryCurrent;
          String batteryVoltage;
          if (snapshot.hasData) {
            Map<String, dynamic> newData =
                snapshot.data! as Map<String, dynamic>;
            batteryPrecent = int.parse(newData['precent']);
            batteryCurrent = newData['current'].toStringAsFixed(1);
            batteryVoltage = newData['voltage'].toStringAsFixed(1);
            if (batteryPrecent > 100) {
              batteryPrecent = 100;
            } else if (batteryPrecent < 0) {
              batteryPrecent = 0;
            }
            batteryText = '%$batteryPrecent';
          } else {
            batteryPrecent = 50;
            batteryText = '--';
            batteryCurrent = '--';
            batteryVoltage = '--';
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(3),
                  child: Text(
                    batteryText,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: 28,
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Color(roverLightGrey),
                    borderRadius:
                        BorderRadius.all(Radius.circular(roverRadiusM)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Container(
                            height: 28,
                            width:
                                constraints.maxWidth * (batteryPrecent / 100),
                            decoration: BoxDecoration(
                              color: (batteryPrecent <= 10)
                                  ? roverGraphRed
                                  : (batteryPrecent <= 50)
                                      ? roverGraphYellow
                                      : roverGraphGreen,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(roverRadiusM)),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(3),
                  child: Text(
                    "C: $batteryCurrent",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(3),
                  child: Text(
                    "V: $batteryVoltage",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class TopNavBarButton extends StatelessWidget {
  final String text;
  final String nextRoute;
  const TopNavBarButton({
    Key? key,
    required this.text,
    required this.nextRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isCurrentRoute;
    if (ModalRoute.of(context)!.settings.name == nextRoute) {
      isCurrentRoute = true;
    } else {
      isCurrentRoute = false;
    }
    return InkWell(
      onTap: () {
        if (!isCurrentRoute) {
          Navigator.pushReplacementNamed(context, nextRoute);
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
          color: isCurrentRoute ? Color(roverDarkCoral) : Color(roverCoral),
          borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: roverFontM,
          ),
        ),
      ),
    );
  }
}
