import 'package:flutter/material.dart';

class LineIndicatorWidget extends StatelessWidget {
  final bool isActive;
  final double activewidth;
  final double inactiveborderRadius;
  final double activeborderRadius;
  final double inactivewidth;
  final double height;
  final Color activeColor;
  final Color inactiveColor;

  const LineIndicatorWidget({
    super.key,
    required this.isActive,
    required this.activewidth,
    required this.inactivewidth,
    required this.height,
    required this.activeColor,
    required this.activeborderRadius,
    required this.inactiveborderRadius,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: isActive ? activewidth : inactivewidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isActive? activeborderRadius:inactiveborderRadius),
        color: isActive ? activeColor : inactiveColor,
      ),
    );
  }
}
