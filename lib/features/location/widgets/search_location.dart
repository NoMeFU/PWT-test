import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/features/location/model/location_suggestion.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({super.key});

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  final List<LocationSuggestion> suggestions = [
    LocationSuggestion(primaryLocation: 'New York City, USA', secondaryLocation: 'Menlo Park, California'),
    LocationSuggestion(primaryLocation: 'Amsterdam, Netherlands', secondaryLocation: 'Menlo Park, California'),
    LocationSuggestion(primaryLocation: 'Sudney, Australia', secondaryLocation: 'Menlo Park, California'),
    LocationSuggestion(primaryLocation: 'Bangkok, Thailand', secondaryLocation: 'Menlo Park, California'),
    LocationSuggestion(primaryLocation: 'Tokyo, Japan', secondaryLocation: 'Menlo Park, California'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Suggestions',
          style: TextFontStyle.headline20c212B36stylepoppinsW500
              .copyWith(fontSize: 16.sp, color: AppColors.c919EAB),
        ),
        UIHelper.verticalSpace(16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Row(
                children: [
                  Image.asset(
                    Assets.images.locationLawbug.path,
                    width: 20.w,
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        suggestion.primaryLocation,
                        style: TextFontStyle.headline20c212B36stylepoppinsW500.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                      UIHelper.verticalSpace(8.h),
                      Text(
                        suggestion.secondaryLocation,
                        style: TextFontStyle.headline20c212B36stylepoppinsW500.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.c797676.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

