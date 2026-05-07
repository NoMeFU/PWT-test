import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import '../../../../gen/colors.gen.dart';

Widget customeButton({
  required String name,
  required VoidCallback onCallBack,
   double? height,
   double? minWidth,
   double? borderRadius,
   Color? color,
   TextStyle? textStyle,
  required BuildContext context,
  Color? borderColor,
  Color? textColor,
  Widget? icon,
}) {
  return MaterialButton(
    onPressed: onCallBack,
    height: height??56.h,
    elevation: 0,
    minWidth: minWidth?? double.infinity,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: borderColor ?? AppColors.cFF8E21, width: 0.9.sp),
      borderRadius: BorderRadius.circular(borderRadius?? 8.r),
    ),
    color: color?? AppColors.cFF8E21,
    // ignore: deprecated_member_use
    splashColor: Colors.white.withOpacity(0.4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon ?? const SizedBox(),
        icon != null
            ? UIHelper.horizontalSpace(16.w)
            : UIHelper.horizontalSpace(0),
        Text(
          name,
          style:  TextStyle(
            fontFamily: 'poppins',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: textColor?? AppColors.cFFFFFF
          ),
        ),
      ],
    ),
  );
}
