import 'package:flutter/material.dart';

import '../database/methods.dart';
import '../database/theme.dart';
import '../database/variables.dart';

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
            child: InkWell(
              onTap: () {
                unsubscribeFromAll();
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
          const BatteryBox(),
          const TopNavBarButton(text: 'DATA', screenIndex: 0),
          const TopNavBarButton(text: 'CAMERA', screenIndex: 1),
          const TopNavBarButton(text: 'ARCHIVE', screenIndex: 2),
        ],
      ),
    );
  }
}

class BatteryBox extends StatelessWidget {
  const BatteryBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String batteryText;
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(3),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
      ),
      child: StreamBuilder(
        stream: battery.subscription,
        builder: (contextBatteryBox, snapshotBatteryBox) {
          int batteryPrecent;
          if (snapshotBatteryBox.hasData) {
            var subData = snapshotBatteryBox.data! as Map;
            batteryPrecent = subData['msg']['precent'];
            if (batteryPrecent > 100) {
              batteryPrecent = 100;
            } else if (batteryPrecent < 0) {
              batteryPrecent = 0;
            }
            batteryText = '%$batteryPrecent';
          } else {
            batteryPrecent = 5;
            batteryText = '---';
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(3),
                width: MediaQuery.of(context).size.width / 25,
                child: Text(
                  batteryText,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                height: 28,
                width: MediaQuery.of(context).size.width / 6 -
                    MediaQuery.of(context).size.width / 25,
                margin: const EdgeInsets.all(3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 28,
                      width: (MediaQuery.of(context).size.width / 6 -
                              MediaQuery.of(context).size.width / 25) /
                          100 *
                          batteryPrecent,
                      decoration: BoxDecoration(
                        color: (batteryPrecent <= 10)
                            ? roverGraphRed
                            : (batteryPrecent <= 50)
                                ? roverGraphYellow
                                : roverGraphGreen,
                        borderRadius:
                            BorderRadius.all(Radius.circular(roverRadiusM)),
                      ),
                    ),
                  ],
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
  final int screenIndex;
  const TopNavBarButton({
    Key? key,
    required this.text,
    required this.screenIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String nextRoute;
    Function() subFunction;
    switch (screenIndex) {
      case 0:
        subFunction = subscribeDataPage;
        nextRoute = '/datascreen';
        break;
      case 1:
        subFunction = subscribeCameraPage;
        nextRoute = '/camerascreen';
        break;
      case 2:
        subFunction = unsubscribeFromAll;
        nextRoute = '/archivescreen';
        break;
      default:
        subFunction = unsubscribeFromAll;
        nextRoute = '/homescreen';
    }
    return Container(
      margin: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          if (screenIndex != currentScreenIndex) {
            currentScreenIndex = screenIndex;
            subFunction();
            Navigator.pushReplacementNamed(context, nextRoute);
          }
        },
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: MediaQuery.of(context).size.width / 8,
          decoration: BoxDecoration(
            color: screenIndex != currentScreenIndex
                ? Color(roverCoral)
                : Color(roverDarkCoral),
            borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
          ),
          child: Text(
            text,
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
      ),
    );
  }
}
