import 'dart:developer';
import 'package:lawbug829/networks/api_acess.dart';
import 'package:pinput/pinput.dart';
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
import 'package:lawbug829/helpers/ui_helpers.dart';

class VerifyEmailScreen extends StatefulWidget {
  final dynamic email;
  const VerifyEmailScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  //final _formKey = GlobalKey<FormState>();
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("Email: ${widget.email}");

    const focusedBorderColor = AppColors.cFF8E21;
    const fillColor = AppColors.cFFFFFF;
    const borderColor = AppColors.c212B36;

    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: const TextStyle(fontSize: 20, color: AppColors.cFF8E21),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Verify Email',
            style: TextFontStyle.headline20c212B36stylepoppinsW500),
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
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              thickness: 1.w,
              color: AppColors.cDFE3E8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  UIHelper.verticalSpace(31.h),
                  Center(
                    child: Image.asset(
                      Assets.images.mobileMessage.path,
                      width: 100.w,
                    ),
                  ),
                  UIHelper.verticalSpace(40.h),
                  Text(
                    'We sent a verification code to your email. Please check your email and enter the verification code.',
                    style: TextFontStyle.headline16c919EABstylepoppinsW400
                        .copyWith(
                            fontSize: 12.sp,
                            color: AppColors.c454F5B,
                            height: 1.57.h),
                    textAlign: TextAlign.center,
                  ),
                  UIHelper.verticalSpace(24.h),
                  Row(
                    children: [
                      Text(
                        'Code',
                        style: TextFontStyle.headline14StyleMontserrat500
                            .copyWith(color: AppColors.c212B36),
                      ),
                      const Spacer(),
                      Text(
                        'Resend ',
                        style: TextFontStyle.headline14StyleMontserrat600
                            .copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.c212B36,
                                decoration: TextDecoration.underline),
                      ),
                      UIHelper.horizontalSpace(4.w),
                      Text(
                        'in.50 sec',
                        style: TextFontStyle.headline14StyleMontserrat600
                            .copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.c919EAB),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(16.h),
                  Pinput(
                    length: 6,
                    controller: _pinController,
                    focusNode: _focusNode,
                    defaultPinTheme: defaultPinTheme,
                    separatorBuilder: (_) => const SizedBox(width: 8),
                    onCompleted: (pin) => debugPrint('Completed: $pin'),
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          width: 20,
                          height: 2,
                          color: focusedBorderColor,
                        ),
                      ],
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(32.h),
                  Text(
                    'Enter verification code sent to your email address',
                    style: TextFontStyle.headline20c212B36stylepoppinsW500
                        .copyWith(fontSize: 12.sp),
                  ),
                  UIHelper.verticalSpace(8.h),
                  Text(
                    widget.email,
                    style: TextFontStyle.headline20c212B36stylepoppinsW500
                        .copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.cFF8E21),
                  ),
                  UIHelper.verticalSpace(80.h),
                  customeButton(
                    name: 'Conform',
                    context: context,
                    onCallBack: () async {
                      try {
                        await postVerifyEmailApiRXObj.verifyEmailRX(
                          email: widget.email,
                          otp: _pinController.text,
                        );
                        NavigationService.navigateTo(Routes.loginScreen);
                      } catch (e) {
                        // * Handle error (e.g., show error message)
                        debugPrint('Error during : $e');
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
