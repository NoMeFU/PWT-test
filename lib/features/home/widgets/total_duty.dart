import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';

class TotalDuty extends StatelessWidget {
  const TotalDuty({
    super.key,
    required this.date,
  });
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: 14.w, top: 11.h, bottom: 11.h, right: 54.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r), color: AppColors.cFFF4E9),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.icons.checkIconLawbug,
          ),
          UIHelper.horizontalSpace(6.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Duty',
                style: TextFontStyle.headline20c212B36stylepoppinsW500.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.c454F5B,
                  height: 1.5.h,
                ),
              ),
              Text(
                date,
                style: TextFontStyle.headline32c212B36stylepoppinsW700.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.c212B36,
                    height: 1.55.h),
              ),
            ],
          )
        ],
      ),
    );
  }
}
