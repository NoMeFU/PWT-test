// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/ui_helpers.dart';

class Helpsupportfaq extends StatelessWidget {
   Helpsupportfaq({super.key});

  List<String> datas = [
    "What is the ?",
    "What is the ?",
    "What is the ?",
    "What is the ?",
    "What is the ?",
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [

              UIHelper.verticalSpace(24.h),

              Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Color(0xFFFBFBFB),
                  border: Border.all(color: Color(0xFFF2F2F2)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search....',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Image.asset(
                      Assets.images.helpRightSearch.path, height: 24, width: 24,
                    ),
                  ],
                ),
              ),

              UIHelper.verticalSpace(16.h),


              Expanded(child: ListView.builder(
                  itemCount:  datas.length,
                  itemBuilder: (context, index) {

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        height: 40.h, width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Color(0xffF4F4F6),width: 2
                            )
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(datas[index], style: TextFontStyle.text14c011510OutfitRegular.copyWith(
                                    color: AppColors.c212B36, fontSize: 16, fontWeight: FontWeight.w500
                                ),),
                                Image.asset(Assets.images.helpRightArrow.path, height: 32, width: 32,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );

                  }),)
            ],
          ),
        ),
      ),
    );
  }
}