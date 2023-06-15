import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:roslib/roslib.dart';

import 'generalwidgets.dart';
import '../database/theme.dart';
import '../database/variables.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TopNavBar(),
          Expanded(
            child: SingleChildScrollView(
              primary: false,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: (cameraLayoutIndex == 0)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: CameraBox(
                              name: 'Main Camera',
                              streamURL:
                                  'http://localhost:8080/stream?topic=/camera/image_raw',
                              topicName: camera,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    color: Color(roverLightGrey),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    color: Color(roverLightGrey),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    color: Color(roverLightGrey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                color: Color(roverLightGrey),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                color: Color(roverLightGrey),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: CameraLayoutButton(
                      layout: 0,
                      notifyParent: refresh,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: CameraLayoutButton(
                      layout: 1,
                      notifyParent: refresh,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CameraBox extends StatelessWidget {
  final String name;
  final String streamURL;
  final Topic topicName;
  const CameraBox({
    Key? key,
    required this.name,
    required this.streamURL,
    required this.topicName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      // BURAYA URL'DEN VIDEO OKUMA GELICEK <========================
      child: null,
    );
  }
}

class CameraLayoutButton extends StatelessWidget {
  final int layout;
  final Function() notifyParent;
  const CameraLayoutButton({
    Key? key,
    required this.layout,
    required this.notifyParent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String buttonText;
    switch (layout) {
      case 0:
        buttonText = '1x3 Camera Layout';
        break;
      case 1:
        buttonText = '2x0 Camera Layout';
        break;
      default:
        buttonText = '---';
    }
    return InkWell(
      onTap: () async {
        if (cameraLayoutIndex != layout) {
          cameraLayoutIndex = layout;
          notifyParent();
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
          color: cameraLayoutIndex != layout
              ? Color(roverCoral)
              : Color(roverDarkCoral),
          borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
        ),
        child: Text(
          buttonText,
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
  }
}

/*
StreamBuilder<dynamic>(
  stream: camera!.subscription,
  builder: (context, snapshotCam) {
    return Image(image: snapshotCam.data);
  },
),
*/