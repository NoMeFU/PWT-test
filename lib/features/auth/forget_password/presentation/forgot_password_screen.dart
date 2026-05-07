import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/common_widget/custom_app_bar.dart';
import 'package:lawbug829/common_widget/custom_button.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:lawbug829/networks/api_acess.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: CustomAppBar(
        leading: GestureDetector(
          onTap: () {
            NavigationService.goBack();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: SvgPicture.asset(
              Assets.icons.arrowBackLawbug,
            ),
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
          child: Column(
            children: [
              UIHelper.verticalSpace(26.h),
              Center(
                child: Text(
                  'Forgot Password',
                  style: TextFontStyle.headline20c212B36stylepoppinsW500
                      .copyWith(
                          fontSize: 32.sp,
                          color: AppColors.cFF8E21,
                          height: 1.5.h,
                          fontWeight: FontWeight.w600),
                ),
              ),
              UIHelper.verticalSpace(4.h),
              Text(
                'Please provide your registered email address to receive a password reset code.',
                style: TextFontStyle.headline16c919EABstylepoppinsW400.copyWith(
                    fontSize: 14.sp, height: 1.57.h, color: AppColors.c454F5B),
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpace(32.h),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Email address',
                  style: TextFontStyle.headline20c212B36stylepoppinsW500
                      .copyWith(fontSize: 14.sp, height: 2.57.h),
                ),
              ),
              UIHelper.verticalSpace(6.h),
              TextFormField(
                controller: _emailController,
                cursorColor: AppColors.c000000,
                cursorRadius: Radius.circular(8.r),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(
                      color: AppColors.cFFDCBA,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(
                      color: AppColors.cFFDCBA,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      8.r,
                    ),
                    borderSide: const BorderSide(
                      color: AppColors.cFFB36A,
                    ),
                  ),
                  hintText: 'Enter Email address',
                  hintStyle:
                      TextFontStyle.headline16c919EABstylepoppinsW400.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.cCDCDCD,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              UIHelper.verticalSpace(310.h),
              customeButton(
                name: 'Send Code',
                onCallBack: () async {
                  try {
                    await postForgetPassRX.forgetAPI(
                      email: _emailController.text,
                    );
                    NavigationService.navigateToWithArgs(
                        Routes.verifyEmailScreen, {
                      'email': _emailController.text,
                    });
                    ToastUtil.showLongToast(
                      'Check your email for the OTP',
                    );
                  } catch (e) {
                    // Handle error (e.g., show error message)
                    debugPrint('Error during login: $e');
                  }
                },
                context: context,
              )
            ],
          ),
        ),
      ),
    );
  }
}
