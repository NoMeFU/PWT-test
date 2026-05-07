import 'dart:developer';
import 'dart:io';
import 'package:lawbug829/helpers/platform_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawbug829/assets_healper/app_lottie.dart';
import 'package:lawbug829/common_widget/custom_button.dart';
import 'package:lawbug829/common_widget/custom_text_field.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/features/social_login/apple_login.dart';
import 'package:lawbug829/features/social_login/google_login.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:lawbug829/networks/api_acess.dart';
import 'package:lottie/lottie.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isRight = false;
  bool _isRightTwo = false;

  final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      // appBar: CustomAppBar(
      //   leading: GestureDetector(
      //     onTap: () {
      //       NavigationService.goBack();
      //     },
      //     child: Padding(
      //       padding: EdgeInsets.only(left: 16.w),
      //       child: SvgPicture.asset(
      //         Assets.icons.arrowBackLawbug,
      //       ),
      //     ),
      //   ),
      //   title: Image.asset(
      //     Assets.images.splashImageLawbug.path,
      //     width: 89.w,
      //     height: 60.h,
      //   ),
      // ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpace(60.h),
                Center(
                  child: Text(
                    'Welcome Back!',
                    style: TextFontStyle.headline20c212B36stylepoppinsW500
                        .copyWith(
                      fontSize: 24.sp,
                      color: AppColors.cFF8E21,
                      height: 1.5.h,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(4.h),
                Center(
                  child: Text(
                    'Log in to continue',
                    style: TextFontStyle.headline16c919EABstylepoppinsW400
                        .copyWith(
                      fontSize: 14.sp,
                      color: AppColors.c454F5B,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                UIHelper.verticalSpace(32.h),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Email address',
                    style: TextFontStyle.headline20c212B36stylepoppinsW500
                        .copyWith(
                      fontSize: 14.sp,
                      height: 2.57.h,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(6.h),

                ///>>>>>>>>>>>>>>>>>>>>>>>> email address text field >>>>>>>>>>>>>>>>>>>>>>>>
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Enter Email address',
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!_emailRegex.hasMatch(v.trim())) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                UIHelper.verticalSpace(4.h),

                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Password',
                    style: TextFontStyle.headline20c212B36stylepoppinsW500
                        .copyWith(
                      fontSize: 14.sp,
                      height: 2.57.h,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(6.h),

                ///>>>>>>>>>>>>>>>>>>>>>>> password text field >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Enter Password',
                  isPassword: true,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Password is required';
                    }
                    if (v.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                UIHelper.verticalSpace(12.h),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isRight = !_isRight;
                        });
                      },
                      child: SvgPicture.asset(
                        _isRight
                            ? Assets.icons.rectangleRight
                            : Assets.icons.rectangleRemember,
                      ),
                    ),
                    UIHelper.horizontalSpace(8.w),
                    Text(
                      'Remember me',
                      style: TextFontStyle.headline16c919EABstylepoppinsW400
                          .copyWith(
                        fontSize: 14.sp,
                        color: AppColors.c7E8A97,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        NavigationService.navigateTo(
                            Routes.forgotPasswordScreen);
                      },
                      child: Text(
                        'Forgot Password',
                        style: TextFontStyle.headline20c212B36stylepoppinsW500
                            .copyWith(
                          fontSize: 14.sp,
                          color: AppColors.cFF8E21,
                        ),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(28.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isRightTwo = !_isRightTwo;
                        });
                      },
                      child: SvgPicture.asset(
                        _isRightTwo
                            ? Assets.icons.rectangleRight
                            : Assets.icons.rectangleRemember,
                      ),
                    ),
                    UIHelper.horizontalSpace(8.w),
                    SizedBox(
                      width: 300.w,
                      child: Text(
                        'I hereby confirm and accept the Terms of Service and the Privacy Policy. I certify that I am over 18 years of age.',
                        style: TextFontStyle.headline16c919EABstylepoppinsW400
                            .copyWith(
                          fontSize: 12.sp,
                          height: 1.57.h,
                        ),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(32.h),

                _isRightTwo != true
                    ? customeButton(
                        name: 'Login',
                        context: context,
                        color: CupertinoColors.inactiveGray,
                        onCallBack: () async {
                          ToastUtil.showLongToast(
                              "Check the terms and condition");
                        },
                      )
                    : customeButton(
                        name: 'Login',
                        context: context,
                        onCallBack: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            // * Show loading dialog
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => WillPopScope(
                                onWillPop: () async => false,
                                child: Center(
                                  child: Lottie.asset(
                                    AppLottie.loading,
                                    width: 150.w,
                                    height: 150.h,
                                    fit: BoxFit.contain,
                                    repeat: true,
                                  ),
                                ),
                              ),
                            );

                            try {
                              debugPrint('Email: ${_emailController.text}');
                              debugPrint(
                                  'Password: ${_passwordController.text}');

                              bool success = await postSignInAPIRx.signIn(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );

                              // * Dismiss the loading dialog
                              Navigator.pop(context);

                              if (success) {
                                await Future.delayed(
                                  const Duration(milliseconds: 300),
                                );
                                NavigationService.navigateToWithArgs(
                                  Routes.bottomNavBar,
                                  {"pageNum": 0},
                                );
                              } else {
                                debugPrint(">>>>>>>>>>>>> Login failed");
                              }
                            } catch (e) {
                              Navigator.pop(context);
                              ToastUtil.showLongToast(
                                  "An error occurred. Please try again.");
                              debugPrint(">>>>>>>>>>> Login error: $e");
                            }
                          }
                        },
                      ),

                UIHelper.verticalSpace(32.h),
                Row(
                  children: [
                    Container(
                        width: 103.w, height: 1.h, color: AppColors.cCECECE),
                    UIHelper.horizontalSpace(6.w),
                    Text(
                      'Or continue with',
                      style: TextFontStyle.headline20c212B36stylepoppinsW500
                          .copyWith(
                        fontSize: 14.sp,
                        color: AppColors.c5A5A5A,
                      ),
                    ),
                    UIHelper.horizontalSpace(6.w),
                    Container(
                        width: 108.w, height: 1.h, color: AppColors.cCECECE),
                  ],
                ),
                UIHelper.verticalSpace(24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        log("==============>>>>>Clicked google sign in");
                        await GoogleAuthData.signInWithGoogle(context);
                      },
                      child: SvgPicture.asset(
                        Assets.icons.googleIcon,
                      ),
                    ),
                    if (SafePlatform.isIOS)
                      InkWell(
                        onTap: () async {
                          log("==============>>>>>Clicked apple sign in");
                          await SocialAuthApple.signInWithApple(context);
                        },
                        child: SvgPicture.asset(
                          Assets.icons.appleIcon,
                        ),
                      ),
                  ],
                ),
                UIHelper.verticalSpace(24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account?',
                      style: TextFontStyle.headline20c212B36stylepoppinsW500
                          .copyWith(
                        fontSize: 16.sp,
                        color: AppColors.c848484,
                      ),
                    ),
                    UIHelper.horizontalSpace(4.w),
                    GestureDetector(
                      onTap: () {
                        NavigationService.navigateTo(
                          Routes.locationAccessScreen,
                        );
                      },
                      child: Text(
                        'Register',
                        style: TextFontStyle.headline20c212B36stylepoppinsW500
                            .copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.cFF8E21,
                        ),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
