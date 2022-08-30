import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

import '../backend/methods/general_methods.dart';
import 'generalwidgets.dart';
import '../backend/theme.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
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
                  padding: const EdgeInsets.all(15),
                  child: StreamBuilder<Object>(
                    stream: webCameraStream,
                    builder: (context, snapshot) {
                      int cameraCount;
                      List<dynamic> allCameras = [];
                      if (snapshot.hasData) {
                        Map<String, dynamic> newData =
                            snapshot.data as Map<String, dynamic>;
                        cameraCount = newData['id'];
                        allCameras = newData['cameras'];
                      } else {
                        cameraCount = 0;
                      }

                      if (cameraCount == 0) {
                        return Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 115,
                          child: Text(
                            "No Avaliabe Camera",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(roverGrey),
                              fontWeight: FontWeight.bold,
                              fontSize: roverFontM,
                            ),
                          ),
                        );
                      } else {
                        return GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          childAspectRatio: 16 / 9,
                          children: List.generate(
                            cameraCount,
                            (index) {
                              return Container(
                                padding: const EdgeInsets.all(5),
                                child: CameraBox(
                                  name: 'Camera #$index',
                                  camID: allCameras[index],
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Get image as Uint8List
class CameraBox extends StatelessWidget {
  final String name;
  final int camID;
  const CameraBox({
    Key? key,
    required this.name,
    required this.camID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          color: Color(roverLightGrey),
        ),
        child: WebViewX(
          ignoreAllGestures: true,
          key: const ValueKey('webviewx'),
          initialContent:
              'http://$connectedIP:8080/stream?topic=/camera$camID/image_raw',
          initialSourceType: SourceType.url,
          height: (MediaQuery.of(context).size.width / 2 - 25) / 0.5625,
          width: MediaQuery.of(context).size.width / 2 - 25,
        ),
      ),
    );
  }
}
