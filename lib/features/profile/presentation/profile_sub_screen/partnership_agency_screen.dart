import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/common_widget/custom_app_bar.dart';

import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../helpers/ui_helpers.dart';

class PartnershipAgencyScreen extends StatefulWidget {
  const PartnershipAgencyScreen({super.key});

  @override
  State<PartnershipAgencyScreen> createState() => _PartnershipAgencyScreenState();
}

class _PartnershipAgencyScreenState extends State<PartnershipAgencyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Partnership Agency',
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

      body: Column(
        children: [
          Divider(
            thickness: 1.w,
            color: AppColors.cDFE3E8,
          ),
          UIHelper.verticalSpace(16.h),

          Column(
            children: [

            ],
          )
        ],
      ),
    );
  }
}
