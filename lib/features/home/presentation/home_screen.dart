// ignore_for_file: dead_code, unused_element, override_on_non_overriding_member, avoid_print, use_build_context_synchronously, unnecessary_brace_in_string_interps
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:lawbug829/assets_healper/app_image.dart';
import 'package:lawbug829/assets_healper/app_lottie.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/features/home/model/check_in_check_out_data_model.dart';
import 'package:lawbug829/features/home/model/home_attendance_and_user_info_data.dart';
import 'package:lawbug829/features/home/widgets/live_location.dart';
import 'package:lawbug829/features/home/widgets/total_duty.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:lawbug829/networks/api_acess.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../widgets/home_checkout_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  late DateTime startTime;
  late Timer timer;
  String elapsedTime = '00:00:00';
  final Map<String, String> _locationCache = {};
  late String formattedDateTime;

  @override
  void initState() {
    homeUserAndAttendanceRx.attendanceAndUserInfo();
    checkInCheckOutRx.checkInCheckOutInfo();
    startTime = DateTime.now();
    startTimer();
    super.initState();
  }

  // * Start the timer to calculate elapsed time
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final elapsed = DateTime.now().difference(startTime);
      setState(() {
        elapsedTime = '${elapsed.inHours.toString().padLeft(2, '0')}:'
            '${(elapsed.inMinutes % 60).toString().padLeft(2, '0')}:'
            '${(elapsed.inSeconds % 60).toString().padLeft(2, '0')}';
      });
    });
  }

  // * Get address from latitude and longitude
  Future<String?> getAddressFromLatLng(
      double latitude, double longitude) async {
    final cacheKey = '$latitude,$longitude';

    if (_locationCache.containsKey(cacheKey)) {
      return _locationCache[cacheKey];
    }

    try {
      if (kIsWeb) {
        // Plan B: OpenStreetMap (Nominatim) - no key required
        final nominatimUrl = 'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';
        final osmResponse = await Dio().get(
          nominatimUrl,
          options: Options(headers: {'User-Agent': 'PWT-App-Web'}),
        );
        
        if (osmResponse.statusCode == 200) {
          var data = osmResponse.data;
          if (data is String) {
            data = json.decode(data);
          }
          final displayName = data['display_name'];
          final address = data['address'];
          
          // Only show the city/town/village info as requested
          String cityInfo = address['city'] ?? address['town'] ?? address['village'] ?? address['suburb'] ?? "";
          String result = cityInfo.isNotEmpty ? cityInfo : (displayName != null ? displayName.split(',')[0] : "Unknown");

          _locationCache[cacheKey] = result;
          return result;
        }
      }
      
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final address =
            "${place.subLocality}, ${place.locality}, ${place.administrativeArea}";
        _locationCache[cacheKey] = address;
        return address;
      }
    } catch (e) {
      if (kDebugMode) print("Geocoding failed: $e");
    }
    return null;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  // * checkout dialog option
  Future<dynamic> _buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.r),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 0.85.sh,
            ),
            child: SingleChildScrollView(
              child: HomeCheckoutDialog(
                id: checkoutAttendenceRX.id,
              ),
            ),
          ),
        );
      },
    );
  }

  // * Place this method inside your _HomeScreenState class
  String _formatTime(String? datetime) {
    if (datetime == null || datetime.isEmpty) return "--";
    try {
      final date = DateTime.parse(datetime);
      return DateFormat('hh:mm a').format(date); // Converts to 09:45 AM
    } catch (e) {
      return "--";
    }
  }

  // * This is the updated full _buildLocationCard method
  Widget _buildLocationCard(CheckInData info) {
    final cardKey = '${info.lat}_${info.long}_${info.checkIn}_${info.checkOut}';

    return FutureBuilder<String?>(
      future: getAddressFromLatLng(
        info.lat?.toDouble() ?? 0.0,
        info.long?.toDouble() ?? 0.0,
      ),
      builder: (context, snapshot) {
        return Container(
          key: ValueKey(cardKey),
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w, bottom: 8.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppColors.cFFF4E9,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row with location + total hours
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(Assets.icons.locationOrangeLawbug),
                  UIHelper.horizontalSpace(8.w),
                  Expanded(
                    child: Text(
                      snapshot.data ?? "Unknown",
                      style: TextFontStyle.headline16c919EABstylepoppinsW400
                          .copyWith(
                        fontSize: 12.sp,
                        color: AppColors.c212B36,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Text(
                    info.totalHours ?? "--",
                    style: TextFontStyle.headline16c919EABstylepoppinsW400
                        .copyWith(
                      fontSize: 12.sp,
                      color: AppColors.c637381,
                      height: 1.83.h,
                    ),
                  ),
                ],
              ),

              UIHelper.verticalSpace(17.h),

              // Check-in & Check-out labels and times
              Column(
                children: [
                  Row(
                    children: [
                      UIHelper.horizontalSpace(5.w),
                      SvgPicture.asset(Assets.icons.arrowDownGreen),
                      UIHelper.horizontalSpace(4.w),
                      Column(
                        children: [
                          Text(
                            'Check In',
                            style: TextFontStyle
                                .headline16c919EABstylepoppinsW400
                                .copyWith(
                              fontSize: 14.sp,
                              color: AppColors.c22BB33,
                            ),
                          ),
                          UIHelper.verticalSpace(4.h),
                        ],
                      ),
                      const Spacer(),
                      SvgPicture.asset(Assets.icons.arrowUpRed),
                      UIHelper.horizontalSpace(4.w),
                      Column(
                        children: [
                          Text(
                            'Check Out',
                            style: TextFontStyle
                                .headline16c919EABstylepoppinsW400
                                .copyWith(
                              fontSize: 14.sp,
                              color: AppColors.cFF4842,
                            ),
                          ),
                          UIHelper.verticalSpace(4.h),
                        ],
                      ),
                    ],
                  ),

                  // * Check-in & Check-out formatted time row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 5.w), // For alignment
                      Text(
                        _formatTime(info.checkIn),
                        style: TextFontStyle.headline32c212B36stylepoppinsW700
                            .copyWith(
                          fontSize: 12.sp,
                          color: AppColors.c454F5B,
                        ),
                      ),
                      SizedBox(width: 150.w),
                      Text(
                        _formatTime(info.checkOut),
                        style: TextFontStyle.headline32c212B36stylepoppinsW700
                            .copyWith(
                          fontSize: 12.sp,
                          color: AppColors.c454F5B,
                        ),
                      ),
                      SizedBox(width: 5.w),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // * Build the main widget
  @override
  Widget build(BuildContext context) {
    setState(() {
      formattedDateTime =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    });
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    // * App bar with user info and notification icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StreamBuilder<HomeUserAndAttendanceDataModel>(
                            stream: homeUserAndAttendanceRx.dataFetcher,
                            builder: (context, snapshot) {
                              // * check user data
                              var userData = snapshot.data?.data?.user;
                              return Row(
                                children: [
                                  // * User avatar and greeting text
                                  userData?.avatar != null &&
                                          userData!.avatar!.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.r),
                                          child: CachedNetworkImage(
                                            imageUrl: userData.avatar!,
                                            width: 40.w,
                                            height: 40.w,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const Icon(
                                              Icons.account_circle,
                                              size: 40,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.account_circle,
                                              size: 40,
                                            ),
                                          ),
                                        )
                                      : const Icon(
                                          Icons.account_circle,
                                          size: 40,
                                        ),
                                  UIHelper.horizontalSpace(7.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Hello 👋',
                                            style: TextFontStyle
                                                .headline20c212B36stylepoppinsW500
                                                .copyWith(fontSize: 14.sp),
                                          ),
                                          Text(
                                            userData?.name ?? "No name",
                                            style: TextFontStyle
                                                .headline20c212B36stylepoppinsW500
                                                .copyWith(fontSize: 15.sp),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: GestureDetector(
                            onTap: () {
                              NavigationService.navigateTo(
                                  Routes.notificationScreen);
                            },
                            child: SvgPicture.asset(
                                Assets.icons.notificationLawbug),
                          ),
                        ),
                      ],
                    ),

                    // * Total Duty and Live Location Container
                    UIHelper.verticalSpace(32.h),
                    StreamBuilder<HomeUserAndAttendanceDataModel>(
                      stream: homeUserAndAttendanceRx.dataFetcher,
                      builder: (context, snapshot) {
                        // * check user data
                        var userData = snapshot.data?.data?.user;
                        var attendanceData = snapshot.data?.data?.attendance;
                        print(
                            "=======>>>>>>>>>>>>>>>>> ${attendanceData?.length}");
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TotalDuty(
                                date:
                                    userData?.workingDays?.toString() ?? "00"),
                            UIHelper.horizontalSpace(15.w),
                            const LiveLocation()
                          ],
                        );
                      },
                    ),

                    // * Show all Check In and Check Out
                    UIHelper.verticalSpace(20.h),
                    StreamBuilder<HomeUserAndAttendanceDataModel>(
                        stream: homeUserAndAttendanceRx.dataFetcher,
                        builder: (context, snapshot) {
                          // * Check if the stream is still loading
                          // var userData = snapshot.data?.data?.user;
                          var attendanceData = snapshot.data?.data?.attendance;

                          return Column(
                            children: [
                              attendanceData == null || attendanceData.isEmpty
                                  ? const SizedBox.shrink()
                                  : attendanceData.first.checkOut == null
                                      ? Container(
                                          padding: EdgeInsets.all(16.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            gradient: const LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color(0xFFFC8C20),
                                                Color(0xFFFFC083)
                                              ],
                                              stops: [0.2419, 1.6129],
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(Assets
                                                      .icons.stopWatchIcon),
                                                  UIHelper.horizontalSpace(4.w),
                                                  Text(
                                                    'Time Duration',
                                                    style: TextFontStyle
                                                        .headline16c919EABstylepoppinsW400
                                                        .copyWith(
                                                      fontSize: 16.sp,
                                                      color: AppColors.cFFFFFF,
                                                      height: 1.5.h,
                                                    ),
                                                  ),
                                                  const Spacer(),

                                                  // * Check Out Button for api calling
                                                  GestureDetector(
                                                    onTap: () async {
                                                      // Show loading dialog
                                                      showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            false, // Prevents dismissing the dialog by tapping outside
                                                        builder: (BuildContext
                                                            context) {
                                                          return Center(
                                                            child: Lottie.asset(
                                                              AppLottie.loading,
                                                              width: 150.w,
                                                              height: 150.h,
                                                              fit: BoxFit.contain,
                                                            ),
                                                          );
                                                        },
                                                      );
                                                      try {
                                                        bool isSuccess =
                                                            await checkoutAttendenceRX
                                                                .checkoutAttendanceInfo(
                                                          status: 'check_out',
                                                          role: attendanceData
                                                              .last.role
                                                              .toString(),
                                                          lat: attendanceData
                                                              .last.lat
                                                              .toString(),
                                                          lang: attendanceData
                                                              .last.long
                                                              .toString(),
                                                          time:
                                                              formattedDateTime,
                                                        );

                                                        // Close the loading dialog
                                                        Navigator.of(context)
                                                            .pop();

                                                        if (isSuccess) {
                                                          _buildShowDialog(
                                                              context);

                                                          /// 👉 REFRESH the streams after checkout success
                                                          checkInCheckOutRx
                                                              .checkInCheckOutInfo();
                                                          homeUserAndAttendanceRx
                                                              .attendanceAndUserInfo();
                                                          log('Role: ${attendanceData.last.role}');
                                                          log('Longitude: ${attendanceData.last.lat}');
                                                          log('Latitute: ${attendanceData.last.long}');
                                                          log('Checkout Time: ${formattedDateTime}');
                                                        } else {
                                                          ToastUtil
                                                              .showShortToast(
                                                                  'Error');
                                                        }
                                                      } catch (e) {
                                                        // Close the loading dialog in case of an error
                                                        Navigator.of(context)
                                                            .pop();
                                                        ToastUtil
                                                            .showShortToast(
                                                                'Error: $e');
                                                      }
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w,
                                                              vertical: 6.h),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                        color:
                                                            AppColors.cFDA44D,
                                                      ),
                                                      child: Text(
                                                        'Check Out',
                                                        style: TextFontStyle
                                                            .headline16c919EABstylepoppinsW400
                                                            .copyWith(
                                                          fontSize: 12.sp,
                                                          color:
                                                              AppColors.cFFFFFF,
                                                          height: 1.7.h,
                                                        ),
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              UIHelper.verticalSpace(21.h),
                                              Text(
                                                elapsedTime,
                                                style: TextFontStyle
                                                    .headline32c212B36stylepoppinsW700
                                                    .copyWith(
                                                  color: AppColors.cFFFFFF,
                                                  height: 1.5.h,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                            ],
                          );
                        }),
                  ],
                ),

                // * Today's Check In and Check Out List
                Text(
                  'Today',
                  style: TextFontStyle.headline20c212B36stylepoppinsW500
                      .copyWith(height: 1.5.h),
                ),

                // * Some Space from top
                UIHelper.verticalSpace(16.h),

                // * Check In and Check Out List
                // StreamBuilder<CheckInCheckOutDataModel>(
                //   stream: checkInCheckOutRx.dataFetcher,
                //   builder: (context, snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return Center(
                //         child: Lottie.asset(AppLottie.loading),
                //       );
                //     } else if (snapshot.hasError) {
                //       return const Center(child: Text("Something went wrong!"));
                //     } else if (!snapshot.hasData ||
                //         snapshot.data!.data == null) {
                //       return Center(
                //           child: Text(
                //         "No data available",
                //         style: TextFontStyle.headline14c919EABstylepoppinsW400,
                //       ));
                //     } else {
                //       var data = snapshot.data!.data!;
                //       return ListView.separated(
                //         separatorBuilder: (context, index) =>
                //             UIHelper.verticalSpace(16.h),
                //         shrinkWrap: true,
                //         physics: const NeverScrollableScrollPhysics(),
                //         itemCount: data.length,
                //         itemBuilder: (context, index) {
                //           final locationInfo = data[index];
                //           return _buildLocationCard(locationInfo);
                //         },
                //       );
                //     }
                //   },
                // ),
                StreamBuilder<CheckInCheckOutDataModel>(
                  stream: checkInCheckOutRx.dataFetcher,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Lottie.asset(AppLottie.loading),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text("Something went wrong!"),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!.data == null) {
                      return Center(
                          child: Column(
                        children: [
                          Image.asset(
                                Appimages.sadIcon,
                                height: 100.h,
                                width: 100.w,
                              ),
                        ],
                      ));
                    } else {
                      var data = snapshot.data!.data!;
                      if (data.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              Image.asset(
                                Appimages.sadIcon,
                                height: 100.h,
                                width: 100.w,
                              ),
                              Text(
                                "Please Check In",
                                style: TextFontStyle
                                    .headline14c919EABstylepoppinsW400
                                    .copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.c212B36,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            UIHelper.verticalSpace(16.h),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final locationInfo = data[index];
                          return _buildLocationCard(locationInfo);
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
