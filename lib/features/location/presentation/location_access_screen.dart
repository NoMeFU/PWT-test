import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lawbug829/common_widget/custom_button.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';

class LocationAccessScreen extends StatefulWidget {
  const LocationAccessScreen({super.key});

  @override
  State<LocationAccessScreen> createState() => _LocationAccessScreenState();
}

class _LocationAccessScreenState extends State<LocationAccessScreen> {
  bool _isLoading = false;

  Future<void> _handleUseCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Step 1: Check if location service is enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enable location services.')),
        );
        return;
      }

      // Step 2: Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permission denied.')),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Location permission is permanently denied. Please enable it from settings.',
            ),
          ),
        );
        return;
      }

      // Step 3: Get current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() => _isLoading = false);

      // Step 4: Navigate with coordinates
      NavigationService.navigateToWithArgs(
        Routes.cuerrentLocationScreen,
        {
          'lat': position.latitude,
          'lng': position.longitude,
        },
      );
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.images.locationAccessImage.path),
              UIHelper.verticalSpace(80.h),

              ///============= Search Location Button ==========================
              customeButton(
                name: 'Search Location',
                color: Colors.transparent,
                context: context,
                textColor: AppColors.cFF8E21,
                onCallBack: () {
                  NavigationService.navigateTo(Routes.searchLocationScreen);
                },
              ),

              UIHelper.verticalSpace(16.h),

              ///============= Use Current Location Button ======================
              _isLoading
                  ? const CircularProgressIndicator()
                  : customeButton(
                      name: 'Use Current Location',
                      context: context,
                      onCallBack: _handleUseCurrentLocation,
                      textStyle: TextFontStyle.headline16c919EABstylepoppinsW400
                          .copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.cFCFCFC,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
