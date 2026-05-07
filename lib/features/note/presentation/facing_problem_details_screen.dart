// ignore_for_file: must_be_immutable
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lawbug829/common_widget/custom_app_bar.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';

class FacingProblemDetailsScreen extends StatefulWidget {
  dynamic problemId,
      problemDescription,
      problemLocation,
      problemDate,
      problemStatus,
      problemFeedback;

  FacingProblemDetailsScreen({
    super.key,
    required this.problemId,
    required this.problemDescription,
    required this.problemLocation,
    required this.problemDate,
    required this.problemStatus,
    required this.problemFeedback,
  });

  @override
  State<FacingProblemDetailsScreen> createState() =>
      _FacingProblemDetailsScreenState();
}

class _FacingProblemDetailsScreenState
    extends State<FacingProblemDetailsScreen> {
  String _formatDate(dynamic date) {
    try {
      DateTime parsedDate = DateTime.parse(date.toString());
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return date.toString(); // Fallback if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    log("=========> Problem ID: ${widget.problemId}");
    log("=========> Problem Description: ${widget.problemDescription}");
    log("=========> Problem Location: ${widget.problemLocation}");
    log("=========> Problem Date: ${widget.problemDate}");
    log("=========> Problem Status: ${widget.problemStatus}");
    log("=========> Problem Feedback: ${widget.problemFeedback}");

    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Facing Problem Details',
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
      body: Column(
        children: [
          UIHelper.customDivider(color: AppColors.cDFE3E8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                UIHelper.verticalSpace(24.h),

                // * Problem Card
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.cFFF4E9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UIHelper.verticalSpace(16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              Assets.icons.calenderLawbug,
                            ),
                            UIHelper.horizontalSpace(8.w),
                            Text(
                              _formatDate(widget.problemDate),
                              style: TextFontStyle
                                  .headline12c637381stylepoppinsW400,
                            ),
                            const Spacer(),

                            // * Status Container
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: widget.problemStatus == 'pending'
                                    ? Colors.orange
                                    : widget.problemStatus == 'solve'
                                        ? Colors.green
                                        : widget.problemStatus == 'cancel'
                                            ? Colors.red
                                            : AppColors
                                                .c22BB33, // Default color if none match
                              ),
                              child: Text(
                                widget.problemStatus.toString(),
                                style: TextFontStyle
                                    .headline12c637381stylepoppinsW400
                                    .copyWith(
                                  color: AppColors.cFFFFFF,
                                  height: 1.5.h,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                      UIHelper.verticalSpace(16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              Assets.icons.locationOrangeLawbug,
                            ),
                            UIHelper.horizontalSpace(8.w),
                            Text(
                              widget.problemLocation.toString(),
                              style: TextFontStyle
                                  .headline14c212B36stylepoppinsW400
                                  .copyWith(height: 1.57.h),
                            ),
                          ],
                        ),
                      ),
                      UIHelper.verticalSpace(14.h),
                      UIHelper.customDivider(color: AppColors.cFFDCBA),
                      UIHelper.verticalSpace(14.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          widget.problemDescription.toString(),
                          style:
                              TextFontStyle.headline14c919EABstylepoppinsW400,
                        ),
                      ),
                      UIHelper.verticalSpace(24.h)
                    ],
                  ),
                ),
                UIHelper.verticalSpace(24.h),

                // * Feedback Card
                Visibility(
                  visible: widget.problemFeedback != null,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.cFFDCBA,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Admin Feedback',
                          style: TextFontStyle.headline16c212B36stylepoppinsW600
                              .copyWith(
                            height: 1.2.h,
                          ),
                        ),
                        UIHelper.verticalSpace(12.h),
                        Text(
                          widget.problemFeedback.toString(),
                          style:
                              TextFontStyle.headline14c212B36stylepoppinsW400,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
