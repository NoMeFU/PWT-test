import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/common_widget/custom_button.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/features/onboarding/widgets/carousel_icon_widget.dart';
import 'package:lawbug829/features/onboarding/widgets/line_indicator_widget.dart';
import 'package:lawbug829/features/onboarding/widgets/onboarding_content_widget.dart';
import 'package:lawbug829/features/onboarding/widgets/skip_button.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _contentData = [
    {
      "title": "Time Tracking",
      "subtitle":
          "Browse and book a wide range services plumbing and electrical to appliance repair. We've got it all covered",
      "image": Assets.images.timeTrackingLawbug.path,
      "imageWidth": 280.w,
      
    },
    {
      "title": "Equipment Tracking",
      "subtitle":
          "Browse and book a wide range services plumbing and electrical to appliance repair. We've got it all covered",
      "image": Assets.images.equipmentTracking.path,
       "imageWidth": 320.w,
    },
    {
      "title": "Tracks workers",
      "subtitle":
          "Browse and book a wide range services plumbing and electrical to appliance repair. We've got it all covered",
      "image": Assets.images.trackWorkerLawbug.path,
       "imageWidth": 300.w,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(28.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 21.w),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SkipButton(),
                  ],
                ),
              ),
              UIHelper.verticalSpace(33.h),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: OnboardingContentWidget(
                  key: ValueKey<int>(_currentIndex),
                  title: _contentData[_currentIndex]['title']!,
                  subtitle: _contentData[_currentIndex]['subtitle']!,
                  imagePath: _contentData[_currentIndex]['image']!,
                  imageWidth: _contentData[_currentIndex]['imageWidth'] as double,
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LineIndicatorWidget(
                      isActive: _currentIndex == 0,
                      activewidth: 24.w,
                      inactivewidth: 6.w,
                      height: 4.0,
                      activeColor: AppColors.cE69F6C,
                      inactiveColor: AppColors.cEEDDD0,
                      activeborderRadius: 10.r,
                      inactiveborderRadius: 100.r,
                    ),
                    UIHelper.horizontalSpace(6.w),
                    LineIndicatorWidget(
                      isActive: _currentIndex == 1,
                      activewidth: 24.w,
                      inactivewidth: 6.w,
                      height: 4.0,
                      activeColor: AppColors.cFF8E21,
                      inactiveColor: AppColors.cFFDCBA,
                      activeborderRadius: 10.r,
                      inactiveborderRadius: 100.r,
                    ),
                    UIHelper.horizontalSpace(6.w),
                    LineIndicatorWidget(
                      isActive: _currentIndex == 2,
                      activewidth: 24.w,
                      inactivewidth: 6.w,
                      height: 4.0,
                      activeColor: AppColors.cFF8E21,
                      inactiveColor: AppColors.cFFDCBA,
                      activeborderRadius: 10.r,
                      inactiveborderRadius: 100.r,
                    ),
                  ],
                ),
              ),
              if (_currentIndex != 2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 29.h, horizontal: 20.w),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = (_currentIndex + 1).clamp(0, 2);
                          });
                        },
                        child: const CarouselIconWidget(),
                      ),
                    ),
                  ],
                ),
              if (_currentIndex == 2)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 29.h),
                  child: customeButton(
                    name: 'Get Started',
                    borderRadius: 8.r,
                    color: AppColors.cFF8E21,
                    height: 56.h,
                    minWidth: 334.w,
                    context: context,
                    onCallBack: () {
                      //appData.write(kKeyIsFirstTime, false);
                      NavigationService.navigateTo(Routes.locationAccessScreen);
                    },
                    textStyle: TextFontStyle.headline16c919EABstylepoppinsW400
                        .copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.cFCFCFC,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
