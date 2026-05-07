import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/common_widget/custom_app_bar.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';

class ExpanseDetailsReport extends StatefulWidget {
  final String ammount,
      date,
      location,
      category,
      paymentMethod,
      attachment,
      note;
  const ExpanseDetailsReport({
    super.key,
    required this.ammount,
    required this.date,
    required this.location,
    required this.category,
    required this.paymentMethod,
    required this.attachment,
    required this.note,
  });

  @override
  State<ExpanseDetailsReport> createState() => _ExpanseDetailsReportState();
}

class _ExpanseDetailsReportState extends State<ExpanseDetailsReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Expense Money',
          style: TextFontStyle.headline20c212B36stylepoppinsW500,
        ),
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
            padding: const EdgeInsets.all(
              20,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.cFFF4E9,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(Assets.icons.calenderLawbug),
                          UIHelper.horizontalSpace(8.w),
                          Text(
                            widget.date,
                            style: TextFontStyle
                                .headline12c637381stylepoppinsW400
                                .copyWith(
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(16.h),
                      Row(
                        children: [
                          SvgPicture.asset(Assets.icons.locationOrangeLawbug),
                          UIHelper.horizontalSpace(8.w),
                          Text(
                            widget.location,
                            style: TextFontStyle
                                .headline12c637381stylepoppinsW400
                                .copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: AppColors.cFF8E21,
                        thickness: 1.h,
                        height: 32.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'Amount Spent:-',
                            style: TextFontStyle
                                .headline12c637381stylepoppinsW400
                                .copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                          UIHelper.horizontalSpace(8.w),
                          Text(
                            widget.ammount,
                            style: TextFontStyle
                                .headline12c637381stylepoppinsW400
                                .copyWith(
                              fontSize: 14.sp,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(10.h),
                      Row(
                        children: [
                          Text(
                            'Expense Category:-',
                            style: TextFontStyle
                                .headline12c637381stylepoppinsW400
                                .copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                          UIHelper.horizontalSpace(8.w),
                          Text(
                            widget.category,
                            style: TextFontStyle
                                .headline12c637381stylepoppinsW400
                                .copyWith(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(10.h),
                      Row(
                        children: [
                          Text(
                            'Payment Method:-',
                            style: TextFontStyle
                                .headline12c637381stylepoppinsW400
                                .copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                          UIHelper.horizontalSpace(8.w),
                          Text(
                            widget.paymentMethod,
                            style: TextFontStyle
                                .headline12c637381stylepoppinsW400
                                .copyWith(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(10.h),
                      Row(
                        children: [
                          Text(
                            'Attach Report:-',
                            style: TextFontStyle
                                .headline12c637381stylepoppinsW400
                                .copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                          UIHelper.horizontalSpace(8.w),
                          SvgPicture.asset(Assets.icons.attachLawbug),
                        ],
                      ),
                      UIHelper.verticalSpace(25.h),
                      Row(
                        children: [
                          Text(
                            'Notes',
                            style: TextFontStyle
                                .headline12c637381stylepoppinsW400
                                .copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                          UIHelper.horizontalSpace(8.w),
                          Text(
                            'or Description',
                            style: TextFontStyle
                                .headline12c637381stylepoppinsW400
                                .copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.note,
                              style: TextFontStyle
                                  .headline12c637381stylepoppinsW400
                                  .copyWith(
                                fontSize: 14.sp,
                              ),
                              maxLines: 50,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // child: Container(
      //   padding: EdgeInsets.all(16.w),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(8.r),
      //   ),
      //   child: Column(
      //     children: [],
      //   ),
      // ),
    );
  }
}
