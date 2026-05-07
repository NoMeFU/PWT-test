import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/gen/colors.gen.dart';

import '../../../../common_widget/custom_app_bar.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../helpers/ui_helpers.dart';

class TermsConditionScreen extends StatefulWidget {
  const TermsConditionScreen({super.key});

  @override
  State<TermsConditionScreen> createState() => _TermsConditionScreen();
}

class _TermsConditionScreen extends State<TermsConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Terms and Condition',
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
    crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIHelper.verticalSpace(33.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Match Muse. Your privacy is important to us, and we are committed to protecting the personal information you share with us. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our app.',
                style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.c637381
                ),
              ),
              UIHelper.verticalSpace(20.h),
              Text(
                'Use of the App',
                style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.c212B36
                ),
              ),
              UIHelper.verticalSpace(6.h),
              Text(
                'We may collect the following types of information',
                style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.c637381
                ),
              ),
              UIHelper.verticalSpace(14.h),

              // Bullet Point 1
              _buildBulletPoint(
                title: 'Eligibility : ',
                content:
                'You must be at least 18 years old or have parental consent to use this app..',
              ),

              // Bullet Point 2
              UIHelper.verticalSpace(14.h),
              _buildBulletPoint(
                title: 'Account Responsibility : ',
                content:
                'You are responsible for maintaining the confidentiality of your account credentials and for all activities under your account.',
              ),

              // Bullet Point 3
              UIHelper.verticalSpace(14.h),
              _buildBulletPoint(
                title: 'Permitted Use :  ',
                content:
                'The app is for personal use only. Commercial use or resale is prohibited without prior written consent.',
              ),

              UIHelper.verticalSpace(20.h),
              Text(
                'User Content',
                style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.c212B36
                ),
              ),
              UIHelper.verticalSpace(6.h),
              Text(
                'We use the information we collect to',
                style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.c637381
                ),
              ),

              // Bullet Points - User Content
              UIHelper.verticalSpace(14.h),
              _buildBulletPoint(
                title: 'Ownership : ',
                content:
                'You retain ownership of the data and content you input, including pet details and health records.',
              ),

              UIHelper.verticalSpace(14.h),
              _buildBulletPoint(
                title: 'License to Us : ',
                content:
                'By submitting content, you grant us a non-exclusive, royalty-free license to use it for providing and improving app services.',
              ),

              UIHelper.verticalSpace(14.h),
              _buildBulletPoint(
                title: 'Prohibited Content :  ',
                content:
                "You agree not to upload content that is unlawful, offensive, or infringes on others' rights.",
              ),

              UIHelper.verticalSpace(20.h),
              Text(
                'Health Information Disclaimer',
                style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.c212B36
                ),
              ),
              UIHelper.verticalSpace(14.h),
              _buildBulletPoint(
                title: 'Not Veterinary Advice : ',
                content:
                'The app provides tools and insights to track your pet’s health but is not a substitute for professional veterinary advice. Always consult a licensed veterinarian for health concerns.',
              ),

              UIHelper.verticalSpace(14.h),
              Padding(
                padding: EdgeInsets.only(left: 0.w, bottom: 2.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "• ",
                      style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.c212B36
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Accuracy of Information : ",
                              style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.c212B36
                              ),
                            ),
                            TextSpan(
                              text:
                              "While we strive for accuracy, we cannot guarantee the reliability of information provided through the app.",
                              style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.c637381
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              UIHelper.verticalSpace(20.h),
              Text(
                'Fees and Payments',
                style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.c212B36
                ),
              ),
              UIHelper.verticalSpace(14.h),
              _buildBulletPoint(
                title: 'Free and Paid Features : ',
                content:
                'The app may include free and premium features. Payment terms for premium services will be clearly outlined during purchase.',
              ),
              UIHelper.verticalSpace(14.h),
              _buildBulletPoint(
                title: 'Refund Policy : ',
                content:
                'Refund requests will be handled according to applicable laws and stated refund policies.',
              ),

              UIHelper.verticalSpace(20.h),
              Text(
                'Prohibited Activities',
                style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.c212B36
                ),
              ),
              UIHelper.verticalSpace(6.h),
              Text(
                'You agree not to',
                style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.c637381
                ),
              ),

              UIHelper.verticalSpace(14.h),
              _buildPlainBullet(
                content: 'Use the app for unlawful or harmful purposes.',
              ),
              UIHelper.verticalSpace(14.h),
              _buildPlainBullet(
                content: 'Reverse-engineer, decompile, or tamper with the app.',
              ),
              UIHelper.verticalSpace(14.h),
              _buildPlainBullet(
                content: 'Access or scrape the app using authorization tools.',
              ),

              UIHelper.verticalSpace(20.h),
              Text(
                'Intellectual Property',
                style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.c212B36
                ),
              ),
              UIHelper.verticalSpace(6.h),
              Text(
                'All intellectual property rights, including trademarks, logos, and app content, are owned by us or our licensors. You may not use these without our permission.',
                style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.c637381
                ),
              ),

              UIHelper.verticalSpace(20.h),
              Text(
                'Limitation of Liability',
                style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.c212B36
                ),
              ),
              UIHelper.verticalSpace(6.h),
              Text(
                'We are not liable for any indirect, incidental, or consequential damages arising from your use of the app, except as required by law.',
                style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.c637381
                ),
              ),

              UIHelper.verticalSpace(20.h),
              Text(
                'Modifications',
                style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.c212B36
                ),
              ),
              UIHelper.verticalSpace(6.h),
              Text(
                'We may modify these terms at any time. Changes will be posted within the app, and continued use indicates your acceptance.',
                style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.c637381
                ),
              ),

              UIHelper.verticalSpace(20.h),
              Text(
                'Governing Law',
                style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.c212B36
                ),
              ),
              UIHelper.verticalSpace(6.h),
              Text(
                'These terms are governed by the laws of [Your Country/State], without regard to its conflict of laws principles.',
                style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.c637381
                ),
              ),

              UIHelper.verticalSpace(20.h),
              Text(
                'Contact Us',
                style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.c212B36
                ),
              ),
              UIHelper.verticalSpace(6.h),
              Text(
                'If you have questions about this Privacy Policy, please contact us at',
                style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.c637381
                ),
              ),
              UIHelper.verticalSpace(14.h),
            ],
          ),
        ),
      ],
    ),
    ),

    );
  }



  Widget _buildBulletPoint({required String title, required String content}) {
    return Padding(
      padding: EdgeInsets.only(left: 0.w, bottom: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.c212B36
          ),),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.c212B36
                    ),
                  ),
                  TextSpan(
                    text: content,
                    style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.c637381
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlainBullet({required String content}) {
    return Padding(
      padding: EdgeInsets.only(left: 0.w, bottom: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.c212B36
          ),),
          Expanded(
            child: Text(
              content,
              style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.c637381
              ),
            ),
          ),
        ],
      ),
    );
  }




}

