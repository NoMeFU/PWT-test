import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/common_widget/custom_app_bar.dart';
import 'package:lawbug829/features/profile/widget/helpSupportContactUs.dart';
import 'package:lawbug829/features/profile/widget/helpSupportFaq.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../helpers/ui_helpers.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreen();
}

class _HelpSupportScreen extends State<HelpSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text('Help & Support',
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TabBar(
                    labelColor: AppColors.cFF8E21,
                      unselectedLabelColor: AppColors.c919EAB,
                      indicatorColor: AppColors.cFF8E21,
                      labelStyle: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                        fontWeight: FontWeight.w600, fontSize: 16
                      ),
                      tabs: const [
                    Tab(
                      text: "FAQ",
                    ),
                    Tab(
                      text: "Contact Us",
                    )
                  ]
                  ),
                ],
              ),
            ),


            Expanded(child: TabBarView(children: [
              Helpsupportfaq(),
              const Helpsupportcontactus(),
            ]))

          ],
        ),
      ),
    );
  }
}
