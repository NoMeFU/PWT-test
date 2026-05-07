import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/features/notification/model/notification_model.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';

// Your NotificationModel
class NotificationData extends StatefulWidget {
  final List<NotificationModel> notifications;

  const NotificationData({super.key, required this.notifications});

  @override
  State<NotificationData> createState() => _NotificationDataState();
}

class _NotificationDataState extends State<NotificationData> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 16.h),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: widget.notifications.length,
      separatorBuilder: (context, index) => Divider(
        thickness: 1.w,
        color: AppColors.cDFE3E8,
      ),
      itemBuilder: (context, index) {
        final notification = widget.notifications[index];
        return Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 8.h, bottom: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                notification.imagePath,
                width: 48.w,
              ),
              UIHelper.horizontalSpace(12.w),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        notification.message,
                        style: TextFontStyle.headline20c212B36stylepoppinsW500
                            .copyWith(fontSize: 12.sp, color: AppColors.c172B4D),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    UIHelper.horizontalSpace(8.w),
                    Column(
                      children: [
                        Text(
                          notification.timeAgo,
                          style: TextFontStyle.headline16c919EABstylepoppinsW400
                              .copyWith(fontSize: 12.sp, color: AppColors.c637381),
                        ),
                        UIHelper.verticalSpace(2.h),
                        SvgPicture.asset(
                          Assets.icons.threeDot,
                          height: 16.h,
                          width: 16.w,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
