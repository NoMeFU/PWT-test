import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawbug829/helpers/di.dart';
import 'package:lawbug829/helpers/helper_methods.dart';
import 'package:lawbug829/networks/dio/dio.dart';
import '../../../../gen/colors.gen.dart';

import '../constants/app_constants.dart';

final class PopupWidget extends StatefulWidget {
  const PopupWidget({super.key, required this.language});
  final TextEditingController language;

  @override
  State<PopupWidget> createState() => _PopupWidgetState();
}

class _PopupWidgetState extends State<PopupWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        popUpGlobalkey.currentState!.showButtonMenu();
      },
      child: Container(
        color: AppColors.cFFFFFF,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Text(language(appData.read(kKeyLanguage)),
            //     style: TextFontStyle.headline16StyleMontserrat.copyWith(color: AppColors.c000000)),
            const Spacer(),
            PopupMenuButton<String>(
              key: popUpGlobalkey,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black,
                size: 20.sp,
              ),
              iconSize: (ScreenUtil().screenWidth > 600) ? 25.r : 14.r,
              onSelected: (String value) {
                setState(() {
                  appData.write(kKeyLanguage, value);
                  appData.write(kKeyLanguageCode, value);
                  appData.write(kKeyCountryCode, countriesCode[value]);
                });
                var locale = Locale(value, countriesCode[value]);
                DioSingleton.instance.updateLanguage(value);
                Get.updateLocale(locale);
              },
              color: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              offset: const Offset(-100, kToolbarHeight),
              itemBuilder: (context) {
                return kLanguagesKey
                    .map((String value) => PopupMenuItem<String>(
                          value: value,
                          child: Text(languages[value]),
                        ))
                    .toList();
              },
            ),
          ],
        ),
      ),
    );
  }
}
