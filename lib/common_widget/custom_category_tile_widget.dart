import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import '../gen/colors.gen.dart';

class CustomCategoryTileWidget extends StatelessWidget {
  final String title;
  const CustomCategoryTileWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: 56.h,
          width: double.infinity,
          decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: AppColors.primaryColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(8.r)),
          margin: EdgeInsets.symmetric(vertical: 8.h),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.w),
          child: Row(
            children: [
              Expanded(
                child: Text(title,
                    style: TextFontStyle.text16c637381StyleSoraW400
                        .copyWith(color: AppColors.primaryColor)),
              ),
              // const Spacer(),
              SizedBox(
                  width: 26.w,
                  child: const Icon(Icons.keyboard_arrow_right_rounded))
            ],
          ),
        ),
      ],
    );
  }
}
