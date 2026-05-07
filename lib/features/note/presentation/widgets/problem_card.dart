import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
class ProblemCard extends StatelessWidget {
  const ProblemCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.cFFF4E9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIHelper.verticalSpace(16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.icons.calenderLawbug,
                ),
                UIHelper.horizontalSpace(8.w),
                Text(
                  '12/04/2025',
                  style: TextFontStyle
                      .headline12c637381stylepoppinsW400,
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.c22BB33,
                  ),
                  child: Text(
                    'Solved',
                    style: TextFontStyle
                        .headline12c637381stylepoppinsW400
                        .copyWith(
                      color: AppColors.cFFFFFF,
                      height: 1.5.h,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          UIHelper.verticalSpace(16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.icons.locationOrangeLawbug,
                ),
                UIHelper.horizontalSpace(8.w),
                Text(
                  'Dhaka, Bangladesh',
                  style: TextFontStyle
                      .headline14c212B36stylepoppinsW400
                      .copyWith(height: 1.57.h),
                ),
              ],
            ),
          ),
          UIHelper.verticalSpace(14.h),
          UIHelper.customDivider(color: AppColors.cFFDCBA),
          UIHelper.verticalSpace(14.h),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur eiusmod adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur eiusmod adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              style: TextFontStyle.headline14c919EABstylepoppinsW400,
            ),
          ),
          UIHelper.verticalSpace(24.h)
        ],
      ),
    );
  
  
  }
}