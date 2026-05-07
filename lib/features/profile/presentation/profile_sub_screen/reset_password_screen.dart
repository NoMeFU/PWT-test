import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:lawbug829/networks/api_acess.dart';

import '../../../../common_widget/custom_app_bar.dart';
import '../../../../common_widget/custom_button.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/navigation_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Reset Password',
            style: TextFontStyle.headline20c212B36stylepoppinsW500),
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: GestureDetector(
            onTap: () {
              NavigationService.goBack();
            },
            child: SvgPicture.asset(
              Assets.icons.arrowBackLawbug,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              thickness: 1.w,
              color: AppColors.cDFE3E8,
            ),
            UIHelper.verticalSpace(16.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Old Password',
                      style: TextFontStyle.headline20c212B36stylepoppinsW500
                          .copyWith(fontSize: 14.sp, height: 2.57.h),
                    ),
                  ),
                  UIHelper.verticalSpace(6.h),
                  TextFormField(
                    controller: oldPassController,
                    cursorColor: AppColors.c000000,
                    cursorRadius: Radius.circular(8.r),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide:
                                const BorderSide(color: Color(0xffC1D2C5))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide:
                                const BorderSide(color: Color(0xffC1D2C5))),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide:
                              const BorderSide(color: Color(0xffC1D2C5)),
                        ),
                        hintText: 'Enter Your Current Password',
                        hintStyle: TextFontStyle
                            .headline16c919EABstylepoppinsW400
                            .copyWith(
                                fontSize: 14.sp, color: AppColors.cCDCDCD)),
                    keyboardType: TextInputType.emailAddress,
                    //     validator: (v) {
                    //   if (v == null || v.trim().isEmpty) {
                    //     return 'Email is required';
                    //   }
                    //   if (!_emailRegex.hasMatch(v.trim())) {
                    //     return 'Enter a valid email';
                    //   }
                    //   return null;
                    // },
                  ),
                  UIHelper.verticalSpace(4.h),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'New Password',
                      style: TextFontStyle.headline20c212B36stylepoppinsW500
                          .copyWith(fontSize: 14.sp, height: 2.57.h),
                    ),
                  ),
                  UIHelper.verticalSpace(6.h),
                  TextFormField(
                    controller: newPassController,
                    cursorColor: AppColors.c000000,
                    cursorRadius: Radius.circular(8.r),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide:
                                const BorderSide(color: Color(0xffC1D2C5))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide:
                                const BorderSide(color: Color(0xffC1D2C5))),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide:
                              const BorderSide(color: Color(0xffC1D2C5)),
                        ),
                        hintText: 'Enter your new password',
                        hintStyle: TextFontStyle
                            .headline16c919EABstylepoppinsW400
                            .copyWith(
                                fontSize: 14.sp, color: AppColors.cCDCDCD)),
                    keyboardType: TextInputType.emailAddress,
                    //     validator: (v) {
                    //   if (v == null || v.trim().isEmpty) {
                    //     return 'Email is required';
                    //   }
                    //   if (!_emailRegex.hasMatch(v.trim())) {
                    //     return 'Enter a valid email';
                    //   }
                    //   return null;
                    // },
                  ),
                  UIHelper.verticalSpace(4.h),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Confirm Password',
                      style: TextFontStyle.headline20c212B36stylepoppinsW500
                          .copyWith(fontSize: 14.sp, height: 2.57.h),
                    ),
                  ),
                  UIHelper.verticalSpace(6.h),
                  TextFormField(
                    controller: confirmPassController,
                    cursorColor: AppColors.c000000,
                    cursorRadius: Radius.circular(8.r),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide:
                                const BorderSide(color: Color(0xffC1D2C5))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide:
                                const BorderSide(color: Color(0xffC1D2C5))),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide:
                              const BorderSide(color: Color(0xffC1D2C5)),
                        ),
                        hintText: 'Re-enter your password',
                        hintStyle: TextFontStyle
                            .headline16c919EABstylepoppinsW400
                            .copyWith(
                                fontSize: 14.sp, color: AppColors.cCDCDCD)),
                    keyboardType: TextInputType.emailAddress,
                    //     validator: (v) {
                    //   if (v == null || v.trim().isEmpty) {
                    //     return 'Email is required';
                    //   }
                    //   if (!_emailRegex.hasMatch(v.trim())) {
                    //     return 'Enter a valid email';
                    //   }
                    //   return null;
                    // },
                  ),
                  UIHelper.verticalSpace(250.h),
                  
                  
                  customeButton(
                    name: 'Update',
                    context: context,
                    onCallBack: () async {
                      bool isSuccess =
                          await postResetPassApiRXObj.postResetPassRx(
                        old_password: oldPassController.text,
                        new_password: newPassController.text,
                        new_password_confirmation: confirmPassController.text,
                      );

                      if (isSuccess) {
                        // Show GetX snackbar on top
                        Get.snackbar(
                          'Success',
                          'Password updated successfully.',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                          margin: const EdgeInsets.all(10),
                          borderRadius: 10,
                        );
                        NavigationService.goBack();
                      } else {
                        // Show default snackbar on bottom for error
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to update password.'),
                          ),
                        );
                      }
                    },
                  ),
                  UIHelper.verticalSpace(30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
