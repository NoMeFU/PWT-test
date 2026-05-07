import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDropdown extends StatefulWidget {
  final String labelText;
  final String hintText;
  final bool showSuffixIcon;
  final String? suffixIcon;
  final VoidCallback onButtonPressed;
  final bool isDatePicker;
  final List<String> items; // List of values for the dropdown
  final String selectedValue; // Initially selected value

  const CustomDropdown({
    super.key,
    required this.labelText,
    required this.hintText,
    this.suffixIcon,
    this.showSuffixIcon = true,
    required this.onButtonPressed, // Callback
    required this.isDatePicker,
    required this.items, // List of values for the dropdown
    required this.selectedValue, // Initially selected value
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedValue; // Internal state for selected value
  bool _isDropdownVisible = false;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue; // Set the initial selected value
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: TextStyle(
            color: Colors.grey, // Adjust text color
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: () {
            setState(() {
              _isDropdownVisible = !_isDropdownVisible;
            });
            widget.onButtonPressed(); // Trigger the callback if provided
          },
          child: Container(
            padding: EdgeInsets.all(15.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: Colors.grey, width: 1.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _selectedValue ?? widget.hintText,
                    style: TextStyle(
                      color: Colors.black, // Text color for selected value
                      fontSize: 14.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (widget.showSuffixIcon && widget.suffixIcon != null)
                  SizedBox(
                    height: 24.h,
                    width: 24.w,
                    child: SvgPicture.asset(widget.suffixIcon!),
                  ),
              ],
            ),
          ),
        ),
        if (_isDropdownVisible)
          Container(
            padding: EdgeInsets.all(10.sp),
            margin: EdgeInsets.only(top: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: Colors.grey, width: 1.sp),
            ),
            child: Column(
              children: widget.items.map((item) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedValue = item;
                      _isDropdownVisible =
                          false; // Hide the dropdown when item is selected
                    });
                    widget
                        .onButtonPressed(); // Trigger the callback if provided
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.sp),
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
