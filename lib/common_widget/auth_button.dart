// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget AuthCustomeButton({
  required String name,
  required VoidCallback onCallBack,
  required double height,
  required double minWidth,
  required double borderRadius,
  required Color color,
  required TextStyle textStyle,
  required BuildContext context,
  bool isLoading = false, // 🔹 নতুন parameter
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 10.w,
    ),
    child: MaterialButton(
      onPressed:
          isLoading ? null : onCallBack, // 🔸 লোডিং অবস্থায় disable থাকবে
      height: height,
      minWidth: minWidth,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      color: color,
      // ignore: deprecated_member_use
      splashColor: Colors.white.withOpacity(0.4),
      child: isLoading
          ? const SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            )
          : Text(
              name,
              style: textStyle,
            ),
    ),
  );
}
