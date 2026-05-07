import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/colors.gen.dart';

class CustomDropdownField extends StatelessWidget {
  final String? value;
  final Function(String?) onChanged;
  final String? hintText;
  final String? suffixIcon;
  final String? prefixIcon;
  final String? Function(String?)? validator;
  final List<String> items;

  const CustomDropdownField({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      validator: validator,
      icon:  const SizedBox.shrink(),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextFontStyle.headline16c919EABstylepoppinsW400.copyWith(
          fontSize: 14.sp,
          color: AppColors.cCDCDCD,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.cFFDCBA),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.cFFB36A),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.cFFB36A),
        ),
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: EdgeInsets.all(12.r),
                child: SvgPicture.asset(
                  suffixIcon!,
                  height: 24.h,
                  width: 24.w,
                ),
              )
            : null,
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: EdgeInsets.all(12.r),
                child: SvgPicture.asset(
                  prefixIcon!,
                  height: 24.h,
                  width: 24.w,
                ),
              )
            : null,
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }
}
