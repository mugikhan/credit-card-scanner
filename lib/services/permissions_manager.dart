import 'package:permission_handler/permission_handler.dart';

class PermissionsManager {
  //Singleton access acroos the app
  static final PermissionsManager _instance = PermissionsManager._internal();

  factory PermissionsManager() {
    return _instance;
  }

  PermissionsManager._internal();

  Future<bool> isCameraPermissionGranted() async {
    if (await Permission.camera.request().isGranted) {
      return true;
    } else if (await Permission.camera.isDenied ||
        await Permission.camera.request().isPermanentlyDenied) {
      return false;
    }
    return false;
  }
}
