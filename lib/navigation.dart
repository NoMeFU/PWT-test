import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lawbug829/assets_healper/app_color.dart';
import 'package:lawbug829/assets_healper/app_image.dart';
import 'package:lawbug829/common_widget/custom_button.dart';
import 'package:lawbug829/common_widget/custom_text_field.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/features/note/presentation/note_screen.dart';
import 'package:lawbug829/features/profile/presentation/profile_screen.dart';
import 'package:lawbug829/features/report/presentation/report_screen.dart';
import 'package:lawbug829/features/subscription/model/subscription_check_model.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:lawbug829/networks/api_acess.dart';
import 'features/home/presentation/home_screen.dart';
import 'gen/assets.gen.dart';
import 'gen/colors.gen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<BottomNavBar> {
  String locationMessage = "Location not fetched yet";
  final TextEditingController roleController = TextEditingController();
  bool isLoading = false;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getSubscriptionCheckRXObj.getSubscriptionRX();
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const NoteScreen(),
    const ReportScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      setState(() {
        _currentIndex = index;
      });
      if (kDebugMode) {
        print("Center button tapped");
      }
      return;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  // * Function to check if location permission is granted and get the last location
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
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context, true);
              await _checkInSuccessfulDialog();
            },
            child: const Text("Allow"),
          ),
        ],
      ),
    );

    if (result == true) {
      await _getCurrentLocation();
    }
  }

  // * Get current location and call the attendance API
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
        status: "check_in",
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

  // * চেক ইন ডায়ালগ
  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: const Text(
            'Check In',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Container(
            width: 350,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Role",
                    textAlign: TextAlign.start,
                    style: TextFontStyle.headline12c757575styleRobotoW400,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: roleController,
                  hintText: 'Enter your role',
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: StreamBuilder<CheckSubscription>(
                  stream: getSubscriptionCheckRXObj.dataFetcher,
                  builder: (context, snapshot) {
                    bool isSubscribed =
                        snapshot.data?.data?.isSubscribed ?? false;
                    return customeButton(
                      name: 'Check In',
                      textStyle: TextFontStyle.headline14c757575styleRobotoW500,
                      color: Colors.green,
                      borderColor: Colors.green,
                      onCallBack: isLoading
                          ? () {}
                          : () {
                              // TEMPORARY BYPASS FOR TESTING
                              if (isSubscribed == false) {
                                NavigationService.navigateTo(
                                  Routes.subscriptionScreen,
                                );
                                return;
                              } else {
                                if (roleController.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Please enter your role.',
                                      ),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).pop();
                                  _lastLocationAndAPICalling();
                                }
                              }
                            },
                      context: context,
                    );
                  }),
            ),
          ],
        );
      },
    );
  }

  // * চেক ইন ডায়ালগ
  Future<void> _checkInSuccessfulDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: const Text(
            'Check In',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Container(
            width: 450,
            height:
                300, // প্রস্থ বাড়ানোর জন্য width সেট করা হলো (আপনি চাইলে এটি 350 বা অন্য সংখ্যা করতে পারেন)
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Check In Successful",
                    textAlign: TextAlign.start,
                    style: TextFontStyle.headline12c757575styleRobotoW400,
                  ),
                ),
                const SizedBox(height: 8),
                Image.asset(
                  Appimages.successImage,
                  height: 100.h,
                  width: 100.w,
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: customeButton(
                name: 'Go To Home',
                textStyle: TextFontStyle.headline14c757575styleRobotoW500,
                color: AppColor.cFB9F43,
                borderColor: AppColor.cFB9F43,
                onCallBack: () {},
                context: context,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
          ? StreamBuilder<CheckSubscription>(
              stream: getSubscriptionCheckRXObj.dataFetcher,
              builder: (context, snapshot) {
                bool isSubscribed = snapshot.data?.data?.isSubscribed ?? (snapshot.hasData ? false : true);

                // Bypass for tester account
                final userEmail = homeUserAndAttendanceRx.dataFetcher.valueOrNull?.data?.user?.email;
                if (userEmail == 'ztejuvpu@sharklasers.com') {
                  isSubscribed = true;
                }

                return FloatingActionButton(
                  backgroundColor: AppColors.cFFFFFF,
                  elevation: 0,
                  onPressed: () {
                    // TEMPORARY BYPASS FOR TESTING CLOCK-IN
                    if (isSubscribed == false) {
                      NavigationService.navigateTo(
                        Routes.subscriptionScreen,
                      );
                      return;
                    } else {
                      _showInputDialog();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.cFFFFFF,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          offset: const Offset(0, 2),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.sp),
                      child: SvgPicture.asset(
                        Assets.icons.plusSign,
                        height: 30.h,
                        width: 30.w,
                      ),
                    ),
                  ),
                );
              })
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: AppColors.cFFFFFF,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        color: AppColors.cFFF4E9,
        child: SizedBox(
          height: 65.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                  0, Assets.icons.home, "Home".tr, Assets.icons.homeSelected),
              _buildNavItem(
                  1, Assets.icons.note, "Note", Assets.icons.noteSelected),
              const SizedBox(width: 50),
              _buildNavItem(2, Assets.icons.report, "Report",
                  Assets.icons.reportSelected),
              _buildNavItem(3, Assets.icons.profileLawbug, "Profile",
                  Assets.icons.profileSelected),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index, String iconPath, String label, String iconPathSelected) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            isSelected ? iconPathSelected : iconPath,
            height: 25.h,
          ),
          UIHelper.verticalSpace(4.h),
          Text(
            label,
            style: TextFontStyle.headline8cFFFFFFstylepoppinsW500.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColors.cFF8E21 : AppColors.c454F5B,
            ),
          ),
        ],
      ),
    );
  }
}
