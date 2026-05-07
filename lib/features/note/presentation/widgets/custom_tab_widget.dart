import 'package:flutter/material.dart';
import 'package:lawbug829/gen/colors.gen.dart';

class CustomTabWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final Color borderColor;
  final double? horizontalPadding;

  const CustomTabWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.selectedColor = AppColors.cFF8E21,
    this.unselectedColor = Colors.transparent,
    this.selectedTextColor = const Color(0xFFFFFFFF),
    this.unselectedTextColor = AppColors.cFF8E21,
    this.borderColor = AppColors.cFF8E21,
    this.horizontalPadding
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: horizontalPadding??0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? selectedColor : unselectedColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? Colors.transparent : borderColor,
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.2,
                letterSpacing: 0,
                color: isSelected ? selectedTextColor : unselectedTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}