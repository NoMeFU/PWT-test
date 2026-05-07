import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/gen/assets.gen.dart';
class CarouselIconWidget extends StatelessWidget {
  const CarouselIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Assets.icons.onboardingIcon,
      width: 48.w,
      height: 48.h,
    );
  }
}