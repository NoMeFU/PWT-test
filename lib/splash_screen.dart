import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/assets_healper/app_color.dart';
import 'package:lawbug829/assets_healper/app_image.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColors,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Appimages.appLogo,
              width: 186.w,
              height: 125.h,
            ),
          ],
        ),
      ),
    );
  }
}
