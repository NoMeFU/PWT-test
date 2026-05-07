import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lawbug829/assets_healper/app_lottie.dart';
import 'package:lawbug829/common_widget/custom_app_bar.dart';
import 'package:lawbug829/networks/api_acess.dart';
import 'package:lottie/lottie.dart';

import '../../../../common_widget/custom_button.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../helpers/ui_helpers.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreen();
}

class _AddReviewScreen extends State<AddReviewScreen> {
  double _rating = 4;
  final TextEditingController _reviewController = TextEditingController();
  bool isLoading = false;

  String getRatingText(double rating) {
    switch (rating.round()) {
      case 1:
        return "1 - Poor";
      case 2:
        return "2 - Fair";
      case 3:
        return "3 - Average";
      case 4:
        return "4 - Good";
      case 5:
        return "5 - Excellent";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Write a review',
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
          children: [
            Divider(
              thickness: 1.w,
              color: AppColors.cDFE3E8,
            ),
            UIHelper.verticalSpace(20.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 226.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.cFF8E21, width: 1)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UIHelper.verticalSpace(16.h),
                        Text(
                          "My Service Was Excellent",
                          style: TextFontStyle.arabic16c161C24StyleMeQuran
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.c212B36,
                                  fontSize: 20),
                        ),
                        UIHelper.verticalSpace(22.h),
                        RatingBar.builder(
                          initialRating: _rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              _rating = rating;
                            });
                          },
                        ),
                        UIHelper.verticalSpace(16.h),
                        Text(
                          getRatingText(_rating),
                          style: TextFontStyle.arabic16c161C24StyleMeQuran
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.c172B4D,
                                  fontSize: 16),
                        ),
                        UIHelper.verticalSpace(23.h),
                        Text(
                          "How Would You Rate The Experience And Service ?",
                          style: TextFontStyle.arabic16c161C24StyleMeQuran
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.c172B4D,
                                  fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(16.h),

                  // * ============= Write Your Feedback ==========================
                  Text(
                    "Write Your Feedback",
                    style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.c212B36),
                  ),
                  UIHelper.verticalSpace(10.h),
                  Container(
                    height: 200.h, width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.cFFF4E9,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.cFF8E21, width: 1)),
                    padding: const EdgeInsets.all(16), // Padding from all sides
                    child: TextField(
                      controller: _reviewController,
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your review here...',
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(84.h),

                  isLoading // If the loading state is true, show loading
                      ? Container(
                          height: 56,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.cFFFFFF,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.cFF8E21,
                              width: 2,
                            ),
                          ),
                          child: Lottie.asset(
                            AppLottie.loading,
                            height: 100,
                            width: 100,
                          ),
                        )
                      : customeButton(
                          name: 'Submit Review',
                          context: context,
                          onCallBack: () async {
                            setState(() {
                              isLoading = true; // Start loading
                            });
                            // * Log the review details
                            log("===========> Review: $_rating");
                            log("===========> Feedback: ${"Enter your review here..."}");

                            bool isSuccess = await postRatingApiRX.postRatingRX(
                              rating: _rating,
                              review: _reviewController.text.trim(),
                            );

                            if (isSuccess) {
                              setState(() {
                                isLoading = false; // Start loading
                              });
                              // Show GetX snackbar on top
                              Get.snackbar(
                                'Success',
                                'Review Send successfully.',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                duration: const Duration(seconds: 3),
                                margin: const EdgeInsets.all(10),
                                borderRadius: 10,
                              );
                              NavigationService.goBack();
                            } else {
                              setState(() {
                                isLoading = false; // Start loading
                              });
                              // Show default snackbar on bottom for error
                              Get.snackbar(
                                'Failed',
                                'Review Send failed.',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                duration: const Duration(seconds: 3),
                                margin: const EdgeInsets.all(10),
                                borderRadius: 10,
                              );
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
