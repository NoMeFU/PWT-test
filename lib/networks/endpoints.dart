// ignore_for_file: constant_identifier_names

// const String url = String.fromEnvironment("BASE_URL");
const String url = "https://mypwtracker.com";
const String imageUrls = "$url/";

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "en";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE", defaultValue: "default_app_key_here");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class Endpoints {
  Endpoints._();
  // * Authentication API
  static String logIn() => "/api/login";
  static String register() => "/api/register";
  static String logout() => "/api/logout";
  static String forgetPass() => "/api/forget-password";
  static String verifyForgetOtp() => "/api/verify-otp";
  static String verifyEmail() => "/api/verify-email";

  // * Profile API
  static String viewProfile() => "/api/view-profile";

  // * Reset Password API
  static String postResetPass() => "/api/update-password";

  // * Delete Account API
  static String deleteAccount() => "/api/delete-account";

  // * Post Review API
  static String postRating() => "/api/ratting";

  // * Post Facing Problem API
  static String postFacingProblem() => "/api/facing-problem";
  static String getFacingProblem() => "/api/facing-problems";
  static String getFacingProblemDetails(dynamic id) =>
      "/api/facing-problem/$id";

  // * post Report API
  static String postExpense() => "/api/expanse-money";

  // * Post Edit Profile API
  static String postEditProfile() => "/api/update-profile";

  // * >>>>>>>>>>>>>>>>>>>>>>>>>> attendance section ??????????????????????
  static String attendancePresentApiLink() => "/api/attendance";

  // * >>>>>>>>>>>>>>>>>>>> home section >>>>>>>>>>>>>>>>>>>>>>>
  static String homeUserAndAttendanceApiLink() => "/api/checking/history";
  static String checkInCheckOutApiLink() => "/api/attendance/today";

  // * >>>>>>>>>>>>>>>>>>>> checkout note section >>>>>>>>>>>>>>>>>>>>>>>
  static String postCheckoutNote() => "/api/create-daily-update-task";

  // * ===============> Daily Update Model
  static String dailyUpdate() => "/api/daily-update-task";
  static String dailyUpdateDetails() => "/api/daily-update-task";

  // * GET Report API
  static String getReport() => "/api/report-screen";
  static String getExpense() => "/api/expanses-list";

  // * upload image API
  static String postImageUploadApi() => "/api/upload-avatar";

  // *** google and Apple Login
  static String googleLogin() => "/api/social-login";

  // * subscription checking api
  static String checkSubscription() => "/api/subscription/check";
}
