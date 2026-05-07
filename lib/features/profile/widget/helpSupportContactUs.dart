import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';

import '../../../gen/assets.gen.dart';

class Helpsupportcontactus extends StatelessWidget {
  const Helpsupportcontactus({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [

          UIHelper.verticalSpace(16.h),
          Container(
            height: 50.h, width: double.infinity,
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
                  children: [
                    Image.asset(Assets.images.helpHeadphone.path, height: 32, width: 32,),
                    UIHelper.horizontalSpace(16.w),
                    Text("Customer Service", style: TextFontStyle.text14c011510OutfitRegular.copyWith(
                      color: AppColors.c212B36, fontSize: 16, fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
              ),
            ),
          ),


          UIHelper.verticalSpace(16.h),
          Container(
            height: 50.h, width: double.infinity,
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
                  children: [
                    Image.asset(Assets.images.helpWhatsapp.path, height: 32, width: 32,),
                    UIHelper.horizontalSpace(16.w),
                    Text("Whatsapp", style: TextFontStyle.text14c011510OutfitRegular.copyWith(
                        color: AppColors.c212B36, fontSize: 16, fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
              ),
            ),
          ),


          UIHelper.verticalSpace(16.h),
          Container(
            height: 50.h, width: double.infinity,
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
                  children: [
                    Image.asset(Assets.images.helpFb.path, height: 32, width: 32,),
                    UIHelper.horizontalSpace(16.w),
                    Text("Facebook", style: TextFontStyle.text14c011510OutfitRegular.copyWith(
                        color: AppColors.c212B36, fontSize: 16, fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
              ),
            ),
          ),


          UIHelper.verticalSpace(16.h),
          Container(
            height: 50.h, width: double.infinity,
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
                  children: [
                    Image.asset(Assets.images.helpTwiter.path, height: 32, width: 32,),
                    UIHelper.horizontalSpace(16.w),
                    Text("Twitter", style: TextFontStyle.text14c011510OutfitRegular.copyWith(
                        color: AppColors.c212B36, fontSize: 16, fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
              ),
            ),
          ),


        ],

      ),
    );
  }
}