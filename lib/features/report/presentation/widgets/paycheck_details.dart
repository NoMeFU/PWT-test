import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/features/report/model/paycheck_model.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';


class PaycheckDetails extends StatelessWidget {
  final PaycheckModel data;

  const PaycheckDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return 
    
    Container(
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
                data.date,
                style: TextFontStyle.headline12c637381stylepoppinsW400.copyWith(height: 1.83.h),
              ),
            ],
          ),
          UIHelper.verticalSpace(18.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(Assets.icons.locationOrangeLawbug),
              UIHelper.horizontalSpace(4.w),
              Text(
                data.location,
                style: TextFontStyle.headline14c212B36stylepoppinsW400,
              ),
              const Spacer(),
              Text(
                data.totalWorkTime,
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
                    style: TextFontStyle.headline16c919EABstylepoppinsW400.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.c22BB33,
                    ),
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    data.checkIn,
                    style: TextFontStyle.headline32c212B36stylepoppinsW700.copyWith(
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
                    style: TextFontStyle.headline16c919EABstylepoppinsW400.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.cFF4842,
                    ),
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    data.checkOut,
                    style: TextFontStyle.headline32c212B36stylepoppinsW700.copyWith(
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
          _buildInfoRow('Employee ID', data.employeeId, 12.w),
          UIHelper.verticalSpace(8.h),
          _buildInfoRow('Role', data.role, 71.w),
          UIHelper.verticalSpace(8.h),
          _buildInfoRow('Salary', data.salary, 59.w),
          UIHelper.verticalSpace(8.h),
          _buildInfoRow('Working Time', data.workingTime, 9.w),
          UIHelper.verticalSpace(8.h),
          _buildInfoRow('Tax', data.tax, 83.w),
          UIHelper.verticalSpace(12.h),
          UIHelper.customDivider(color: AppColors.cC4CDD5),
          UIHelper.verticalSpace(9.h),

          Row(
            children: [
              Text(
                'Total Salary',
                style: TextFontStyle.headline14c637381stylepoppinsW500.copyWith(
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
                data.totalSalary,
                style: TextFontStyle.headline14c22BB33stylepoppinsW700,
              ),
            ],
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
