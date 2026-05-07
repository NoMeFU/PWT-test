// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/assets_healper/app_lottie.dart';
import 'package:lawbug829/constants/app_constants.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/di.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:lawbug829/networks/api_acess.dart';
import 'package:lawbug829/networks/stream_cleaner.dart';
import 'package:lottie/lottie.dart';

import '../../../common_widget/custom_button.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';

void deleteAccountDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Delete Account?",
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: MediaQuery.of(context).size.width * 1.85.w,
              height: 400.h,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: AppColors.cFFFFFF,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.images.logoutDoorImage.path,
                    height: 87,
                    width: 79,
                  ),
                  UIHelper.verticalSpace(16.h),
                  Text(
                    "Delete Account",
                    style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: AppColors.c212B36,
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),
                  Text(
                    "Are you sure to delete your account? you will lose all your data.",
                    style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.c637381,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  UIHelper.verticalSpace(24.h),
                  customeButton(
                    height: 48.h,
                    name: 'Delete Account',
                    context: context,
                    onCallBack: () async {
                      try {
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => WillPopScope(
                            onWillPop: () async => false,
                            child: Center(
                              child: Lottie.asset(
                                AppLottie.loading,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                fit: BoxFit.contain,
                                repeat: true,
                              ),
                            ),
                          ),
                        );

                        bool success = await deleteAccountApiRX.deleteAccount();

                        if (success) {
                          Future.delayed(const Duration(milliseconds: 300));
                          NavigationService.navigateToReplacementUntil(
                            Routes.loginScreen,
                          );
                          totalDataClean();
                          appData.write(kKeyIsLoggedIn, false);
                        } else {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Account delete failed. Please try again.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } catch (error) {
                        log('Logout error: $error');
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: $error'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                  ),
                  UIHelper.verticalSpace(24.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Center(
                      child: Container(
                        width: double.infinity,
                        height: 48.h,
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "Cancel",
                            style: TextFontStyle.arabic16c161C24StyleMeQuran
                                .copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.cFF8E21,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.8, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
        ),
        child: child,
      );
    },
  );
}
