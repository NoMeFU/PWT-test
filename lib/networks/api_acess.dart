//=========== Auth section =====================================================
import 'package:lawbug829/features/attendance_screen/data/sign_in/rx.dart';
import 'package:lawbug829/features/auth/forget_password/data/send_forget_OTP/forget_pass_rx.dart';
import 'package:lawbug829/features/auth/forget_password/data/verify_email/verify_email_rx.dart';
import 'package:lawbug829/features/auth/forget_password/data/verify_forget_OTP/verify_forget_otp_rx.dart';
import 'package:lawbug829/features/auth/login/sign_in/rx.dart';
import 'package:lawbug829/features/auth/register/data/register/register_rx.dart';
import 'package:lawbug829/features/home/data/post_checkout_notes/post_checkout_notes_rx.dart';
import 'package:lawbug829/features/home/data/rx_checkIn_check_out/rx.dart';
import 'package:lawbug829/features/home/data/rx_home_user_attendance/rx.dart';
import 'package:lawbug829/features/home/model/check_in_check_out_data_model.dart';
import 'package:lawbug829/features/home/model/home_attendance_and_user_info_data.dart';
import 'package:lawbug829/features/note/data/get_daily_update/get_daily_update_rx.dart';
import 'package:lawbug829/features/note/data/get_daily_update_details/get_daily_update_details_rx.dart';
import 'package:lawbug829/features/note/data/get_problem/get_problem_rx.dart';
import 'package:lawbug829/features/note/data/get_problem_details/get_problem_details_rx.dart';
import 'package:lawbug829/features/note/data/post_problem/post_problem_rx.dart';
import 'package:lawbug829/features/note/model/get_daily_model.dart';
import 'package:lawbug829/features/note/model/get_problem_details.dart';
import 'package:lawbug829/features/note/model/get_problem_model.dart';
import 'package:lawbug829/features/profile/data/edit_profile/post_edit_profile_rx.dart';
import 'package:lawbug829/features/profile/data/edit_profile_picture/post_profile_update_rx.dart';
import 'package:lawbug829/features/profile/data/post_delete_profile/delete_account_rx.dart';
import 'package:lawbug829/features/profile/data/get_profile_info/get_profile_rx.dart';
import 'package:lawbug829/features/profile/data/logout_rx.dart';
import 'package:lawbug829/features/profile/data/post_reset_pass/post_reset_pass_rx.dart';
import 'package:lawbug829/features/profile/data/post_review/post_review_rx.dart';
import 'package:lawbug829/features/profile/model/profile_model.dart';
import 'package:lawbug829/features/report/data/get_expense_rx.dart';
import 'package:lawbug829/features/report/data/get_report_rx.dart';
import 'package:lawbug829/features/report/data/post_report_rx.dart';
import 'package:lawbug829/features/report/model/expense_model.dart';
import 'package:lawbug829/features/report/model/working_report_model.dart';
import 'package:lawbug829/features/subscription/check_subscription/check_subscription_rx.dart';
import 'package:lawbug829/features/subscription/model/subscription_check_model.dart';
import 'package:rxdart/rxdart.dart';
import '../features/home/data/checkout_data/checkout_rx.dart';
import '../features/social_login/social_login_rx.dart';

PostGoogleLoginRX postGoogleLoginRX = PostGoogleLoginRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

PostGoogleLoginRX postAppleLoginRX = PostGoogleLoginRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

SignInApiRx postSignInAPIRx = SignInApiRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

PostSignUpRX postSignUpAPIRx = PostSignUpRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

PostLogOutRX postLogOutRX = PostLogOutRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

PostForgetPassRX postForgetPassRX = PostForgetPassRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

ForgetForgetOTPVerifyApi postForgetOTPVerifyApi = ForgetForgetOTPVerifyApi(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

// * =========== Profile section ===========================
GetProfileRX getProfileRXObj = GetProfileRX(
  empty: ProfileModel(),
  dataFetcher: BehaviorSubject<ProfileModel>(),
);

// * =========== Reset Password Section ===========================
PostResetPassApiRX postResetPassApiRXObj = PostResetPassApiRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

DeleteAccountApiRX deleteAccountApiRX = DeleteAccountApiRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

// * =========== Post Rating Section ===========================
PostRatingApiRX postRatingApiRX = PostRatingApiRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

// * =========== Facing Problem Section ===========================
PostProblemApiRX postProblemApiRXObj = PostProblemApiRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

// * =========== Get Problem Section ===========================
GetProblemApiRX getProblemApiRX = GetProblemApiRX(
  empty: GetProblemModel(),
  dataFetcher: BehaviorSubject<GetProblemModel>(),
);

GetProblemDetailsApiRX getProblemDetailsApiRX = GetProblemDetailsApiRX(
  empty: GetProblemDetailsModel(),
  dataFetcher: BehaviorSubject<GetProblemDetailsModel>(),
);

HomeUserAndAttendanceRx homeUserAndAttendanceRx = HomeUserAndAttendanceRx(
  empty: HomeUserAndAttendanceDataModel(),
  dataFetcher: BehaviorSubject<HomeUserAndAttendanceDataModel>(),
);
CheckInCheckOutRx checkInCheckOutRx = CheckInCheckOutRx(
  empty: CheckInCheckOutDataModel(),
  dataFetcher: BehaviorSubject<CheckInCheckOutDataModel>(),
);

// * Post Expense Section ===========================
PostExpenseApiRX postExpenseApiRXObj = PostExpenseApiRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

// * Post Report Section ===========================
PostEditProfileApiRX postEditProfileApiRXObj = PostEditProfileApiRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

// * Post Verify Email ===========================
PostVerifyEmailApiRX postVerifyEmailApiRXObj = PostVerifyEmailApiRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

AttendanceApiRx attendanceApiRx = AttendanceApiRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

CheckoutAttendenceRX checkoutAttendenceRX = CheckoutAttendenceRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

// * Post Checkout Notes ===========================
PostCheckoutNoteApiRX postCheckoutNoteApiRXObj = PostCheckoutNoteApiRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

// * Get Daily Update
GetDailyUpdateApiRX getDailyUpdateApiRXObj = GetDailyUpdateApiRX(
  empty: GetDailyUpdateModel(),
  dataFetcher: BehaviorSubject<GetDailyUpdateModel>(),
);

GetDailyUpdateDetailsApiRX getDailyUpdateDetailsApiRXObj =
    GetDailyUpdateDetailsApiRX(
  empty: GetDailyUpdateModel(),
  dataFetcher: BehaviorSubject<GetDailyUpdateModel>(),
);

GetReportAPIRX getReportAPIRX = GetReportAPIRX(
  empty: GetReportModel(),
  dataFetcher: BehaviorSubject<GetReportModel>(),
);

GetExpenseAPIRX getExpenseAPIRX = GetExpenseAPIRX(
  empty: ExpenseModel(),
  dataFetcher: BehaviorSubject<ExpenseModel>(),
);

// * Post Image Upload Section ===========================
PostImageUploadRx postImageUploadRxObj = PostImageUploadRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

// * Subscription Checker ===========================
GetSubscriptionCheckRX getSubscriptionCheckRXObj = GetSubscriptionCheckRX(
  empty: CheckSubscription(),
  dataFetcher: BehaviorSubject<CheckSubscription>(),
);
