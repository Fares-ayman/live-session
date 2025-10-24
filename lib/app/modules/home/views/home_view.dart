import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_text_style.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widgets/app_text.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: InkWell(
        onTap: controller.navigateToLiveSession,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: const EdgeInsets.all(AppPadding.p16),
          child: AppText(
            key: Key('home_view'),
            text: 'Enter Live Session',
            style: AppTextStyles.montserratArabicBold16.copyWith(
              color: AppColors.whiteText,
            ),
          ),
        ),
      ),
    ));
  }
}
