import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
// ignore: must_be_immutable
class PlanOffer extends StatelessWidget {
  String plans;
   PlanOffer({
    super.key, required this.plans
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          Assets.icons.checkCircleLawbug,
        ),
        UIHelper.horizontalSpace(8.w),
        Text(
          plans,
          style: TextFontStyle
              .headline12c637381stylepoppinsW400,
        ),
      ],
    );
  }
}
