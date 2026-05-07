import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/gen/colors.gen.dart';

class TextFieldWithTitle extends StatefulWidget {
  final String titleText;
  final String hintText;
  final String prefixIcon;
  final FocusNode focusNode;

  const TextFieldWithTitle({
    super.key,
    required this.titleText,
    required this.hintText,
    required this.prefixIcon,
    required this.focusNode,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TextFieldWithTitleState createState() => _TextFieldWithTitleState();
}

class _TextFieldWithTitleState extends State<TextFieldWithTitle> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() {
        _isFocused = widget.focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.cA3A3A3,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
          child: SvgPicture.asset(widget.prefixIcon),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.cE8E8E8,
            width: 1.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.cE69F6C,
          ),
        ),
        fillColor: _isFocused ? AppColors.cFFF1E7 : Colors.white,
        filled: true,
      ),
    );
  }
}
