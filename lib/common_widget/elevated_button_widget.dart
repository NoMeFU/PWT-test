import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/colors.gen.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String buttonText; // The text for the button
  final Function
      onPressedAction; // Action to perform when the button is pressed

  const ElevatedButtonWidget({
    super.key,
    required this.buttonText,
    required this.onPressedAction,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressedAction(),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: AppColors.cE69F6C, // Use your custom color
        minimumSize:
            const Size(double.infinity, 48), // Full width and fixed height
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        child: Text(
          buttonText,
          style: TextFontStyle.headline16c2F2F2FFstyleRobotoW500
              .copyWith(fontSize: 16.sp, color: AppColors.cFFFFFF),
        ),
      ),
    );
  }
}
