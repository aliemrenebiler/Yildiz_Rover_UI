import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

import '../backend/models.dart';
import 'generalwidgets.dart';
import '../backend/theme.dart';
import '../backend/variables.dart';
import '../backend/methods.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

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
                padding: const EdgeInsets.all(15),
                child: StreamBuilder<Object>(
                  stream: webCameraStream,
                  builder: (context, snapshot) {
                    int cameraCount;
                    List<int> allCameras = [];
                    if (snapshot.hasData) {
                      WebCamera newData = snapshot.data as WebCamera;
                      cameraCount = newData.id;
                      allCameras = getCameraIDs(newData.cameras);
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

/*
// SAMPLE BOXES
class ChooseCameraBox extends StatelessWidget {
  final int cameraID;
  final Function() notifyParent;
  const ChooseCameraBox({
    Key? key,
    required this.cameraID,
    required this.notifyParent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(roverDarkRed),
        borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            height: 40,
            child: Text(
              "CAMERA #${cameraID + 1}",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: roverFontL,
              ),
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < 8; i++)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: CameraLayoutButton(
                      layoutID: i,
                      cameraID: cameraID,
                      notifyParent: notifyParent,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class CameraLayoutButton extends StatelessWidget {
  final int layoutID;
  final int cameraID;
  final Function() notifyParent;
  const CameraLayoutButton({
    Key? key,
    required this.layoutID,
    required this.cameraID,
    required this.notifyParent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String buttonText;
    buttonText = layoutID.toString();

    return InkWell(
      onTap: () {
        if (cameraIDs[cameraID] != layoutID) {
          cameraIDs[cameraID] = layoutID;
          cameraUrls[cameraID] =
              'http://$connectedIP:8080/stream?topic=/camera$layoutID/image_raw';
          notifyParent();
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
          color: cameraIDs[cameraID] != layoutID
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
            fontWeight: FontWeight.bold,
            fontSize: roverFontM,
          ),
        ),
      ),
    );
  }
}
*/