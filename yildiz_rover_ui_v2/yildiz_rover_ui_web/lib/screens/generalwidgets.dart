import 'package:flutter/material.dart';

import '../backend/variables.dart';
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
          const BatteryBox(),
          const TopNavBarButton(text: 'DATA', nextRoute: '/datascreen'),
          const TopNavBarButton(text: 'CAMERA', nextRoute: '/camerascreen'),
          const TopNavBarButton(text: 'ARCHIVE', nextRoute: '/archivescreen'),
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
      margin: const EdgeInsets.all(5),
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
          if (snapshot.hasData) {
            Map<String, dynamic> newData =
                snapshot.data! as Map<String, dynamic>;
            batteryPrecent = newData['precent'];
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
    return Container(
      margin: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          if (!isCurrentRoute) {
            Navigator.pushReplacementNamed(context, nextRoute);
          }
        },
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: MediaQuery.of(context).size.width / 8,
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
      ),
    );
  }
}
