import 'package:permission_handler/permission_handler.dart';

class MicrophonePermissionUtil {
  static Future<bool> ensureMicrophonePermission() async {
    final PermissionStatus currentStatus = await Permission.microphone.status;

    if (currentStatus.isGranted) {
      return true;
    }

    final PermissionStatus requestedStatus =
        await Permission.microphone.request();

    if (requestedStatus.isGranted) {
      return true;
    }

    if (requestedStatus.isPermanentlyDenied) {
      openAppSettings();
    }

    return false;
  }
}
