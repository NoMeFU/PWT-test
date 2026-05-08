// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:lawbug829/constants/text_font_style.dart';
// import 'package:lawbug829/gen/assets.gen.dart';
// import 'package:lawbug829/gen/colors.gen.dart';
// import 'package:lawbug829/helpers/ui_helpers.dart';

// class LiveLocation extends StatefulWidget {
//   final dynamic latitude;
//   final dynamic longitude;
//   // final String? userLocation;

//   const LiveLocation({
//     super.key,
//     required this.latitude,
//     required this.longitude,
//     // required this.userLocation,
//   });

//   @override
//   State<LiveLocation> createState() => _LiveLocationState();
// }

// class _LiveLocationState extends State<LiveLocation> {
//   String _locationName = 'Loading...';

//   @override
//   void initState() {
//     super.initState();
//     _getAddressFromLatLng();
//   }

//   Future<void> _getAddressFromLatLng() async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         widget.latitude,
//         widget.longitude,
//       );

//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks.first;
//         setState(() {
//           _locationName = place.locality ?? 'Unknown';
//         });
//       } else {
//         setState(() {
//           _locationName = 'Unknown';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _locationName = 'Error';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 160.w,
//       padding:
//           EdgeInsets.only(left: 14.w, top: 17.h, bottom: 11.h, right: 20.w),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.r),
//         color: AppColors.cFFF4E9,
//       ),
//       child: Row(
//         children: [
//           SvgPicture.asset(Assets.icons.locationOrangeLawbug),
//           UIHelper.horizontalSpace(7.w),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     'Location',
//                     style: TextFontStyle.headline20c212B36stylepoppinsW500
//                         .copyWith(
//                       fontSize: 12.sp,
//                       color: AppColors.c454F5B,
//                       height: 1.5.h,
//                     ),
//                   ),
//                   UIHelper.horizontalSpace(6.w),
//                   SvgPicture.asset(Assets.icons.activeIcon),
//                 ],
//               ),
//               UIHelper.verticalSpace(2.h),
//               Text(
//                 _locationName ?? "unknown",
//                 style: TextFontStyle.headline32c212B36stylepoppinsW700.copyWith(
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w600,
//                   height: 1.55.h,
//                   color: AppColors.c212B36,
//                 ),
//                 maxLines: 3,
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';

class LiveLocation extends StatefulWidget {
  const LiveLocation({super.key});

  @override
  State<LiveLocation> createState() => _LiveLocationState();
}

class _LiveLocationState extends State<LiveLocation> {
  String _locationName = 'Loading...';
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _locationName = 'Permission Denied';
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationName = 'Permission Denied Forever';
        });
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });

      // Get address from coordinates
      await _getAddressFromLatLng();
    } catch (e) {
      setState(() {
        _locationName = 'Error: $e';
      });
    }
  }

  Future<void> _getAddressFromLatLng() async {
    if (_latitude == null || _longitude == null) return;

    try {
      if (kIsWeb) {
        setState(() {
          _locationName = "${_latitude!.toStringAsFixed(2)}, ${_longitude!.toStringAsFixed(2)}";
        });
        return;
      }
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _latitude!,
        _longitude!,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _locationName = place.locality ?? 'Unknown';
        });
      } else {
        setState(() {
          _locationName = 'Unknown';
        });
      }
    } catch (e) {
      setState(() {
        _locationName = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      padding:
          EdgeInsets.only(left: 14.w, top: 17.h, bottom: 11.h, right: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.cFFF4E9,
      ),
      child: Row(
        children: [
          SvgPicture.asset(Assets.icons.locationOrangeLawbug),
          UIHelper.horizontalSpace(7.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Location',
                    style: TextFontStyle.headline20c212B36stylepoppinsW500
                        .copyWith(
                      fontSize: 12.sp,
                      color: AppColors.c454F5B,
                      height: 1.5.h,
                    ),
                  ),
                  UIHelper.horizontalSpace(6.w),
                  SvgPicture.asset(Assets.icons.activeIcon),
                ],
              ),
              UIHelper.verticalSpace(2.h),
              Text(
                _locationName,
                style: TextFontStyle.headline32c212B36stylepoppinsW700.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.55.h,
                  color: AppColors.c212B36,
                ),
                maxLines: 3,
              ),
            ],
          )
        ],
      ),
    );
  }
}
