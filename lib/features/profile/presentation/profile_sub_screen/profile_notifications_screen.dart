import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/common_widget/custom_app_bar.dart';

import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../helpers/ui_helpers.dart';

class ProfileNotificationsScreen extends StatefulWidget {
  const ProfileNotificationsScreen({super.key});

  @override
  State<ProfileNotificationsScreen> createState() =>
      _ProfileNotificationsScreen();
}

class _ProfileNotificationsScreen extends State<ProfileNotificationsScreen> {
  bool inboxIsSwitched = true;
  bool ratingIsSwitched = true;
  bool promotionIsSwitched = true;
  bool accountIsSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Notifications',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            thickness: 1.w,
            color: AppColors.cDFE3E8,
          ),
          UIHelper.verticalSpace(16.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Get push notifications about...",
                  style: TextFontStyle.text15cFFF2C2.copyWith(
                      color: AppColors.c212B36,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                UIHelper.verticalSpace(16.h),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Inbox Messages",
                          style: TextFontStyle.arabic16c161C24StyleMeQuran
                              .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.c212B36),
                        ),
                        UIHelper.horizontalSpace(2.h),
                        Text(
                          "Receive Notifications when a response",
                          style: TextFontStyle.arabic16c161C24StyleMeQuran
                              .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.c637381),
                        )
                      ],
                    ),
                    Switch(
                      value: inboxIsSwitched,
                      onChanged: (value) {
                        setState(() {
                          inboxIsSwitched = value;
                        });
                      },
                      activeColor: Colors
                          .orange, // Matches the orange color in your image
                    )
                  ],
                ),
                UIHelper.verticalSpace(16.h),
                Container(
                  color: AppColors.cEBEBEB,
                  height: 1.h,
                  width: double.infinity,
                ),



                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rating Reminder",
                          style: TextFontStyle.arabic16c161C24StyleMeQuran
                              .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.c212B36),
                        ),
                        UIHelper.horizontalSpace(2.h),
                        Text(
                          "Receive Notifications when a response",
                          style: TextFontStyle.arabic16c161C24StyleMeQuran
                              .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.c637381),
                        )
                      ],
                    ),
                    Switch(
                      value: ratingIsSwitched,
                      onChanged: (value) {
                        setState(() {
                          ratingIsSwitched = value;
                        });
                      },
                      activeColor: Colors
                          .orange, // Matches the orange color in your image
                    )
                  ],
                ),
                UIHelper.verticalSpace(16.h),
                Container(
                  color: AppColors.cEBEBEB,
                  height: 1.h,
                  width: double.infinity,
                ),



                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Promotion and Tips",
                          style: TextFontStyle.arabic16c161C24StyleMeQuran
                              .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.c212B36),
                        ),
                        UIHelper.horizontalSpace(2.h),
                        Text(
                          "Receive Notifications when a response",
                          style: TextFontStyle.arabic16c161C24StyleMeQuran
                              .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.c637381),
                        )
                      ],
                    ),
                    Switch(
                      value: promotionIsSwitched,
                      onChanged: (value) {
                        setState(() {
                          promotionIsSwitched = value;
                        });
                      },
                      activeColor: Colors
                          .orange, // Matches the orange color in your image
                    )
                  ],
                ),
                UIHelper.verticalSpace(16.h),
                Container(
                  color: AppColors.cEBEBEB,
                  height: 1.h,
                  width: double.infinity,
                ),




                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Account",
                          style: TextFontStyle.arabic16c161C24StyleMeQuran
                              .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.c212B36),
                        ),
                        UIHelper.horizontalSpace(2.h),
                        Text(
                          "Receive Notifications when a response",
                          style: TextFontStyle.arabic16c161C24StyleMeQuran
                              .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.c637381),
                        )
                      ],
                    ),
                    Switch(
                      value: accountIsSwitched,
                      onChanged: (value) {
                        setState(() {
                          accountIsSwitched = value;
                        });
                      },
                      activeColor: Colors
                          .orange, // Matches the orange color in your image
                    )
                  ],
                ),
                UIHelper.verticalSpace(16.h),
                Container(
                  color: AppColors.cEBEBEB,
                  height: 1.h,
                  width: double.infinity,
                ),


              ],
            ),
          )
        ],
      ),
    );
  }
}
