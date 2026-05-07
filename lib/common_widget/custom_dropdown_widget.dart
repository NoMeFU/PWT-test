import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_constants.dart';
import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';

class MyCustomDropdown extends StatefulWidget {
  final String selectedValue;
  final List<String> dropDownValue;
  final Function(String?)? onTap;
  final double horizonPadding;
  final double verticPadding;

  const MyCustomDropdown({
    super.key,
    required this.selectedValue,
    required this.dropDownValue,
    this.horizonPadding = 16,
    this.verticPadding = 0,
    this.onTap,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyCustomDropdownState createState() => _MyCustomDropdownState();
}

class _MyCustomDropdownState extends State<MyCustomDropdown> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: widget.horizonPadding.w,
            vertical: widget.verticPadding),
        decoration: BoxDecoration(
            // border: Border.all(color: AppColors.cDFE1E6, width: 1.w),
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            border: Border.all(color: AppColors.cFFFFFF)
            // color: AppColors.cFFFFFF
            ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: _selectedValue,
            style: TextFontStyle.text16c637381StyleSoraW400,

            icon: Icon(Icons.keyboard_arrow_down,
                size: 22.sp, color: AppColors.cFFFFFF),
            // menuWidth: 130.w,
            menuMaxHeight: 400.h,
            items: widget.dropDownValue
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  languages[value],
                  style: TextFontStyle.text14c637381StyleSora
                      .copyWith(fontSize: 12.sp, color: AppColors.cFFFFFF),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedValue = newValue!;
              });
              if (widget.onTap != null) {
                widget.onTap!(newValue);
              }
            },
            dropdownColor: AppColors.cFFFFFF,
            borderRadius: BorderRadius.circular(16.r),
            alignment: Alignment.centerRight,
          ),
        ));
  }
}
