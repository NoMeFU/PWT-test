// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';

class PlansCondition extends StatelessWidget {
  String text;
  PlansCondition({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          Assets.icons.fireOrangeLawbug,
        ),
        UIHelper.horizontalSpace(6.w),
        Expanded(
          child: Text(
            text,
            style: TextFontStyle.headline16c212B36stylepoppinsW600
                .copyWith(fontSize: 11.sp),
          ),
        ),
      ],
    );
  }
}
