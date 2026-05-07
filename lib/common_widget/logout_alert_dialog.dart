import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import '../gen/colors.gen.dart';

class LogoutAlertDialogWidget extends StatelessWidget {
  final Function() onTapYes;
  final String? title, description;
  const LogoutAlertDialogWidget(
      {super.key, this.title, this.description, required this.onTapYes});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.r))),
      title: Column(
        children: [
          // Text(
          //   title??"Log Out",
          //   textAlign: TextAlign.center,
          //   style: TextFontStyle.headline16c161C24StyleSoraW600,
          // ),
          UIHelper.verticalSpace(16.h),
          // Text(
          //   description??"Are you sure you want to log out?",
          //   textAlign: TextAlign.center,
          //   style: TextFontStyle.text16c637381StyleSoraW400,
          // )
        ],
      ),
      actions: <Widget>[
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      width: double.infinity,
                      height: 40.sp,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.primaryColor)),
                      // alignment: Alignment.center,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(
                          //   "No",
                          //   style: TextFontStyle.headline16c161C24StyleSoraW600
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                // UIHelper.horizontalSpace(10.w),
                Expanded(
                  child: InkWell(
                    onTap: onTapYes,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      height: 40.sp,
                      decoration: ShapeDecoration(
                        color: AppColors.cFFFFFF,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                      ),
                      // alignment: Alignment.center,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(
                          //   "Yes",
                          //   style: TextFontStyle.headline16c161C24StyleSoraW600.copyWith(
                          //     color: AppColors.cFFFFFF
                          //   )
                          // ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            UIHelper.verticalSpace(10.h)
          ],
        ),
      ],
    );
  }
}
