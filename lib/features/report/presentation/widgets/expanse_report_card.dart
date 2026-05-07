import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';

class ExpanseReportCard extends StatelessWidget {
  final String? iconPath;
  final String? text,
      date,
      expenseMoney,
      location,
      category,
      paymentMethod,
      attachment,
      note;
  final VoidCallback? onTap;
  const ExpanseReportCard({
    super.key,
    this.iconPath,
    this.text,
    this.onTap,
    this.date,
    this.expenseMoney,
    this.location,
    this.category,
    this.paymentMethod,
    this.attachment,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.cFFF4E9,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(Assets.icons.calenderLawbug),
              UIHelper.horizontalSpace(8.w),
              Text(
                date ?? 'N/A',
                style: TextFontStyle.headline12c637381stylepoppinsW400
                    .copyWith(height: 1.83.h),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  NavigationService.navigateToWithArgs(
                      Routes.expenseDetailsScreen, {
                    'ammount': expenseMoney,
                    'date': date,
                    'location': location,
                    'category': category,
                    'paymentMethod': paymentMethod,
                    'attachment': attachment,
                    'note': note,
                  });
                },
                child: Text(
                  'View Update',
                  style: TextFontStyle.headline14cFF8E21stylepoppinsW600,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(16.h),
          Row(
            children: [
              Text(
                'Expense:',
                style: TextFontStyle.headline14cFF8E21stylepoppinsW600.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.c637381),
              ),
              UIHelper.horizontalSpace(8.w),
              Text(
                expenseMoney ?? 'N/A',
                style: TextFontStyle.headline14cFF8E21stylepoppinsW600.copyWith(
                  color: const Color(0xFFFF4842),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.50,
                ),
              )
            ],
          ),
          UIHelper.verticalSpace(16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(Assets.icons.locationOrangeLawbug),
              UIHelper.horizontalSpace(4.w),
              Expanded(
                child: Text(
                  location ?? 'N/A',
                  style: TextFontStyle.headline14c212B36stylepoppinsW400
                      .copyWith(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
