import 'package:get/get.dart';

import '../controllers/live_session_controller.dart';

class LiveSessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveSessionController>(
      () => LiveSessionController(),
    );
  }
}
