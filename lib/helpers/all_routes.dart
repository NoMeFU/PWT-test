// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:lawbug829/features/attendance_screen/presentation/AttendanceScreen.dart';
import 'package:lawbug829/features/auth/login/presentation/log_in_screen.dart';
import 'package:lawbug829/features/auth/forget_password/presentation/forgot_password_screen.dart';
import 'package:lawbug829/features/auth/register/presentation/register_screen.dart';
import 'package:lawbug829/features/auth/verification/presentation/verify_email_screen.dart';
import 'package:lawbug829/features/location/presentation/current_location_screen.dart';
import 'package:lawbug829/features/location/presentation/location_access_screen.dart';
import 'package:lawbug829/features/location/presentation/search_location_screen.dart';
import 'package:lawbug829/features/note/presentation/add_facing_problem_screen.dart';
import 'package:lawbug829/features/note/presentation/facing_problem_details_screen.dart';
import 'package:lawbug829/features/note/presentation/update_details_screen.dart';
import 'package:lawbug829/features/notification/presentation/notification_screen.dart';
import 'package:lawbug829/features/profile/presentation/profile_sub_screen/edit_profile_screen.dart';
import 'package:lawbug829/features/profile/presentation/profile_sub_screen/help_support_screen.dart';
import 'package:lawbug829/features/report/presentation/add_expense_money_screen.dart';
import 'package:lawbug829/features/report/presentation/paycheck_screen.dart';
import 'package:lawbug829/features/report/presentation/widgets/expanse_details_report.dart';
import 'package:lawbug829/features/subscription/presentation/subscription_screen.dart';
import 'package:lawbug829/loading_screen.dart';
import 'package:lawbug829/navigation.dart';
import '../features/profile/presentation/profile_sub_screen/aboutUs_screen.dart';
import '../features/profile/presentation/profile_sub_screen/add_review_screen.dart';
import '../features/profile/presentation/profile_sub_screen/adress_screen.dart';
import '../features/profile/presentation/profile_sub_screen/partnership_agency_screen.dart';
import '../features/profile/presentation/profile_sub_screen/personal_information_screen.dart';
import '../features/profile/presentation/profile_sub_screen/profile_notifications_screen.dart';
import '../features/profile/presentation/profile_sub_screen/reset_password_screen.dart';
import '../features/profile/presentation/profile_sub_screen/setting_screen.dart';
import '../features/profile/presentation/profile_sub_screen/terms_condition_screen.dart';

final class Routes {
  static final Routes _routes = Routes._internal();

  Routes._internal();

  static Routes get instance => _routes;

  //=========== Profile =========//
  static const String personalInfoScreen = '/personalInfoScreen';
  static const String settingScreen = '/settingScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String aboutUsScreen = '/aboutUsScreen';
  static const String termsConditionScreen = '/termsConditionScreen';
  static const String partnershipAgencyScreen = '/partnershipAgencyScreen';
  static const String addReviewScreen = '/addReviewScreen';
  static const String profileNotificationScreen = '/profileNotificationScreen';
  static const String helpSupportScreen = '/helpSupportScreen';
  static const String addressScreen = '/addressScreen';

  // ################## Auth User ##################
  static const String profileScreen = '/profileScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String loginScreen = '/loginScreen';
  static const String otpScreen = '/otpScreen';
  static const String signInScreen = '/signInScreen';
  // ignore: constant_identifier_names
  static const String ChooseType = '/chooseType';
  static const String resetPassword = '/resetPassword';
  static const String faceVerification = '/faceVerification';
  static const String faceVerificationSuccess = '/faceVerificationSuccess';
  static const String faceRecognition = '/faceRecognition';
  static const String freeEnrollmentForm = '/freeEnrollmentForm';
  static const String medicaidInformation = '/medicaidInformation';
  static const String compoleteEnrollment = '/compoleteEnrollment';
  static const String clientHome = '/clientHome';
  static const String nurseAssesment = '/nurseAssesment';
  static const String nurseCall = '/nurseCall ';
  static const String agencyCaseContact = '/agencyCaseContact ';
  static const String phoneVerification = '/phoneVerification ';
  static const String nurseCallLogScreen = '/nurseCallLogScreen ';

  static const String supportChatScreen = '/supportChatScreen ';
  static const String myClientQueueScreen = '/myClientQueueScreen ';
  static const String myClientQueueDetailsScreen =
      '/myClientQueueDetailsScreen ';

  // static const String supportChatScreen = '/supportChatScreen ';
  static const String bottomNavBar = '/bottomNavBar ';
  static const String clientSettingsScreen = '/clientSettingsScreen ';
  static const String clientProfileEditScreen = '/clientProfileEditScreen ';

  static const String referrals = '/referrals';

  static const String clientUserFlowFaq = '/clientUserFlowFaq ';
  static const String clientAboutUsScreen = '/clientAboutUsScreen ';

  static const String clientFirstForm = '/clientFirstForm ';
  static const String clientSecondForm = '/clientSecondForm ';
  static const String notificationScreen = '/notificationScreen ';
  static const String chatByToBy = '/chatByToBy ';
  static const String clientFirstFormScreen = '/clientFirstFormScreen ';
  static const String clientSecondFormScreen = '/clientSecondFormScreen ';
  static const String completeEnrollmentScreen = '/completeEnrollmentScreen ';
  static const String signUpWorkerScreen = '/signUpWorkerScreen ';
  static const String faceVerificationWorker = '/faceVerificationWorker ';
  static const String phoneVerificationWorker = '/phoneVerificationWorker ';
  static const String faceVerificationSuccessWorker =
      '/faceVerificationSuccessWorker ';
  static const String faceRecognitionWorker = '/faceRecognitionWorker ';
  static const String navigationWorker = '/navigationWorker ';
  static const String notificationWorkerScreen = '/notificationWorkerScreen ';
  static const String workerClientFirstFormScreen =
      '/workerClientFirstFormScreen ';
  static const String workerClientSecondFormScreen =
      '/workerClientSecondFormScreen ';
  static const String completeEnrollmentWorkerScreen =
      '/completeEnrollmentWorkerScreen ';
  // static const String myClientQueueWorkerScreen = '/myClientQueueWorkerScreen ';
  static const String myClientQueueWorkerDetailsScreen =
      '/myClientQueueWorkerDetailsScreen ';
  static const String refarrelsWorker = '/refarrelsWorker ';
  static const String chatByToByWorker = '/chatByToByWorker ';
  static const String clientProfileEditWorkerScreen =
      '/clientProfileEditWorkerScreen ';
  static const String clientSettingsWorkerScreen =
      '/clientSettingsWorkerScreen ';
  static const String clientFaqWorkerScreen = '/clientFaqWorkerScreen ';
  static const String clientAboutUsWorkerScreen = '/clientAboutUsWorkerScreen ';
  static const String myClientQueueWorkerOneScreen =
      '/myClientQueueWorkerOneScreen ';
  static const String clientSecondFormLast = '/clientSecondFormLast ';
  static const String clientThirdFormScreen = '/clientThirdFormScreen ';
  static const String workerClientThirdFormScreen =
      '/workerClientThirdFormScreen ';
  static const String workerClientForthFormScreen =
      '/workerClientForthFormScreen ';
  static const String clientForthFormScreen = '/clientForthFormScreen ';
  static const String locationAccessScreen = '/locationAccessScreen ';
  static const String searchLocationScreen = '/searchLocationScreen ';
  static const String cuerrentLocationScreen = '/cuerrentLocationScreen ';
  static const String registrationScreen = '/registrationScreen ';
  static const String verifyEmailScreen = '/verifyEmailScreen ';
  static const String forgotPasswordScreen = '/forgotPasswordScreen ';
  static const String updateDetailsScreen = '/updateDetailsScreen ';
  static const String addFacingProblemScreen = '/addFacingProblemScreen ';
  static const String facingProblemDetailsScreen =
      '/facingProblemDetailsScreen ';
  static const String addExpenseMoneyScreen = '/addExpenseMoneyScreen ';
  static const String paycheckScreen = '/paycheckScreen ';

  // * Profile Edit Screens
  static const String editProfileScreen = '/editProfileScreen';

  // * Attendence Screen
  static const String attendanceScreen = '/attendanceScreen';

  // * Expense Details Screen
  static const String expenseDetailsScreen = '/expenseDetailsScreen';

  // * loading screen
  static const String loadingScreen = '/loadingScreen';

  // * Subscription Screen
  static const String subscriptionScreen = '/subscriptionScreen';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();

  RouteGenerator._internal();

  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // * Loading Screen
      case Routes.loadingScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: Loading(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => Loading(),
              );

      // * Bottom Navigation Bar
      case Routes.bottomNavBar:
        final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: BottomNavBar(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => BottomNavBar(),
              );

      // * Attendence Screen
      case Routes.attendanceScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: AttendanceScreen(
                  status: args['status'],
                ),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => AttendanceScreen(
                  status: args['status'],
                ),
              );

      // * Notification Screen
      case Routes.notificationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const NotificationScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const NotificationScreen());

      // * Location Access Screen
      case Routes.locationAccessScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const LocationAccessScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const LocationAccessScreen());

      // * Search Location Screen
      case Routes.searchLocationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const SearchLocationScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const SearchLocationScreen());

      case Routes.cuerrentLocationScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CurrentLocationScreen(
                  lat: args['lat'],
                  lng: args['lng'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => CurrentLocationScreen(
                      lat: args['lat'],
                      lng: args['lng'],
                    ));

      case Routes.registrationScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: RegisterScreen(
                  employeeAddress: args['employeeAddress'],
                  employeeLat: args['employeeLat'],
                  employeeLong: args['employeeLong'],
                ),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => RegisterScreen(
                  employeeAddress: args['employeeAddress'],
                  employeeLat: args['employeeLat'],
                  employeeLong: args['employeeLong'],
                ),
              );

      // * verify Email Screen
      case Routes.verifyEmailScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: VerifyEmailScreen(
                  email: args['email'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => VerifyEmailScreen(
                      email: args['email'],
                    ));

      case Routes.loginScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const LogInScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const LogInScreen());

      case Routes.forgotPasswordScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ForgotPasswordScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const ForgotPasswordScreen());

      case Routes.updateDetailsScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: UpdateDetailsScreen(
                  data: args['data'],
                  id: args['id'],
                  location: args['location'],
                  hours: args['hours'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => UpdateDetailsScreen(
                  data: args['data'],
                  id: args['id'],
                  location: args['location'],
                  hours: args['hours'],
                ),
              );

      case Routes.addFacingProblemScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const AddFacingProblemScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const AddFacingProblemScreen());

      // * Facing Problem Details Screen ==> it receive the problemId from the Problem Content Screen
      case Routes.facingProblemDetailsScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: FacingProblemDetailsScreen(
                  problemId: args['problemId'],
                  problemDescription: args['problemDescription'],
                  problemLocation: args['problemLocation'],
                  problemDate: args['problemDate'],
                  problemStatus: args['problemStatus'],
                  problemFeedback: args['problemFeedback'],
                ),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => FacingProblemDetailsScreen(
                  problemId: args['problemId'],
                  problemDescription: args['problemDescription'],
                  problemLocation: args['problemLocation'],
                  problemDate: args['problemDate'],
                  problemStatus: args['problemStatus'],
                  problemFeedback: args['problemFeedback'],
                ),
              );

      case Routes.addExpenseMoneyScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const AddExpenseMoneyScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const AddExpenseMoneyScreen());

      case Routes.paycheckScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: PaycheckScreen(
                  date: args['date'],
                  location: args['location'],
                  totalWorkTime: args['totalWorkTime'],
                  checkIn: args['checkIn'],
                  checkOut: args['checkOut'],
                  employeeId: args['employeeId'],
                  role: args['role'],
                  salary: args['salary'],
                  workingTime: args['workingTime'],
                  tax: args['tax'],
                  totalSalary: args['totalSalary'],
                  employeeID:
                      args['employeeID'], // Assuming employeeId is used here
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => PaycheckScreen(
                  date: args['date'],
                  location: args['location'],
                  totalWorkTime: args['totalWorkTime'],
                  checkIn: args['checkIn'],
                  checkOut: args['checkOut'],
                  employeeId: args['employeeId'],
                  role: args['role'],
                  salary: args['salary'],
                  workingTime: args['workingTime'],
                  tax: args['tax'],
                  totalSalary: args['totalSalary'],
                  employeeID:
                      args['employeeID'], // Assuming employeeId is used here
                ),
              );

      case Routes.personalInfoScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const PersonalInformationScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const PersonalInformationScreen());

      case Routes.settingScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const SettingScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const SettingScreen());

      case Routes.resetPasswordScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ResetPasswordScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const ResetPasswordScreen());

      case Routes.aboutUsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const AboutUsScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const AboutUsScreen());

      case Routes.termsConditionScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const TermsConditionScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const TermsConditionScreen());

      case Routes.partnershipAgencyScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const PartnershipAgencyScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const PartnershipAgencyScreen());

      case Routes.addReviewScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const AddReviewScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const AddReviewScreen());

      case Routes.profileNotificationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ProfileNotificationsScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const ProfileNotificationsScreen());

      case Routes.helpSupportScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const HelpSupportScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const HelpSupportScreen());

      case Routes.addressScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const AdressScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const AdressScreen());

      case Routes.subscriptionScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const SubscriptionScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const SubscriptionScreen());

      case Routes.editProfileScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: EditProfileScreen(
                  employeeId: args['employeeId'],
                  employeeName: args['employeeName'],
                  employeeEmail: args['employeeEmail'],
                  employeePhone: args['employeePhone'],
                  employeeAddress: args['employeeAddress'],
                  employeeGender: args['employeeGender'],
                  employeeDob: args['employeeDob'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => EditProfileScreen(
                      employeeId: args['employeeId'],
                      employeeName: args['employeeName'],
                      employeeEmail: args['employeeEmail'],
                      employeePhone: args['employeePhone'],
                      employeeAddress: args['employeeAddress'],
                      employeeGender: args['employeeGender'],
                      employeeDob: args['employeeDob'],
                    ));

      // * Notification Screen
      case Routes.expenseDetailsScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ExpanseDetailsReport(
                    ammount: args['ammount'],
                    date: args['date'],
                    location: args['location'],
                    category: args['category'],
                    paymentMethod: args['paymentMethod'],
                    attachment: args['attachment'],
                    note: args['note']),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => ExpanseDetailsReport(
                      ammount: args['ammount'],
                      date: args['date'],
                      location: args['location'],
                      category: args['category'],
                      paymentMethod: args['paymentMethod'],
                      attachment: args['attachment'],
                      note: args['note'],
                    ));

      default:
        return null;
    }
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
      : super(
          settings: settings,
          reverseTransitionDuration: const Duration(milliseconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 1),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
              ),
              child: child,
            );
          },
        );
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .5, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: widget,
    );
  }
}
