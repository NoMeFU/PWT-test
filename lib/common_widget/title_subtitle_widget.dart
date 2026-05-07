import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';

class TitleSubtitleWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const TitleSubtitleWidget(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Roboto',
            color: Color(0xFF2F2F2F), // AppColors.c2F2F2F
            fontSize: 24,
            fontWeight: FontWeight.w500,
            height: 1.24,
          ),
          textAlign: TextAlign.center,
        ),
        UIHelper.verticalSpace(8.h),
        // Adds space between title and subtitle
        Text(
          subtitle,
          style: const TextStyle(
            fontFamily: 'Roboto',
            color: Color(0xFF5E5E5E), // AppColors.c5E5E5E
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.64,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
