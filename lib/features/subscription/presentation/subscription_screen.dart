import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lawbug829/assets_healper/app_color.dart';
import 'package:lawbug829/common_widget/auth_button.dart';
import 'package:lawbug829/common_widget/custom_app_bar.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/features/subscription/presentation/widgets/plan_offer.dart';
import 'package:lawbug829/features/subscription/presentation/widgets/plans_condition.dart';
import 'package:lawbug829/features/subscription/subcription_service/subscriotion_provider.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:lawbug829/loading_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool isSelected = false;
  bool isLoading = false;
  bool isRestoreLoading = false;

  // * 0 for Yearly, 1 for Monthly
  int? selectedSubscription = 1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      log('============================= Subscription is calling');
      final purchaseProvider =
          Provider.of<PurchaseProvider>(context, listen: false);
      await purchaseProvider.fetchSubscriptions();
      await purchaseProvider.checkSubscriptionStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final purchaseProvider =
        Provider.of<PurchaseProvider>(context, listen: false);

    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Choose Your Plan',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'SUBSCRIPTION PLANS',
                    style: TextFontStyle.headline12c637381stylepoppinsW400
                        .copyWith(
                      color: AppColors.c000000,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(5.h),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Save 15% with annual billing,Cancel anytime.',
                    textAlign: TextAlign.center,
                    style: TextFontStyle.headline16c212B36stylepoppinsW600
                        .copyWith(
                      color: AppColors.c000000,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(5.h),
                UIHelper.customDivider(color: AppColors.cDFE3E8),
                UIHelper.verticalSpace(5.h),
                Consumer<PurchaseProvider>(builder: (context, p, _) {
                  if (p.packages.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  log("Monthly Plan:-${p.packages.first.storeProduct.title}\n");
                  log("Yearly Plan:-${p.packages.last.storeProduct.title}\n");
                  return Column(
                    children: [
                      // * ################################################################
                      // * Monthly Plan Section
                      // * ################################################################
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedSubscription = 1; // Select Monthly
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            children: [
                              UIHelper.verticalSpace(40.h),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: selectedSubscription == 1
                                        ? AppColors.cFF8E21
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    UIHelper.verticalSpace(24.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w, vertical: 8.h),
                                          decoration: BoxDecoration(
                                            color: AppColors.cFF8E21,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(24.r),
                                              topRight: Radius.circular(0.r),
                                              bottomRight: Radius.circular(0.r),
                                              bottomLeft: Radius.circular(24.r),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                Assets.icons.fireLawbug,
                                              ),
                                              UIHelper.horizontalSpace(2.w),
                                              Text(
                                                'Monthly ${p.packages.first.storeProduct.priceString}/per month',
                                                style: TextFontStyle
                                                    .headline14c22BB33stylepoppinsW700
                                                    .copyWith(
                                                  fontSize: 14.sp,
                                                  color: AppColors.cFFFFFF,
                                                  height: 1.83.h,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    UIHelper.verticalSpace(7.h),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${p.packages.first.storeProduct.title}\n"
                                                  "${p.packages.first.storeProduct.priceString}/per month",
                                                  style: TextFontStyle
                                                      .headline16c212B36stylepoppinsW600
                                                      .copyWith(
                                                    fontSize: 13.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          UIHelper.verticalSpace(23.h),
                                          PlansCondition(
                                            text:
                                                'Monthly Plans/${p.packages.first.storeProduct.priceString}/per month',
                                          ),
                                          UIHelper.verticalSpace(5.h),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                Assets.icons.fireOrangeLawbug,
                                              ),
                                              UIHelper.horizontalSpace(6.w),
                                              Expanded(
                                                child: Text(
                                                  p.packages.first.storeProduct
                                                      .description,
                                                  style: TextFontStyle
                                                      .headline16c212B36stylepoppinsW600
                                                      .copyWith(
                                                    fontSize: 11.sp,
                                                    height: 1.4,
                                                  ),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  softWrap: true,
                                                ),
                                              )
                                            ],
                                          ),
                                          UIHelper.verticalSpace(5.h),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                Assets.icons.fireOrangeLawbug,
                                              ),
                                              UIHelper.horizontalSpace(6.w),
                                              Text(
                                                'Billed monthly. Cancel anytime',
                                                style: TextFontStyle
                                                    .headline16c212B36stylepoppinsW600
                                                    .copyWith(
                                                  fontSize: 11.sp,
                                                  height: 1.4,
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.visible,
                                                softWrap: true,
                                              )
                                            ],
                                          ),
                                          UIHelper.verticalSpace(16.h),
                                          Row(
                                            children: [
                                              Container(
                                                width: 90.w,
                                                height: 1.h,
                                                decoration: const BoxDecoration(
                                                    color: AppColors.c919EAB),
                                              ),
                                              UIHelper.horizontalSpace(13.w),
                                              Text(
                                                'FEATURES',
                                                style: TextFontStyle
                                                    .headline8cFFFFFFstylepoppinsW500
                                                    .copyWith(
                                                        color:
                                                            AppColors.c637381,
                                                        fontSize: 10.sp),
                                              ),
                                              UIHelper.horizontalSpace(13.w),
                                              Container(
                                                width: 90.w,
                                                height: 1.h,
                                                decoration: const BoxDecoration(
                                                    color: AppColors.c919EAB),
                                              ),
                                            ],
                                          ),
                                          UIHelper.verticalSpace(12.h),
                                          PlanOffer(
                                            plans: 'Time Tracking – Unlimited',
                                          ),
                                          UIHelper.verticalSpace(8.h),
                                          PlanOffer(
                                            plans:
                                                'Record Storage/History – Unlimited',
                                          ),
                                          UIHelper.verticalSpace(8.h),
                                          PlanOffer(
                                            plans:
                                                'Equipment Usage - Unlimited',
                                          ),
                                          UIHelper.verticalSpace(8.h),
                                          PlanOffer(
                                            plans: 'Paycheck Calculation - Yes',
                                          ),
                                          UIHelper.verticalSpace(8.h),
                                          PlanOffer(
                                            plans:
                                                'Photo & File Uploads – 05GB',
                                          ),
                                          UIHelper.verticalSpace(8.h),
                                          PlanOffer(
                                            plans:
                                                'Notifications & Reminders – Yes',
                                          ),
                                          UIHelper.verticalSpace(8.h),
                                          PlanOffer(
                                            plans: 'Oneline Mode – Yes',
                                          ),
                                          UIHelper.verticalSpace(8.h),
                                          PlanOffer(
                                            plans: 'Expense Tracking - Yes',
                                          ),
                                          UIHelper.verticalSpace(8.h),
                                          PlanOffer(
                                            plans: 'Project Notes – Unlimited',
                                          ),
                                          UIHelper.verticalSpace(8.h),
                                          PlanOffer(
                                            plans:
                                                'Priority Support – Priority Support',
                                          ),
                                          UIHelper.verticalSpace(15.h),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      UIHelper.verticalSpace(10.h),

                      // * ################################################################
                      // * Yearly Plan Section
                      // * ################################################################
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedSubscription = 0; // Select Yearly
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            children: [
                              UIHelper.verticalSpace(40.h),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: selectedSubscription == 0
                                        ? AppColors.cFF8E21
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    UIHelper.verticalSpace(24.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w, vertical: 8.h),
                                          decoration: BoxDecoration(
                                            color: AppColors.cFF8E21,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(24.r),
                                              topRight: Radius.circular(0.r),
                                              bottomRight: Radius.circular(0.r),
                                              bottomLeft: Radius.circular(24.r),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                Assets.icons.fireLawbug,
                                              ),
                                              UIHelper.horizontalSpace(2.w),
                                              Text(
                                                'Yearly ${p.packages.last.storeProduct.priceString}/per year',
                                                style: TextFontStyle
                                                    .headline14c22BB33stylepoppinsW700
                                                    .copyWith(
                                                  fontSize: 13.sp,
                                                  color: AppColors.cFFFFFF,
                                                  height: 1.83.h,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    UIHelper.verticalSpace(7.h),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${p.packages.last.storeProduct.title}\n"
                                                  "${p.packages.last.storeProduct.priceString}/per year",
                                                  style: TextFontStyle
                                                      .headline16c212B36stylepoppinsW600
                                                      .copyWith(
                                                    fontSize: 13.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          UIHelper.verticalSpace(23.h),
                                          PlansCondition(
                                            text:
                                                'Yearly Plans/${p.packages.last.storeProduct.priceString}/per year',
                                          ),
                                          UIHelper.verticalSpace(5.h),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                Assets.icons.fireOrangeLawbug,
                                              ),
                                              UIHelper.horizontalSpace(6.w),
                                              Expanded(
                                                child: Text(
                                                  p.packages.last.storeProduct
                                                      .description,
                                                  style: TextFontStyle
                                                      .headline16c212B36stylepoppinsW600
                                                      .copyWith(
                                                    fontSize: 11.sp,
                                                    height: 1.4,
                                                  ),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  softWrap: true,
                                                ),
                                              )
                                            ],
                                          ),
                                          UIHelper.verticalSpace(5.h),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                Assets.icons.fireOrangeLawbug,
                                              ),
                                              UIHelper.horizontalSpace(6.w),
                                              Text(
                                                'Billed yearly. Cancel anytime.',
                                                style: TextFontStyle
                                                    .headline16c212B36stylepoppinsW600
                                                    .copyWith(
                                                  fontSize: 11.sp,
                                                  height: 1.4,
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.visible,
                                                softWrap: true,
                                              )
                                            ],
                                          ),
                                          UIHelper.verticalSpace(16.h),
                                          Row(
                                            children: [
                                              Container(
                                                width: 90.w,
                                                height: 1.h,
                                                decoration: const BoxDecoration(
                                                    color: AppColors.c919EAB),
                                              ),
                                              UIHelper.horizontalSpace(13.w),
                                              Text(
                                                'FEATURES',
                                                style: TextFontStyle
                                                    .headline8cFFFFFFstylepoppinsW500
                                                    .copyWith(
                                                        color:
                                                            AppColors.c637381,
                                                        fontSize: 10.sp),
                                              ),
                                              UIHelper.horizontalSpace(13.w),
                                              Container(
                                                width: 90.w,
                                                height: 1.h,
                                                decoration: const BoxDecoration(
                                                    color: AppColors.c919EAB),
                                              ),
                                            ],
                                          ),
                                          UIHelper.verticalSpace(12.h),
                                          PlanOffer(
                                            plans: 'Time Tracking – Unlimited',
                                          ),
                                          UIHelper.verticalSpace(8.h),
                                          PlanOffer(
                                            plans:
                                                'Record Storage/History – Unlimited',
                                          ),
                                          UIHelper.verticalSpace(8.h),
                                          PlanOffer(
                                            plans:
                                                'Equipment Usage - Unlimited',
                                          ),
                                          UIHelper.verticalSpace(8.h),
                                          PlanOffer(
                                            plans: 'Paycheck Calculation - Yes',
                                          ),
                                          UIHelper.verticalSpace(8.h),
                                          PlanOffer(
                                            plans:
                                                'Photo & File Uploads – 05GB',
                                          ),
                                          UIHelper.verticalSpace(8.h),
                                          PlanOffer(
                                            plans:
                                                'Notifications & Reminders – Yes',
                                          ),
                                          UIHelper.verticalSpace(8.h),
                                          PlanOffer(
                                            plans: 'Oneline Mode – Yes',
                                          ),
                                          UIHelper.verticalSpace(8.h),
                                          PlanOffer(
                                            plans: 'Expense Tracking - Yes',
                                          ),
                                          UIHelper.verticalSpace(8.h),
                                          PlanOffer(
                                            plans: 'Project Notes – Unlimited',
                                          ),
                                          UIHelper.verticalSpace(8.h),
                                          PlanOffer(
                                            plans:
                                                'Priority Support – Priority Support',
                                          ),
                                          UIHelper.verticalSpace(16.h),
                                          // customeButton(
                                          //   name: 'Select',
                                          //   onCallBack: () {
                                          //     setState(() {
                                          //       selectedSubscription = 0;
                                          //     });
                                          //   },
                                          //   context: context,
                                          // ),
                                          // UIHelper.verticalSpace(16.h)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                UIHelper.verticalSpace(40.h),

                // * Previous code for Purchase Button and Terms/Privacy/Restore
                Consumer<PurchaseProvider>(builder: (context, p, _) {
                  return Column(
                    children: [
                      AuthCustomeButton(
                        name: isLoading
                            ? 'Processing...'
                            : (purchaseProvider.isTrialAvailable
                                ? 'Start 14 Day\'s Trial'.tr
                                : 'Purchase Now'.tr),
                        isLoading: isLoading, // 👈 নতুন প্যারামিটার
                        onCallBack: () async {
                          setState(() => isLoading = true);

                          bool success = false;
                          if (selectedSubscription == 1) {
                            success =
                                await p.purchaseSubscription(type: "monthly");
                          } else {
                            success =
                                await p.purchaseSubscription(type: "yearly");
                          }

                          setState(() => isLoading = false);

                          if (success) {
                            Get.offAll(() => const Loading());
                            ToastUtil.showLongToast(
                              'Subscription successful! You now have access to all premium features',
                            );
                          }
                        },
                        height: 60.h,
                        minWidth: double.infinity,
                        borderRadius: 10.r,
                        color: AppColor.backgroundColors,
                        textStyle: TextFontStyle
                            .headline12c757575styleRobotoW400
                            .copyWith(
                          color: AppColors.c000000,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                        context: context,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Terms of Use
                          InkWell(
                            onTap: () async {
                              const url =
                                  'https://sites.google.com/view/previlliagetimekeeper/terms-and-condition';
                              final uri = Uri.parse(url);

                              if (await canLaunchUrl(uri)) {
                                await launchUrl(
                                  uri,
                                  mode: LaunchMode.externalApplication, // FIXED
                                );
                              }
                            },
                            child: Text(
                              "Terms of Use",
                              style:
                                  TextFontStyle.textStylePoppinsW400.copyWith(
                                color: AppColor.c3988FF,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),

                          if (Platform.isIOS) ...[
                            const SizedBox(width: 5),
                            InkWell(
                              onTap: () async {
                                const url =
                                    'https://www.apple.com/legal/internet-services/itunes/dev/stdeula/';
                                final uri = Uri.parse(url);

                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(
                                    uri,
                                    mode:
                                        LaunchMode.externalApplication, // FIXED
                                  );
                                }
                              },
                              child: Text(
                                "Terms of Use (EULA)",
                                style:
                                    TextFontStyle.textStylePoppinsW400.copyWith(
                                  color: AppColor.c3988FF,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ],

                          const SizedBox(width: 5),
                          Text("||",
                              style:
                                  TextFontStyle.textStylePoppinsW400.copyWith(
                                color: AppColors.c000000,
                                fontSize: 12.sp,
                              )),

                          const SizedBox(width: 5),

                          // Privacy Policy
                          InkWell(
                            onTap: () async {
                              const url =
                                  'https://sites.google.com/view/previlliagetimekeeper/privacy_policy';
                              final uri = Uri.parse(url);

                              if (await canLaunchUrl(uri)) {
                                await launchUrl(
                                  uri,
                                  mode: LaunchMode.externalApplication, // FIXED
                                );
                              }
                            },
                            child: Text(
                              "Privacy Policy",
                              style:
                                  TextFontStyle.textStylePoppinsW400.copyWith(
                                color: AppColor.c3988FF,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),

                          const SizedBox(width: 5),
                          Text("||",
                              style: TextFontStyle
                                  .headline12c757575styleRobotoW400
                                  .copyWith(
                                color: AppColors.c000000,
                              )),

                          const SizedBox(width: 5),

                          // Restore Purchase
                          InkWell(
                            onTap: () {
                              ToastUtil.showLongToast('Restoring purchases...');
                              p.restorePurchases().then((value) {
                                if (value) {
                                  Get.offAll(() => const Loading());
                                  ToastUtil.showLongToast(
                                    'Purchases restored successfully.\nWait few minutes to complete the process.',
                                  );
                                }
                              });
                            },
                            child: Text(
                              "Restore Purchase",
                              style:
                                  TextFontStyle.textStylePoppinsW400.copyWith(
                                color: AppColor.c3988FF,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 100),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
