import 'package:live_session_app/app/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../values/app_colors.dart';
import '../values/app_text_style.dart';
import '../values/app_values.dart';

void showCustomSnackBar({
  required String title,
  bool isError = true,
}) {
  Get.snackbar(
    "",
    "",
    maxWidth: Get.width * 0.95,
    titleText: Padding(
      padding: const EdgeInsets.only(top: AppPadding.p16),
      child: AppText(
        key: Key(title),
        text: title,
        maxLines: 3,
        style: AppTextStyles.montserratArabicBold14.copyWith(
          color: AppColors.whiteText,
        ),
      ),
    ),
    margin: const EdgeInsets.only(
      bottom: AppMargin.m12,
    ),
    padding: const EdgeInsets.all(
      AppPadding.p8,
    ),
    backgroundColor: isError ? AppColors.errorRed : AppColors.greenTextColor,
    colorText: AppColors.whiteText,
    snackPosition: SnackPosition.BOTTOM,
    icon: Icon(
      isError ? Icons.error_outline_rounded : Icons.check,
      color: AppColors.whiteText,
      size: 32.spMin,
    ),
  );
}

