import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/assets_healper/app_lottie.dart';
import 'package:lawbug829/common_widget/custom_app_bar.dart';
import 'package:lawbug829/common_widget/custom_button.dart';
import 'package:lawbug829/common_widget/custom_text_field.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:lawbug829/networks/api_acess.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatefulWidget {
  final dynamic employeeAddress, employeeLat, employeeLong;

  const RegisterScreen({
    super.key,
    required this.employeeAddress,
    required this.employeeLat,
    required this.employeeLong,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  final _employeeIdController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _isRight = false;

  @override
  void dispose() {
    _employeeIdController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("Employee Address: ${widget.employeeAddress}");
    log("Employee Latitude: ${widget.employeeLat}");
    log("Employee Longitude: ${widget.employeeLong}");

    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: CustomAppBar(
        leading: GestureDetector(
          onTap: () => NavigationService.goBack(),
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: SvgPicture.asset(Assets.icons.arrowBackLawbug),
          ),
        ),
        title: Image.asset(
          Assets.images.splashImageLawbug.path,
          width: 89.w,
          height: 60.h,
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                UIHelper.verticalSpace(26.h),
                Center(
                  child: Text(
                    'Create An Account',
                    style: TextFontStyle.headline32c212B36stylepoppinsW700
                        .copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.cFF8E21,
                            height: 1.5.h),
                  ),
                ),
                UIHelper.verticalSpace(4.h),
                Text(
                  'To Create Account, Please Fill in the Form Below.',
                  style: TextFontStyle.headline16c919EABstylepoppinsW400
                      .copyWith(
                          fontSize: 14.sp,
                          color: AppColors.c454F5B,
                          height: 1.57.h),
                ),
                UIHelper.verticalSpace(24.h),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Employee ID',
                    style: TextFontStyle.headline20c212B36stylepoppinsW500
                        .copyWith(fontSize: 14.sp, height: 2.57.h),
                  ),
                ),
                UIHelper.verticalSpace(6.h),
                CustomTextField(
                  controller: _employeeIdController,
                  hintText: 'Enter Employee ID',
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Employee ID is required'
                      : null,
                ),
                UIHelper.verticalSpace(4.h),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Full Name',
                    style: TextFontStyle.headline20c212B36stylepoppinsW500
                        .copyWith(fontSize: 14.sp, height: 2.57.h),
                  ),
                ),
                UIHelper.verticalSpace(6.h),
                CustomTextField(
                  controller: _fullNameController,
                  hintText: 'Enter Full Name',
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Full name is required'
                      : null,
                ),
                UIHelper.verticalSpace(4.h),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Email address',
                    style: TextFontStyle.headline20c212B36stylepoppinsW500
                        .copyWith(fontSize: 14.sp, height: 2.57.h),
                  ),
                ),
                UIHelper.verticalSpace(6.h),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Enter Email address',
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty)
                      return 'Email is required';
                    if (!_emailRegex.hasMatch(v.trim()))
                      return 'Enter a valid email';
                    return null;
                  },
                ),
                UIHelper.verticalSpace(4.h),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Password',
                    style: TextFontStyle.headline20c212B36stylepoppinsW500
                        .copyWith(fontSize: 14.sp, height: 2.57.h),
                  ),
                ),
                UIHelper.verticalSpace(6.h),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Enter Password',
                  isPassword: true,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password is required';
                    if (v.length < 8)
                      return 'Password must be at least 8 characters';
                    return null;
                  },
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
                CustomTextField(
                  controller: _confirmController,
                  hintText: 'Enter Password',
                  isPassword: true,
                  validator: (v) {
                    if (v == null || v.isEmpty)
                      return 'Please confirm password';
                    if (v != _passwordController.text)
                      return 'Passwords do not match';
                    return null;
                  },
                ),
                UIHelper.verticalSpace(12.h),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _isRight = !_isRight),
                      child: SvgPicture.asset(
                        _isRight
                            ? Assets.icons.rectangleRight
                            : Assets.icons.rectangle,
                      ),
                    ),
                    UIHelper.horizontalSpace(8.w),
                    RichText(
                      text: TextSpan(
                        style: TextFontStyle.headline20c212B36stylepoppinsW500
                            .copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.c637381),
                        children: [
                          const TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: 'App Terms',
                            style: TextFontStyle
                                .headline20c212B36stylepoppinsW500
                                .copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.cFF8E21),
                          ),
                          const TextSpan(text: ' & '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextFontStyle
                                .headline20c212B36stylepoppinsW500
                                .copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.cFF8E21),
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(32.h),
                customeButton(
                  name: 'Confirm', // Fixed typo
                  context: context,
                  onCallBack: () async {
                    if (!_isRight) {
                      ToastUtil.showShortToast(
                          'Please agree to the Terms and Privacy Policy.');
                      return;
                    }
                    if (_formKey.currentState?.validate() ?? false) {
                      // Show loading dialog
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => WillPopScope(
                          onWillPop: () async => false,
                          child: Center(
                            child: Lottie.asset(
                              AppLottie.loading,
                              width: 100.w,
                              height: 100.h,
                              fit: BoxFit.contain,
                              repeat: true,
                            ),
                          ),
                        ),
                      );

                      try {
                        // Navigate to verifyEmailScreen
                        log("email: ${_emailController.text}");
                        log('name: ${_fullNameController.text}');
                        log('employee_id: ${_employeeIdController.text}');
                        log('current_location: ${widget.employeeAddress}');
                        log('lat: ${widget.employeeLat}');
                        log('long: ${widget.employeeLong}');
                        log('password: ${_passwordController.text}');
                        log('password_confirmation: ${_confirmController.text}');

                        // Call the signup API
                        bool success = await postSignUpAPIRx.signup(
                          employee_id: _employeeIdController.text.toString(),
                          name: _fullNameController.text.toString(),
                          email: _emailController.text.toString(),
                          password: _passwordController.text.toString(),
                          password_confirmation: _confirmController.text.toString(),
                          current_location: widget.employeeAddress.toString(),
                          lat: widget.employeeLat,
                          long: widget.employeeLong,
                        );

                        // Dismiss loading dialog
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }

                        if (success) {
                          await NavigationService.navigateToWithArgs(
                            Routes.verifyEmailScreen,
                            {'email': _emailController.text},
                          );
                        } else {
                          ToastUtil.showShortToast(
                              'Registration failed. Please try again.');
                        }
                      } catch (e, stackTrace) {
                        // Ensure loading dialog is dismissed
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                        log('Registration error in UI: $e',
                            stackTrace: stackTrace);
                        ToastUtil.showShortToast('Registration error: $e');
                      }
                    }
                  },
                ),
                UIHelper.verticalSpace(16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextFontStyle.headline20c212B36stylepoppinsW500
                          .copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.c848484),
                    ),
                    UIHelper.horizontalSpace(4.w),
                    GestureDetector(
                      onTap: () =>
                          NavigationService.navigateTo(Routes.loginScreen),
                      child: Text(
                        'Log In',
                        style: TextFontStyle.headline20c212B36stylepoppinsW500
                            .copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.cFF8E21),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(37.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
