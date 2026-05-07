import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/common_widget/custom_app_bar.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Setting',
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
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              thickness: 1.w,
              color: AppColors.cDFE3E8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                color: Colors.transparent,
                height: 420.h,
                width: double.infinity,
                child: Column(
                  children: [
                    // * ================= Change Password =============== //
                    GestureDetector(
                      onTap: () {
                        NavigationService.navigateTo(
                          Routes.resetPasswordScreen,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                Assets.images.settingLockIcon.path,
                                height: 32.h,
                                width: 32.w,
                              ),
                              UIHelper.horizontalSpace(16.h),
                              Text(
                                "Change Password",
                                style: TextFontStyle.textStylePoppinsW400
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.c454F5B),
                              )
                            ],
                          ),
                          Image.asset(
                            Assets.images.profileRightArrow.path,
                            height: 24.h,
                            width: 24.w,
                          )
                        ],
                      ),
                    ),
                    UIHelper.verticalSpace(16.h),
                    Container(
                      color: AppColors.cEBEBEB,
                      height: 1.h,
                      width: double.infinity,
                    ),
                    UIHelper.verticalSpace(16.h),

                    // * ================= Terms, Privacy and Policy ===============//
                    GestureDetector(
                      onTap: () async {
                        const url =
                            'https://www.apple.com/legal/internet-services/itunes/dev/stdeula/';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(
                            Uri.parse(url),
                            mode: LaunchMode
                                .externalApplication, // ✅ open in browser
                          );
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                Assets.images.settingTermIcon.path,
                                height: 32.h,
                                width: 32.w,
                              ),
                              UIHelper.horizontalSpace(16.h),
                              Text(
                                "Terms of Condition",
                                style:
                                    TextFontStyle.textStylePoppinsW400.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.c454F5B,
                                ),
                              ),
                            ],
                          ),
                          Image.asset(
                            Assets.images.profileRightArrow.path,
                            height: 24.h,
                            width: 24.w,
                          ),
                        ],
                      ),
                    ),

                    UIHelper.verticalSpace(16.h),
                    Container(
                      color: AppColors.cEBEBEB,
                      height: 1.h,
                      width: double.infinity,
                    ),
                    UIHelper.verticalSpace(16.h),

                    GestureDetector(
                      onTap: () async {
                        const url =
                            'https://sites.google.com/view/previlliagetimekeeper/privacy_policy';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(
                            Uri.parse(url),
                            mode: LaunchMode
                                .externalApplication, // ✅ open in browser
                          );
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                Assets.images.settingPrivacyIcon.path,
                                height: 32.h,
                                width: 32.w,
                              ),
                              UIHelper.horizontalSpace(16.h),
                              Text(
                                "Privacy Policy",
                                style:
                                    TextFontStyle.textStylePoppinsW400.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.c454F5B,
                                ),
                              ),
                            ],
                          ),
                          Image.asset(
                            Assets.images.profileRightArrow.path,
                            height: 24.h,
                            width: 24.w,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
