import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/helpers/geocoding_helper.dart';
import 'package:intl/intl.dart';
import 'package:lawbug829/assets_healper/app_lottie.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/features/note/model/daily_update_model.dart';
import 'package:lawbug829/features/note/model/get_daily_model.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:lawbug829/networks/api_acess.dart';
import 'package:lottie/lottie.dart';

class DailyUpdateContent extends StatefulWidget {
  final List<DailyUpdateModel> updates;

  const DailyUpdateContent({
    super.key,
    required this.updates,
  });

  @override
  State<DailyUpdateContent> createState() => _DailyUpdateContentState();
}

class _DailyUpdateContentState extends State<DailyUpdateContent> {
  final Map<String, String> _locationCache = {};

  @override
  void initState() {
    super.initState();
    log('Initiating getDailyUpdateRx API call');
    getDailyUpdateApiRXObj.getDailyUpdateRx();
  }

  // * Get address from latitude and longitude
  Future<String?> getAddressFromLatLng(
      double latitude, double longitude) async {
    final cacheKey = '$latitude,$longitude';

    if (_locationCache.containsKey(cacheKey)) {
      return _locationCache[cacheKey];
    }

    try {
      List<dynamic> placemarks =
          await GeocodingHelper.placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final address =
            "${place.subLocality}, ${place.locality}, ${place.administrativeArea}";
        _locationCache[cacheKey] = address;
        return address;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  List<Datum> get _mockData => [
        Datum(
          id: 1,
          taskDate: DateTime.now().subtract(const Duration(days: 1)),
          lat: 40.7128,
          long: -74.0060,
          totalHours: "08 Hours 02min",
          descriptions: [
            DescriptionDataModelsssss(
              id: 1,
              dailyTaskId: 1,
              taskName: "Task 1",
              description: "Reviewed prevailing wage timecards for accuracy.",
            ),
            DescriptionDataModelsssss(
              id: 2,
              dailyTaskId: 1,
              taskName: "Task 2",
              description: "Resolved database synchronization issues.",
            ),
          ],
        ),
        Datum(
          id: 2,
          taskDate: DateTime.now().subtract(const Duration(days: 2)),
          lat: 34.0522,
          long: -118.2437,
          totalHours: "07 Hours 45min",
          descriptions: [
            DescriptionDataModelsssss(
              id: 3,
              dailyTaskId: 2,
              taskName: "Task 1",
              description: "Conducted on-site mobile attendance verification.",
            ),
          ],
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GetDailyUpdateModel>(
      stream: getDailyUpdateApiRXObj.getDailyUpdateAPIRX,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          log('StreamBuilder: Waiting for data');
          return Center(child: Lottie.asset(AppLottie.loading,
            width: 150.w,
            height: 150.h,
          ));
        }

        List<Datum> details;
        if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data?.data == null ||
            snapshot.data!.data!.isEmpty) {
          log('StreamBuilder: Falling back to mock data due to error or empty response');
          details = _mockData;
        } else {
          details = snapshot.data!.data!;
        }

        log('StreamBuilder: Data received with ${details.length} items');

        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          itemCount: details.length,
          itemBuilder: (context, index) {
            final update = details[index];
            final formattedDate = update.taskDate != null
                ? DateFormat('MMM dd, yyyy').format(update.taskDate!)
                : 'N/A';

            getAddressFromLatLng(
              update.lat ?? 0.0,
              update.long ?? 0.0,
            );
            final location =
                _locationCache['${update.lat ?? 0.0},${update.long ?? 0.0}'] ??
                    'Loading location...';
            final hours = update.totalHours ?? '--';
            final id = update.id.toString();

            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.cFFF4E9,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: SvgPicture.asset(Assets.icons.calenderLawbug),
                        ),
                        UIHelper.horizontalSpace(4.w),
                        Text(
                          formattedDate,
                          style: TextFontStyle.headline12c637381stylepoppinsW400
                              .copyWith(height: 1.83.h),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {

                            log("product id : ${id}");
                            log("description : ${details[index].descriptions}");

                            NavigationService.navigateToWithArgs(
                                Routes.updateDetailsScreen, {
                              "data": details[index].descriptions??[],
                              'id': id,
                              'location': location,
                              'hours': hours
                            });

                          },
                          child: Text(
                            'View Update',
                            style:
                                TextFontStyle.headline14cFF8E21stylepoppinsW600,
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(21.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          Assets.icons.locationOrangeLawbug,
                        ),
                        UIHelper.horizontalSpace(4.w),
                        Expanded(
                          child: Text(
                            location,
                            style:
                                TextFontStyle.headline14c212B36stylepoppinsW400,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        UIHelper.horizontalSpace(8.w),
                        Text(
                          hours,
                          style:
                              TextFontStyle.headline12c637381stylepoppinsW400,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
