import 'package:live_session_app/app/core/values/localization/get_builder_ids.dart';
import 'package:live_session_app/app/core/values/localization/test_keys.dart';
import 'package:live_session_app/app/core/widgets/app_loading_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live_session_app/app/core/widgets/app_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_values.dart';
import '../controllers/live_session_controller.dart';

class LiveSessionView extends GetView<LiveSessionController> {
  const LiveSessionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (_, __) => controller.onExitFullScreen(),
      child: GetBuilder<LiveSessionController>(
        id: GetBuilderIDs.webViewFullScreen,
        builder: (_) {
          final Widget content = Stack(
            children: [
              controller.isFullScreen
                  ? WebViewWidget(
                      controller: controller.controller,
                      gestureRecognizers: <Factory<
                          OneSequenceGestureRecognizer>>{
                        Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                        ),
                      },
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                      child: WebViewWidget(
                        controller: controller.controller,
                        gestureRecognizers: <Factory<
                            OneSequenceGestureRecognizer>>{
                          Factory<OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer(),
                          ),
                        },
                      ),
                    ),
              // Loading overlay
              GetBuilder<LiveSessionController>(
                id: GetBuilderIDs.liveSessionLoading,
                builder: (_) {
                  if (!controller.isLoading) return const SizedBox.shrink();
                  return const AppLoadingWidget();
                },
              ),
              // Fullscreen toggle button
              GetBuilder<LiveSessionController>(
                id: GetBuilderIDs.webViewFullScreen,
                builder: (_) {
                  if (controller.isLoading) return const SizedBox.shrink();
                  return PositionedDirectional(
                    top: 0,
                    end: 0,
                    child: IconButton(
                      onPressed: controller.toggleFullScreen,
                      icon: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p4.w,
                            vertical: AppPadding.p8.h),
                        child: Container(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          decoration: const BoxDecoration(
                            color: AppColors.focusBorderColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            controller.isFullScreen
                                ? Icons.fullscreen_exit
                                : Icons.fullscreen,
                            color: Colors.white,
                            size: 20.spMin,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );

          if (controller.isFullScreen) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: SafeArea(
                top: false,
                bottom: false,
                child: content,
              ),
            );
          }

          return Scaffold(
            key: const Key(TestKeys.liveSessionView),
            appBar: AppBar(
              title: AppText(
                key: const Key(TestKeys.liveSessionView),
                text: controller.sessionName,
              ),
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back,
                    color: AppColors.titleBlackColor),
              ),
            ),
            body: SizedBox(
              height: Get.height,
              width: Get.width,
              child: content,
            ),
          );
        },
      ),
    );
  }
}
