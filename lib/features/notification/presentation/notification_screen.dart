import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/common_widget/custom_app_bar.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/features/notification/model/notification_model.dart';
import 'package:lawbug829/features/notification/widgets/notification_data.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';

// Import your NotificationData and NotificationModel here

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Notification list
  List<NotificationModel> notifications = [];

  @override
  void initState() {
    super.initState();

    // Simulate loading notifications after delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        notifications = [
          NotificationModel(
            imagePath: Assets.images.userLawbug.path,
            message: 'Samantha has shared a file with you',
            timeAgo: '14h ago',
          ),
          NotificationModel(
            imagePath: Assets.images.userLawbug.path,
            message: 'Your report is ready to download',
            timeAgo: '2d ago',
          ),
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Notification',
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
      body: notifications.isEmpty
          ? buildEmptyNotification()
          : NotificationData(notifications: notifications),
    );
  }

  // Empty Notifications UI
  Widget buildEmptyNotification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          thickness: 1.w,
          color: AppColors.cDFE3E8,
        ),
        UIHelper.verticalSpace(194.h),
        Center(
          child: Image.asset(
            Assets.images.zeroNotification.path,
            width: 90.w,
          ),
        ),
        UIHelper.verticalSpace(32.h),
        Center(
          child: Text(
            'No Notifications!',
            style: TextFontStyle.headline20c212B36stylepoppinsW500
                .copyWith(fontSize: 24.sp, height: 1.5.h),
          ),
        ),
        UIHelper.verticalSpace(4.h),
        Center(
          child: Text(
            'You don’t have any notification yet. Please place order',
            style: TextFontStyle.headline16c919EABstylepoppinsW400.copyWith(
              height: 1.5.h,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
