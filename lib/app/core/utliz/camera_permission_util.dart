import 'package:permission_handler/permission_handler.dart';

class CameraPermissionUtil {
  static Future<bool> ensureCameraPermission() async {
    final PermissionStatus currentStatus = await Permission.camera.status;

    if (currentStatus.isGranted) {
      return true;
    }

    final PermissionStatus requestedStatus = await Permission.camera.request();

    if (requestedStatus.isGranted) {
      return true;
    }

    if (requestedStatus.isDenied || requestedStatus.isPermanentlyDenied) {
      await openAppSettings();
    }

    return false;
  }
}
