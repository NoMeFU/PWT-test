// ignore_for_file: library_private_types_in_public_api
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/navigation.dart';
import 'package:lawbug829/networks/api_acess.dart';

class AttendanceScreen extends StatefulWidget {
  final dynamic status;
  const AttendanceScreen({
    super.key,
    required this.status,
  });

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  
  
  String locationMessage = "Location not fetched yet";
  final TextEditingController roleController = TextEditingController();
  bool isLoading = false;

  Future<void> _lastLocationAndAPICalling() async {
    if (isLoading) return;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Location Permission"),
        content: const Text(
            "This app needs location access to check you in accurately."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Allow"),
          ),
        ],
      ),
    );

    if (result == true) {
      await _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    setState(() {
      isLoading = true;
    });

    try {
      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          locationMessage = "Location services are disabled.";
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enable location services.')),
        );
        return;
      }

      // Check location permission
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            locationMessage = "Location permission denied.";
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permission denied.')),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          locationMessage = "Location permission permanently denied.";
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Location permission permanently denied.')),
        );
        return;
      }

      // * Get the current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      // * Get current time in HH:mm:ss format

      final now = DateTime.now();
      final formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
      print("Check-in Time: $formattedDateTime");

      // Call the attendance API
      bool success = await attendanceApiRx.attendanceInfo(
        status: widget.status.toString(),
        role: roleController.text,
        lat: position.latitude.toString(),
        lang: position.longitude.toString(),
        time: formattedDateTime,
      );

      if (success) {
        print("first success");
        Get.offAll(() => BottomNavBar());
        print("yes success");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to check in. Please try again.')),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    // * status check on in screen
    log("==============> status: ${widget.status}");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Check in"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Role",
                  textAlign: TextAlign.start,
                  style: TextFontStyle.text15cFFF2C2,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: roleController,
                decoration: InputDecoration(
                  hintText: 'Enter your designation',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 60.h,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.c22BB33,
                  ),
                  onPressed: isLoading
                      ? null
                      : () {
                          if (roleController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please enter your role.')),
                            );
                          } else {
                            _lastLocationAndAPICalling();
                          }
                        },
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Check in",
                          style: TextFontStyle.arabic16c161C24StyleMeQuran
                              .copyWith(color: Colors.white, fontSize: 18.sp),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
