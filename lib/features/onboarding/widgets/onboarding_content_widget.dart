import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';


class OnboardingContentWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final double imageWidth;

  const OnboardingContentWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: imageWidth,
          //fit: BoxFit.cover,
        ),
        UIHelper.verticalSpace(46.h),
        Text(title, style: TextFontStyle.headline32c212B36stylepoppinsW700),
        UIHelper.verticalSpace(10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Text(
            textAlign: TextAlign.center,
            subtitle,
            style: TextFontStyle.headline16c919EABstylepoppinsW400
                .copyWith(height: 1.5.h),
          ),
        ),
      ],
    );
  }
}
