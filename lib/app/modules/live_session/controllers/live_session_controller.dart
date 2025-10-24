import 'dart:developer';

import 'package:live_session_app/app/core/utliz/custom_snackbar.dart';
import 'package:live_session_app/app/core/utliz/microphone_permission_util.dart';
import 'package:live_session_app/app/core/values/localization/get_builder_ids.dart';
import 'package:live_session_app/app/core/values/localization/route_parameters.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

import '../../../core/utliz/camera_permission_util.dart';

class LiveSessionController extends GetxController {
  WebViewController controller = WebViewController();
  final String sessionName = Get.arguments[RouteParameters.sessionName] ?? "";
  final String sessionLink = Get.arguments[RouteParameters.sessionLink] ?? "";
  bool isLoading = true;
  bool isFullScreen = false;
  @override
  void onInit() {
    super.onInit();
    initWebview();
  }

  Future<bool> checkPermissions() async {
    final bool granted =
        await MicrophonePermissionUtil.ensureMicrophonePermission();
    final bool cameraGranted =
        await CameraPermissionUtil.ensureCameraPermission();
    if (!granted || !cameraGranted) {
      showCustomSnackBar(
        title: "Microphone permission required",
      );
    }
    return granted && cameraGranted;
  }

  void initWebview() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress >= 100) {
              if (isLoading) {
                isLoading = false;
                update([
                  GetBuilderIDs.liveSessionLoading,
                  GetBuilderIDs.webViewFullScreen
                ]);
              }
              return;
            }
            if (!isLoading) {
              isLoading = true;
              update([
                GetBuilderIDs.liveSessionLoading,
                GetBuilderIDs.webViewFullScreen
              ]);
            }
          },
          onPageStarted: (String url) {
            isLoading = true;
            update([
              GetBuilderIDs.liveSessionLoading,
              GetBuilderIDs.webViewFullScreen
            ]);
          },
          onPageFinished: (String url) {
            isLoading = false;
            update([
              GetBuilderIDs.liveSessionLoading,
              GetBuilderIDs.webViewFullScreen
            ]);

            controller.runJavaScript("""
      document.documentElement.setAttribute('dir','ltr');
      document.documentElement.style.direction='ltr';
    """);
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            log(request.url);
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(sessionLink));
    handleRuntimeMicrophonePermission();
  }

  void handleRuntimeMicrophonePermission() {
    if (controller.platform is AndroidWebViewController) {
      final AndroidWebViewController androidController =
          controller.platform as AndroidWebViewController;
      androidController.setOnPlatformPermissionRequest(
        (request) async {
          final bool granted = await checkPermissions();

          if (!granted) {
            request.deny();
            return;
          }
          request.grant();
        },
      );
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toggleFullScreen() async {
    isFullScreen = !isFullScreen;
    if (isFullScreen) {
      await onEnterFullScreen();
    } else {
      await onExitFullScreen();
    }
    update([GetBuilderIDs.webViewFullScreen]);
  }

  Future<void> onEnterFullScreen() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future<void> onExitFullScreen() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ],
    );
  }
}
