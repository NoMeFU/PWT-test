import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/assets_healper/app_image.dart';
import 'package:lawbug829/assets_healper/app_lottie.dart';
import 'package:lawbug829/features/profile/model/profile_model.dart';
import 'package:lawbug829/features/profile/widget/profile_list_widget.dart';
import 'package:lawbug829/features/subscription/model/subscription_check_model.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/networks/api_acess.dart';
import 'package:lottie/lottie.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/navigation_service.dart';
import '../../../helpers/ui_helpers.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    getProfileRXObj.profile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GestureDetector(
              onTap: () {
                NavigationService.navigateTo(Routes.settingScreen);
              },
              child: Image.asset(
                Assets.images.profileSettingsIcon.path,
                height: 24.h,
                width: 24.h,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              StreamBuilder<ProfileModel>(
                  stream: getProfileRXObj.getProfileRX,
                  builder: (context, snapshot) {
                    var profileImage = snapshot.data?.data?.avatar;
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: (profileImage != null && profileImage.isNotEmpty)
                          ? CachedNetworkImage(
                              imageUrl: profileImage,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.asset(
                                Appimages.profileImage,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                Appimages.profileImage,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.asset(
                              Appimages.profileImage,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                    );
                  }),
              UIHelper.verticalSpace(13.h),
              StreamBuilder<ProfileModel>(
                  stream: getProfileRXObj.getProfileRX,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Lottie.asset(
                          AppLottie.loading,
                          width: 100.w,
                          height: 100.h,
                        ),
                      );
                    } else if (snapshot.hasData) {
                      var profileData = snapshot.data;
                      return Column(
                        children: [
                          Text(
                            profileData?.data?.employeeId ?? "Employee ID",
                            style: TextFontStyle
                                .headline14c22BB33stylepoppinsW700
                                .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.c637381),
                          ),
                          UIHelper.verticalSpace(3.h),
                          Text(
                            profileData?.data?.name ?? "User Name",
                            style: TextFontStyle
                                .headline14c22BB33stylepoppinsW700
                                .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.c172B4D),
                          ),
                        ],
                      );
                    } else {
                      const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.c172B4D,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
              UIHelper.verticalSpace(25.h),
              // * Premium Plan Card
              StreamBuilder<CheckSubscription>(
                  stream: getSubscriptionCheckRXObj.dataFetcher,
                  builder: (context, snapshot) {
                    final isSubscribe = snapshot.data?.data;

                    return Container(
                      padding: EdgeInsets.all(16.w),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFFC8C20),
                            Color(0xFFFFC083),
                          ],
                          stops: [
                            0.2419,
                            1.6129
                          ], // Based on your given percentages
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                Assets.images.profileStars.path,
                                height: 60.h,
                                width: 60.w,
                              ),
                              UIHelper.horizontalSpace(12.w),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Premium Plan",
                                        style: TextFontStyle
                                            .headline14c22BB33stylepoppinsW700
                                            .copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.cFFFFFF)),
                                    UIHelper.verticalSpace(8.h),
                                    Text(
                                      isSubscribe != null &&
                                              isSubscribe.isSubscribed == true
                                          ? "You are a premium user."
                                          : "Premium plan available \nGet all it's premium features.",
                                      style: TextFontStyle
                                          .headline14c22BB33stylepoppinsW700
                                          .copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.cFFFFFF,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          UIHelper.verticalSpace(2.h),

                          /// ========== Upgrade now button design ======
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  NavigationService.navigateTo(
                                    Routes.subscriptionScreen,
                                  );
                                },
                                child: Container(
                                  height: 34.h,
                                  width: 96.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFFFFFFFF), // White
                                        Color(0xFF732929), // Deep Red
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xFFFC8C20),
                                            Color(0xFFFFC083),
                                          ],
                                          stops: [
                                            0.2419,
                                            1.6129
                                          ], // Based on your given percentages
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          50,
                                        ),
                                      ),
                                      height: 31.h,
                                      width: 93.w,
                                      child: Center(
                                        child: Text(
                                          "Upgrade Now",
                                          style: TextFontStyle
                                              .arabic16c161C24StyleMeQuran
                                              .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.cFFFFFF,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
              UIHelper.verticalSpace(24.h),
              // * Profile Item Screen
              const ProfileListWidget(),
              UIHelper.verticalSpace(30.h),
            ],
          ),
        ),
      ),
    );
  }
}
