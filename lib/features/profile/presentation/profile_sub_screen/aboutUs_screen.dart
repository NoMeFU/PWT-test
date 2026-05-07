import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common_widget/custom_app_bar.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../helpers/ui_helpers.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreen();
}

class _AboutUsScreen extends State<AboutUsScreen> {

  List<String> abouts = [
    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('About Us',
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

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                itemCount: abouts.length,
                separatorBuilder: (_, __) => UIHelper.verticalSpace(12.h),
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text((index+1).toString()+"."),
                        UIHelper.horizontalSpace(3.w),
                        Expanded(
                            child: Text(abouts[index], softWrap: true, style: TextFontStyle.arabic16c161C24StyleMeQuran.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.c212B36
                            ),
                            )
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

    );
  }
}
