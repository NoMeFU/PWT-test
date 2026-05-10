// // ignore_for_file: unused_field
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:lawbug829/common_widget/custom_button.dart';
// import 'package:lawbug829/constants/text_font_style.dart';
// import 'package:lawbug829/gen/assets.gen.dart';
// import 'package:lawbug829/gen/colors.gen.dart';
// import 'package:lawbug829/helpers/all_routes.dart';
// import 'package:lawbug829/helpers/navigation_service.dart';
// import 'package:lawbug829/helpers/ui_helpers.dart';

// class CurrentLocationScreen extends StatefulWidget {
//   final double lat;
//   final double lng;

//   const CurrentLocationScreen({
//     super.key,
//     required this.lat,
//     required this.lng,
//   });

//   @override
//   State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
// }

// class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
//   late GoogleMapController _mapController;
//   String placeName = '';

//   @override
//   void initState() {
//     getGooglePlaceName(widget.lat, widget.lng);
//     // getPlaceName();
//     if (kDebugMode) {
//       print(
//           '=============================== here is the current latitude :${widget.lat} ');
//       print(
//           '=============================== here is the current longitude :${widget.lng} ');
//     }
//     // * Initialize the map controller
//     super.initState();
//   }

//   Future<void> getGooglePlaceName(double lat, double lng) async {
//     const apiKey =
//         'AIzaSyDmNO0nvvAkkxk6rYBDQEfVXVQPB9rKlsk'; // Replace with your key
//     final url =
//         'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey';

//     try {
//       final response = await Dio().get(url);
//       if (response.statusCode == 200) {
//         final results = response.data['results'];
//         if (results.isNotEmpty) {
//           // Try to find the most human-readable name
//           for (var result in results) {
//             final types = List<String>.from(result['types']);
//             if (types.contains('sublocality') ||
//                 types.contains('neighborhood') ||
//                 types.contains('locality')) {
//               setState(() {
//                 placeName = result['formatted_address'];
//               });
//               return;
//             }
//           }

//           // If nothing better is found, fallback to first result
//           setState(() {
//             placeName = results[0]['formatted_address'];
//           });
//         }
//       } else {
//         if (kDebugMode) {
//           print('Geocoding API error: ${response.statusCode}');
//         }
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('Failed to get Google place name: $e');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           /// google map
//           GoogleMap(
//             initialCameraPosition: CameraPosition(
//                 target: LatLng(widget.lat, widget.lng), zoom: 15),
//             onMapCreated: (controller) {
//               _mapController = controller;
//             },
//             markers: {
//               Marker(
//                 markerId: const MarkerId("current_location"),
//                 position: LatLng(widget.lat, widget.lng),
//               )
//             },
//             myLocationButtonEnabled: true,
//             myLocationEnabled: true,
//           ),

//           /// Custom app bar over the image
//           SafeArea(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       NavigationService.goBack;
//                     },
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 16.w),
//                       child: SvgPicture.asset(
//                         Assets.icons.arrowBackLawbug,
//                       ),
//                     ),
//                   ),
//                   UIHelper.horizontalSpace(57.w),
//                   Text(
//                     'Enter Your location',
//                     style: TextFontStyle.headline20c212B36stylepoppinsW500,
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           /// Example container overlay (you can customize the position)
//           Positioned(
//             bottom: 0.h,
//             // left: 20.w,
//             // right: 20.w,
//             child: Container(
//                 width: 390.w,
//                 padding: EdgeInsets.only(
//                     top: 10.h, left: 10.w, right: 10.w, bottom: 24.h),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.9),
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: Container(
//                           width: 108.w,
//                           height: 4.h,
//                           color: AppColors.cCFCFCF,
//                         ),
//                       ),
//                       UIHelper.verticalSpace(48.h),
//                       Row(
//                         children: [
//                           SvgPicture.asset(
//                             Assets.icons.location,
//                           ),
//                           UIHelper.horizontalSpace(8.w),

//                           Expanded(
//                             child: Text(
//                               placeName.isNotEmpty
//                                   ? placeName
//                                   : 'Loading location',
//                               style: TextFontStyle
//                                   .headline20c212B36stylepoppinsW500
//                                   .copyWith(
//                                       fontSize: 16.sp,
//                                       color: AppColors.c000000,
//                                       height: 1.5.h),
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 3,
//                             ),
//                           ),
//                           // const Spacer(),
//                           // Padding(
//                           //   padding: EdgeInsets.only(right: 10.w),
//                           //   child: Text(
//                           //     'Change',
//                           //     style: TextFontStyle
//                           //         .headline20c212B36stylepoppinsW500
//                           //         .copyWith(
//                           //             fontSize: 14.sp,
//                           //             color: AppColors.cFF8E21),
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                       UIHelper.verticalSpace(35.h),
//                       Padding(
//                         padding: EdgeInsets.only(right: 10.w),
//                         child: customeButton(
//                           name: 'Conform',
//                           context: context,
//                           onCallBack: () {
//                             NavigationService.navigateToWithArgs(
//                                 Routes.registrationScreen, {
//                               'employeeLat': widget.lat,
//                               'employeeLong': widget.lng,
//                               'employeeAddress': placeName.toString(),
//                             });
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//           ),
//         ],
//       ),
//     );
//   }
// }

// * ##########################################

// ignore_for_file: unused_field
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawbug829/helpers/geocoding_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lawbug829/common_widget/custom_button.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';

class CurrentLocationScreen extends StatefulWidget {
  final double lat;
  final double lng;

  const CurrentLocationScreen({
    super.key,
    required this.lat,
    required this.lng,
  });

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  late GoogleMapController _mapController;
  String placeName = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getPlaceNameFast(widget.lat, widget.lng);
  }

  Future<void> _getPlaceNameFast(double lat, double lng) async {
    try {
      if (kIsWeb) {
         // Skip local geocoding on web as it is not supported
         throw Exception("Web platform: skipping local geocoding");
      }
      // 🔹 Try local geocoding first (much faster)
      List<dynamic> placemarks = await GeocodingHelper.placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        setState(() {
          placeName =
              "${p.street ?? ''}, ${p.locality ?? ''}, ${p.administrativeArea ?? ''}, ${p.country ?? ''}"
                  .replaceAll(RegExp(r'\s+'), ' ')
                  .trim();
          _isLoading = false;
        });
        return;
      }
    } catch (e) {
      if (kDebugMode) print("Local geocoding failed: $e");
    }

    // 🔹 Fallback: Google API (only if needed)
    try {
      const apiKey =
          'AIzaSyDmNO0nvvAkkxk6rYBDQEfVXVQPB9rKlsk'; // Replace with your key
      final url =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey';

      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final results = response.data['results'];
        if (results.isNotEmpty) {
          setState(() {
            placeName = results[0]['formatted_address'];
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (kDebugMode) print('Fallback Google API failed: $e');
      setState(() {
        placeName = 'Location not found';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Google Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.lat, widget.lng),
              zoom: 15,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            markers: {
              Marker(
                markerId: const MarkerId("current_location"),
                position: LatLng(widget.lat, widget.lng),
              ),
            },
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
          ),

          /// Custom App Bar
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => NavigationService.goBack(),
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: SvgPicture.asset(Assets.icons.arrowBackLawbug),
                    ),
                  ),
                  UIHelper.horizontalSpace(57.w),
                  Text(
                    'Enter Your Location',
                    style: TextFontStyle.headline20c212B36stylepoppinsW500,
                  ),
                ],
              ),
            ),
          ),

          /// Bottom Card
          Positioned(
            bottom: 0.h,
            child: Container(
              width: 390.w,
              padding: EdgeInsets.only(
                  top: 10.h, left: 10.w, right: 10.w, bottom: 24.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 108.w,
                        height: 4.h,
                        color: AppColors.cCFCFCF,
                      ),
                    ),
                    UIHelper.verticalSpace(48.h),
                    Row(
                      children: [
                        SvgPicture.asset(Assets.icons.location),
                        UIHelper.horizontalSpace(8.w),
                        Expanded(
                          child: Text(
                            _isLoading
                                ? 'Loading location...'
                                : placeName.isNotEmpty
                                    ? placeName
                                    : 'Address not found',
                            style: TextFontStyle
                                .headline20c212B36stylepoppinsW500
                                .copyWith(
                              fontSize: 16.sp,
                              color: AppColors.c000000,
                              height: 1.5.h,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(35.h),
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: customeButton(
                        name: 'Confirm',
                        context: context,
                        onCallBack: () {
                          NavigationService.navigateToWithArgs(
                            Routes.registrationScreen,
                            {
                              'employeeLat': widget.lat,
                              'employeeLong': widget.lng,
                              'employeeAddress': placeName.toString(),
                            },
                          );
                        },
                      ),
                    ),
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
