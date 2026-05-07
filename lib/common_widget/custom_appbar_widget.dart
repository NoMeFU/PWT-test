import 'package:flutter/material.dart';
import 'package:lawbug829/gen/colors.gen.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const CustomAppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.cFFFFFF,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 80.0),
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.c2F2F2F,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
