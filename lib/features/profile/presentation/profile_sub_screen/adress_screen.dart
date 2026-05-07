import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawbug829/common_widget/custom_app_bar.dart';

import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../helpers/ui_helpers.dart';

class AdressScreen extends StatefulWidget {
  const AdressScreen({super.key});

  @override
  State<AdressScreen> createState() => _AdressScreen();
}

class _AdressScreen extends State<AdressScreen> {
  // Selected index tracker
  int selectedIndex = 0;

  List<Map<String, dynamic>> addresses = [
    {
      'mainAddress': 'Madhapur, Hyderabad',
      'subAddress': 'Plot no.209, Kavuri Hills, Madhapur, Telangana 500033',
    },
    {
      'mainAddress': 'Banjara Hills, Hyderabad',
      'subAddress': 'Plot no.101, Road no.12, Banjara Hills, Telangana 500034',
    },
  ];

  var selectedIcon = Assets.images.addressSelectedCircle.path;
  var nonSelectedIcon = Assets.images.addressUnselectCircle.path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Address',
          style: TextFontStyle.headline20c212B36stylepoppinsW500,
        ),
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
          UIHelper.verticalSpace(22.h),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  var data = addresses[index];
                  bool isSelected = index == selectedIndex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          width: 2,
                          color: const Color(0xffE7F0FD),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            isSelected ? selectedIcon : nonSelectedIcon,
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['mainAddress'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  data['subAddress'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {

                            },
                            child: Image.asset(
                              Assets.images.addressRightPencil.path,
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ],
                      ),
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
