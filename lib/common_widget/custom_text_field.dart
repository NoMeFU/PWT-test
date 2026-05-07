import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/colors.gen.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool isPassword;
  final String? suffixIcon;
  final String? prefixIcon;
  final TextInputType keyboardType;
  final bool readOnly; 
  final VoidCallback? onTap;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.readOnly = false, 
    this.onTap,
    this.prefixIcon
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      cursorColor: AppColors.c000000,
      cursorRadius: Radius.circular(8.r),
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
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
        hintText: widget.hintText,
        hintStyle: TextFontStyle.headline16c919EABstylepoppinsW400.copyWith(
          fontSize: 14.sp,
          color: AppColors.cCDCDCD,
        ),
        suffixIcon: widget.isPassword
    ? IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: AppColors.cCDCDCD,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      )
    : (widget.suffixIcon != null
        ? Padding(
            padding: EdgeInsets.all(12.r),
            child: SvgPicture.asset(
              widget.suffixIcon!,
              height: 24.h,
              width: 24.w,
            ),
          )
        : null),
        prefixIcon: widget.prefixIcon != null
    ? Padding(
        padding: EdgeInsets.all(12.r),
        child: SvgPicture.asset(
          widget.prefixIcon!,
          height: 24.h,
          width: 24.w,
        ),
      )
    : null,
      ),
      validator: widget.validator,
      readOnly: widget.readOnly, 
      onTap: widget.onTap, 
    );
  }
}
