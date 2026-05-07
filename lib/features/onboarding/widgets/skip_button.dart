import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
class SkipButton extends StatelessWidget {
  const SkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationService.navigateTo(Routes.loginScreen);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 6.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColors.cFFF4E9),
        child: Text(
          'Skip',
          style: TextFontStyle.headline16c919EABstylepoppinsW400.copyWith(
            color: AppColors.cFF8E21
          ),
        ),
      ),
    );
  }
}