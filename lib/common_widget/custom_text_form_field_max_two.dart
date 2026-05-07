import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/gen/colors.gen.dart';

class CustomTextFormFieldMaxTwo extends StatelessWidget {
  const CustomTextFormFieldMaxTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return 
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
        contentPadding: EdgeInsets.all(16.w),
      ),
      minLines: 5,
      maxLines: 5,
    );
  }
}
