import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';

class CustomTextFormFieldMax extends StatelessWidget {
  const CustomTextFormFieldMax({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          TextFormField(
            cursorColor: AppColors.cFF8E21,
            cursorRadius: Radius.circular(8.r),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(
                  color: AppColors.cFF8E21,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(
                  color: AppColors.cFF8E21,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(
                  color: AppColors.cFF8E21,
                ),
              ),
              fillColor: AppColors.cFFF4E9,
              filled: true,
              contentPadding: EdgeInsets.all(16.w), // Add some padding inside
            ),
            minLines: 5,
            maxLines: 5,
          ),
          Positioned(
            top: 90.h,
            right: 12.w,
            child: Image.asset(
              Assets.images.suffixImage.path,
              width: 20.w,
              height: 20.h,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
