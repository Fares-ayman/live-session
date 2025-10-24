import 'package:get/get.dart';

import '../../../core/values/localization/route_parameters.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  void navigateToLiveSession() {
    Get.toNamed(Routes.LIVE_SESSION, arguments: {
      RouteParameters.sessionName: 'Live Session',
      RouteParameters.sessionLink:
          'https://ai-interviewer.xbites.io/ar/apply/541bfb2a-1f47-46b2-921d-9e6d54bea926',
    });
  }
}
