import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';

deleteButtonDialouge(BuildContext context, String text, VoidCallback callback) {
  showDialog(
    builder: (context) => Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: .27.sh, maxWidth: .38.sw),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // SvgPicture.asset(Assets.icons.logo.path),
              // Text(
              //   'Are you sure?'.tr,
              //   style: TextFontStyle.headline16StyleMontserrat600.copyWith(color: Colors.black),
              // ),
              // UIHelper.verticalSpaceSmall,
              // Text(
              //   text.tr,
              //   style: TextFontStyle.headline12StyleMontserrat500.copyWith(color: AppColors.primaryColor),
              // ),
              UIHelper.verticalSpaceMedium,

              //Gravar Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // customeButton(
                  //     name: 'No'.tr,
                  //     onCallBack: () {
                  //       NavigationService.goBack;
                  //     },
                  //     height: 30.h,
                  //     minWidth: .25.sw,
                  //     borderRadius: 8.r,
                  //     color: AppColors.cFFFFFF,
                  //     // textStyle: TextFontStyle.headline12StyleMontserrat.copyWith(
                  //     //   color: AppColors.c000000,
                  //     // ),
                  //     context: context),
                  UIHelper.horizontalSpaceSmall,
                  //Cancelar
                  // customeButton(
                  //     name: 'Yes'.tr,
                  //     onCallBack: () {
                  //       callback();
                  //     },
                  //     height: 30.h,
                  //     minWidth: .25.sw,
                  //     borderRadius: 8.r,
                  //     color: AppColors.primaryColor,
                  //     textStyle: TextFontStyle.headline12StyleMontserrat.copyWith(color: AppColors.cFFFFFF),
                  //     context: context),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    context: context,
  );
}
