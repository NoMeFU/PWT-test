import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/features/profile/widget/delete_account_screen.dart';
import 'package:lawbug829/features/profile/widget/logOutDialogueBox.dart';
import 'package:lawbug829/features/subscription/model/subscription_check_model.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:lawbug829/networks/api_acess.dart';
import '../../../gen/assets.gen.dart';

class ProfileListWidget extends StatefulWidget {
  const ProfileListWidget({super.key});

  @override
  State<ProfileListWidget> createState() => _ProfileListWidgetState();
}

class _ProfileListWidgetState extends State<ProfileListWidget> {
  @override
  void initState() {
    super.initState();
    getSubscriptionCheckRXObj.getSubscriptionCheckRX;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      child: Column(
        children: [
          //* ================= Profile Information ===============//
          GestureDetector(
            onTap: () {
              NavigationService.navigateTo(Routes.personalInfoScreen);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      Assets.images.profileProfileIcon.path,
                      height: 32.h,
                      width: 32.w,
                    ),
                    UIHelper.horizontalSpace(16.h),
                    Text(
                      "Personal Information",
                      style: TextFontStyle.textStylePoppinsW400.copyWith(
                        fontSize: 13.sp,
                        color: AppColors.c454F5B,
                      ),
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

          // UIHelper.verticalSpace(16.h),
          // GestureDetector(
          //   onTap: () {
          //     NavigationService.navigateTo(Routes.profileNotificationScreen);
          //   },
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Row(
          //         children: [
          //           Image.asset(
          //             Assets.images.profileBellIcon.path,
          //             height: 32.h,
          //             width: 32.w,
          //           ),
          //           UIHelper.horizontalSpace(16.h),
          //           Text(
          //             "Notification",
          //             style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w500,
          //                 color: AppColors.c454F5B),
          //           )
          //         ],
          //       ),
          //       Image.asset(
          //         Assets.images.profileRightArrow.path,
          //         height: 24.h,
          //         width: 24.w,
          //       )
          //     ],
          //   ),
          // ),
          UIHelper.verticalSpace(16.h),
          StreamBuilder<CheckSubscription>(
              stream: getSubscriptionCheckRXObj.dataFetcher,
              builder: (context, snapshot) {
                var isSubscribed = snapshot.data?.data?.isSubscribed ?? false;
                log(">>>>>>>>>>>>>>>>>>>>>>>> Profile Section Subscription Checking: $isSubscribed");

                return GestureDetector(
                  onTap: () {
                    if (isSubscribed == false) {
                      NavigationService.navigateTo(
                        Routes.subscriptionScreen,
                      );
                      return;
                    } else {
                      NavigationService.navigateTo(
                        Routes.addFacingProblemScreen,
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.icons.facingProblem,
                            height: 32.h,
                            width: 32.w,
                          ),
                          UIHelper.horizontalSpace(16.h),
                          Text(
                            "Faceing Problem",
                            style: TextFontStyle.textStylePoppinsW400.copyWith(
                              fontSize: 13.sp,
                              color: AppColors.c454F5B,
                            ),
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
                );
              }),
          UIHelper.verticalSpace(16.h),
          Container(
            color: AppColors.cEBEBEB,
            height: 1.h,
            width: double.infinity,
          ),
          UIHelper.verticalSpace(16.h),

          // * ================= Help and support, App Review, Partnership ===============//
          GestureDetector(
            onTap: () {
              NavigationService.navigateTo(Routes.helpSupportScreen);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      Assets.images.profileHelpIcon.path,
                      height: 32.h,
                      width: 32.w,
                    ),
                    UIHelper.horizontalSpace(16.h),
                    Text(
                      "Help & Support",
                      style: TextFontStyle.textStylePoppinsW400.copyWith(
                        fontSize: 13.sp,
                        color: AppColors.c454F5B,
                      ),
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
          GestureDetector(
            onTap: () {
              NavigationService.navigateTo(Routes.addReviewScreen);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      Assets.images.profileStarIcon.path,
                      height: 32.h,
                      width: 32.w,
                    ),
                    UIHelper.horizontalSpace(16.h),
                    Text(
                      "Add Review",
                      style: TextFontStyle.textStylePoppinsW400.copyWith(
                        fontSize: 13.sp,
                        color: AppColors.c454F5B,
                      ),
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
          // UIHelper.verticalSpace(16.h),
          // GestureDetector(
          //   onTap: () {
          //     NavigationService.navigateTo(Routes.partnershipAgencyScreen);
          //   },
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Row(
          //         children: [
          //           Image.asset(
          //             Assets.images.profilePartnershipIcon.path,
          //             height: 32.h,
          //             width: 32.w,
          //           ),
          //           UIHelper.horizontalSpace(16.h),
          //           Text(
          //             "Partnership Agency",
          //             style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w500,
          //                 color: AppColors.c454F5B),
          //           )
          //         ],
          //       ),
          //       Image.asset(
          //         Assets.images.profileRightArrow.path,
          //         height: 24.h,
          //         width: 24.w,
          //       )
          //     ],
          //   ),
          // ),
          UIHelper.verticalSpace(16.h),
          Container(
            color: AppColors.cEBEBEB,
            height: 1.h,
            width: double.infinity,
          ),
          UIHelper.verticalSpace(16.h),

          // * ================= Delete Account, Logout ===============//
          GestureDetector(
            onTap: () {
              deleteAccountDialog(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      Assets.images.profileDeleteIcon.path,
                      height: 32.h,
                      width: 32.w,
                    ),
                    UIHelper.horizontalSpace(16.h),
                    Text(
                      "Delete Account",
                      style: TextFontStyle.textStylePoppinsW400.copyWith(
                        fontSize: 13.sp,
                        color: AppColors.c454F5B,
                      ),
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

          // * =========== Logout ============== //
          GestureDetector(
            onTap: () {
              logoutDialogueBox(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      Assets.images.profileLogoutIcon.path,
                      height: 32.h,
                      width: 32.w,
                    ),
                    UIHelper.horizontalSpace(16.h),
                    Text(
                      "Logout ",
                      style: TextFontStyle.textStylePoppinsW400.copyWith(
                        fontSize: 13.sp,
                        color: AppColors.c454F5B,
                      ),
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
        ],
      ),
    );
  }
}
