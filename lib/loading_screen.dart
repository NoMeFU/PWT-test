// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:lawbug829/features/auth/login/presentation/log_in_screen.dart';
import 'package:lawbug829/features/onboarding/presentation/onboarding_screen.dart';
import 'package:lawbug829/features/subscription/subcription_service/subscription_config.dart';
import 'package:lawbug829/navigation.dart';
import 'package:lawbug829/networks/api_acess.dart';
import 'package:lawbug829/splash_screen.dart';
import 'constants/app_constants.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'networks/dio/dio.dart';

final class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = true;
  bool isFirstTime = false;

  @override
  void initState() {
    loadInitialData();
    super.initState();
  }

  loadInitialData() async {
    await setInitValue();
    if (appData.read(kKeyIsLoggedIn)) {
      String? userId = appData.read(kKeyUserID);

      await PurchaseHelper.init(
        id: userId,
      );
      String token = appData.read(kKeyAccessToken);
      DioSingleton.instance.update(token);

      // * load initial data
      await checkInCheckOutRx.checkInCheckOutInfo();
      await homeUserAndAttendanceRx.attendanceAndUserInfo();
      // await getDailyUpdateApiRXObj.getDailyUpdateRx();
      // await getProblemApiRX.getProblemRx();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = appData.read(kKeyIsLoggedIn) ?? false;
    if (_isLoading) {
      return const SplashScreen();
    } else if (isFirstTime) {
      return const OnboardingScreen();
    } else if (isLoggedIn) {
      return const BottomNavBar();
    } else {
      return const LogInScreen();
    }
  }
}
