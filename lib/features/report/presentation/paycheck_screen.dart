import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/common_widget/custom_app_bar.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';

class PaycheckScreen extends StatefulWidget {
  final String? date,
      location,
      totalWorkTime,
      checkIn,
      checkOut,
      employeeId,
      role,
      salary,
      workingTime,
      tax,
      totalSalary,
      employeeID;

  const PaycheckScreen({
    super.key,
    this.date,
    this.location,
    this.totalWorkTime,
    this.checkIn,
    this.checkOut,
    this.employeeId,
    this.role,
    this.salary,
    this.workingTime,
    this.tax,
    this.totalSalary,
    this.employeeID,
  });

  @override
  State<PaycheckScreen> createState() => _PaycheckScreenState();
}

class _PaycheckScreenState extends State<PaycheckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Paycheck',
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
          UIHelper.verticalSpace(24.h),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.cFFF4E9,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: SvgPicture.asset(Assets.icons.calenderLawbug),
                      ),
                      UIHelper.horizontalSpace(4.w),
                      Text(
                        widget.date ?? '',
                        style: TextFontStyle.headline12c637381stylepoppinsW400
                            .copyWith(height: 1.83.h),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(18.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(Assets.icons.locationOrangeLawbug),
                      UIHelper.horizontalSpace(4.w),
                      Flexible(
                        child: Text(
                          widget.location ?? '',
                          maxLines: 4, // Allow up to 3 lines
                          softWrap: true, // Enable text wrapping
                          overflow: TextOverflow
                              .ellipsis, // Handle overflow gracefully
                          style: TextFontStyle.headline14c212B36stylepoppinsW400
                              .copyWith(
                            fontSize: 12, // Adjust font size if needed
                          ),
                        ),
                      ),
                      UIHelper.horizontalSpace(
                          8.w), // Replace Spacer with fixed space
                      Text(
                        widget.totalWorkTime ?? '',
                        style: TextFontStyle.headline12c637381stylepoppinsW400,
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(16.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: SvgPicture.asset(Assets.icons.arrowDownGreen),
                      ),
                      UIHelper.horizontalSpace(4.w),
                      Column(
                        children: [
                          Text(
                            'Check In',
                            style: TextFontStyle
                                .headline16c919EABstylepoppinsW400
                                .copyWith(
                              fontSize: 14.sp,
                              color: AppColors.c22BB33,
                            ),
                          ),
                          UIHelper.verticalSpace(4.h),
                          Text(
                            widget.checkIn ?? '',
                            style: TextFontStyle
                                .headline32c212B36stylepoppinsW700
                                .copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.c454F5B,
                              height: 1.83.h,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: SvgPicture.asset(Assets.icons.arrowUpRed),
                      ),
                      UIHelper.horizontalSpace(4.w),
                      Column(
                        children: [
                          Text(
                            'Check Out',
                            style: TextFontStyle
                                .headline16c919EABstylepoppinsW400
                                .copyWith(
                              fontSize: 14.sp,
                              color: AppColors.cFF4842,
                            ),
                          ),
                          UIHelper.verticalSpace(4.h),
                          Text(
                            widget.checkOut ?? '',
                            style: TextFontStyle
                                .headline32c212B36stylepoppinsW700
                                .copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.c454F5B,
                              height: 1.83.h,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(12.h),
                  UIHelper.customDivider(color: AppColors.cFFDCBA),
                  UIHelper.verticalSpace(16.h),

                  // Info rows (preserved as-is)
                  _buildInfoRow('Employee ID', widget.employeeID ?? '', 12.w),
                  UIHelper.verticalSpace(8.h),
                  _buildInfoRow('Role', widget.role ?? '', 71.w),
                  UIHelper.verticalSpace(8.h),
                  _buildInfoRow('Salary', widget.salary ?? '', 59.w),
                  UIHelper.verticalSpace(8.h),
                  _buildInfoRow(
                      'Working Time', widget.totalWorkTime ?? '', 9.w),
                  UIHelper.verticalSpace(8.h),
                  _buildInfoRow('Tax', widget.tax.toString(), 83.w),
                  UIHelper.verticalSpace(12.h),
                  UIHelper.customDivider(color: AppColors.cC4CDD5),
                  UIHelper.verticalSpace(9.h),

                  Row(
                    children: [
                      Text(
                        'Total Salary',
                        style: TextFontStyle.headline14c637381stylepoppinsW500
                            .copyWith(
                          color: AppColors.c212B36,
                        ),
                      ),
                      UIHelper.horizontalSpace(27.w),
                      Text(
                        ':',
                        style: TextFontStyle.headline14c212B36stylepoppinsW400,
                      ),
                      UIHelper.horizontalSpace(8.w),
                      Text(
                        widget.totalSalary ?? '',
                        style: TextFontStyle.headline14c22BB33stylepoppinsW700,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, double spacing) {
    return Row(
      children: [
        Text(
          label,
          style: TextFontStyle.headline14c637381stylepoppinsW500,
        ),
        UIHelper.horizontalSpace(spacing),
        Text(
          ':',
          style: TextFontStyle.headline14c212B36stylepoppinsW400,
        ),
        UIHelper.horizontalSpace(8.w),
        Text(
          value,
          style: TextFontStyle.headline14c637381stylepoppinsW500.copyWith(
            color: AppColors.c212B36,
          ),
        ),
      ],
    );
  }
}
