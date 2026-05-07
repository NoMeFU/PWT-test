import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
class FeedbackCard extends StatelessWidget {
  const FeedbackCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.cFFDCBA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Admin Feedback',
            style: TextFontStyle.headline16c212B36stylepoppinsW600
                .copyWith(height: 1.2.h),
          ),
          UIHelper.verticalSpace(12.h),
          Text(
            'Lorem ipsum dolor sit amet, consectetur eiusmod adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetu',
            style: TextFontStyle.headline14c212B36stylepoppinsW400,
          ),
        ],
      ),
    );
  }
}