import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/common_widget/custom_app_bar.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/features/note/model/get_daily_model.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:lawbug829/networks/api_acess.dart';

class UpdateDetailsScreen extends StatefulWidget {
  final dynamic id, location, hours;
  final List<DescriptionDataModelsssss> data;

  const UpdateDetailsScreen({
    super.key,
    this.id,
    this.location,
    this.hours,
    required this.data,
  });

  @override
  State<UpdateDetailsScreen> createState() => _UpdateDetailsState();
}

class _UpdateDetailsState extends State<UpdateDetailsScreen> {
  @override
  void initState() {
    super.initState();
    getDailyUpdateDetailsApiRXObj.getDailyUpdateDetailsRx(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    log("==============> daily update id:- ${widget.id}");

    return widget.data ==[]? Center(child: Text("index is null",style: TextStyle(color: Colors.white),),) :Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Update Details',
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
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelper.customDivider(color: AppColors.cDFE3E8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  UIHelper.verticalSpace(24.h),
                  Container(
                    padding: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.cFFF4E9),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 2.h),
                              child: SvgPicture.asset(
                                Assets.icons.calenderLawbug,
                              ),
                            ),
                            UIHelper.horizontalSpace(4.w),
                            Text(
                              '12/04/2025',
                              style: TextFontStyle
                                  .headline12c637381stylepoppinsW400
                                  .copyWith(height: 1.83.h),
                            ),
                            const Spacer(),
                            Text(
                              widget.hours != null
                                  ? '${widget.hours} hours'
                                  : '0 hours',
                              style: TextFontStyle
                                  .headline12c637381stylepoppinsW400,
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              Assets.icons.locationOrangeLawbug,
                            ),
                            UIHelper.horizontalSpace(4.w),
                            Text(
                              widget.location,
                              style: TextFontStyle
                                  .headline14c212B36stylepoppinsW400,
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(12.h)
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(24.h),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final description = widget.data[index].description ?? [];
                      final textEditingController =
                          TextEditingController(text: description.toString());
                      return Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 4.w,
                                height: 20.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  color: AppColors.cFF8E21,
                                ),
                              ),
                              UIHelper.horizontalSpace(10.w),
                              // Text(
                              //   // 'Task ${detailsData[index].id.toString()}',
                              //   style: TextFontStyle
                              //       .headline20c212B36stylepoppinsW500
                              //       .copyWith(
                              //       fontSize: 16.sp,
                              //       height: 1.5.h),
                              // ),
                            ],
                          ),
                          UIHelper.verticalSpace(10.h),
                          TextFormField(
                            controller: textEditingController,
                            cursorColor: AppColors.cFF8E21,
                            cursorRadius: Radius.circular(8.r),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: const BorderSide(
                                  color: AppColors.cFF8E21,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: const BorderSide(
                                  color: AppColors.cFF8E21,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: const BorderSide(
                                  color: AppColors.cFF8E21,
                                ),
                              ),
                              fillColor: AppColors.cFFF4E9,
                              filled: true,
                              contentPadding: EdgeInsets.all(16.w),
                            ),
                            minLines: 5,
                            maxLines: 5,
                          ),
                          UIHelper.verticalSpace(16.h),
                        ],
                      );
                    },
                  ),
                  UIHelper.verticalSpace(16.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
