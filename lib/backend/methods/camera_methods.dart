getCameraIDs(String cameras) {
  List<int> cameraIDs = [];
  int end = cameras.length - 1;
  if (cameras[0] == "[" && cameras[end] == "]") {
    List<String> temp = cameras.substring(1, end).split(",");
    for (int i = 0; i < temp.length; i++) {
      cameraIDs.add(int.parse(temp[i]));
    }
  }
  return cameraIDs;
}
