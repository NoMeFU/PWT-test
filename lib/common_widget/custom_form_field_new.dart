import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';

// ignore: must_be_immutable
final class CustomFormFieldNew extends StatelessWidget {
  String? hintText;
  final String? labelText;
  TextEditingController? textEditingController;
  final TextInputType inputType;
  double? fieldHeight;
  int? maxline;
  final String? Function(String?)? validator;
  bool? validation;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  bool isObsecure;
  bool isPass;
  FocusNode? focusNode;
  TextInputAction? textInputAction;
  Function(String)? onFieldSubmitted;
  Function(String)? onChanged;
  List<TextInputFormatter>? inputFormatters;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final bool? isEnabled;
  final double? cursorHeight;
  final Color? disableColor;
  final double? maxHeight;
  final double? prefixPadding;
  final Color? defaultBorderColor;
  final EdgeInsetsGeometry? contentPadding;

  CustomFormFieldNew(
      {super.key,
      this.hintText,
      this.labelText,
      this.textEditingController,
      required this.inputType,
      this.fieldHeight,
      this.maxline,
      this.validator,
      this.validation = false,
      this.suffixIcon,
      this.prefixIcon,
      this.isObsecure = false,
      this.isPass = false,
      this.focusNode,
      this.textInputAction = TextInputAction.next,
      this.onFieldSubmitted,
      this.onChanged,
      this.inputFormatters,
      this.labelStyle,
      this.isEnabled,
      this.style,
      this.contentPadding,
      this.cursorHeight,
      this.disableColor,
      this.maxHeight,
      this.prefixPadding,
      this.defaultBorderColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: maxHeight,
      child: TextFormField(
        cursorHeight: cursorHeight ?? 20.h,
        cursorColor: AppColors.c000000,
        focusNode: focusNode,
        obscureText: isPass ? isObsecure : false,
        textInputAction: textInputAction,
        autovalidateMode:
            validation! ? AutovalidateMode.always : AutovalidateMode.disabled,
        validator: validator,
        maxLines: maxline ?? 1,
        controller: textEditingController,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        enabled: isEnabled,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          prefixIconConstraints: BoxConstraints(
            maxWidth: 40.w,
            maxHeight: 40.w,
            minHeight: 40.w,
            minWidth: 40.w,
          ),
          fillColor: Colors.transparent,
          filled: true,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(4.0.r)),
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          hintText: hintText,
          hintStyle: TextFontStyle.text14c011510OutfitRegular
              .copyWith(color: AppColors.c006850, fontSize: 13.sp),
          labelText: labelText,
          labelStyle: labelStyle ??
              TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.c000000,
              ),
          errorStyle: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            color: Colors.red,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0.r),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0.r),
            borderSide: BorderSide(
              // ignore: deprecated_member_use
              color: AppColors.c006850.withOpacity(0.32),
              width: 1.5,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0.r),
            borderSide: BorderSide(
              // ignore: deprecated_member_use
              color: disableColor ?? AppColors.c006850.withOpacity(0.32),
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0.r),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0.r),
            borderSide: BorderSide(
              color: defaultBorderColor ?? Colors.transparent,
              width: 1,
            ),
          ),
        ),
        style: style ??
            TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.c000000,
            ),
        keyboardType: inputType,
      ),
    );
  }
}
