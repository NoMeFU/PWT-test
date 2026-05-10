import 'dart:developer';
import 'package:flutter/foundation.dart'; // Added for kIsWeb
import 'package:purchases_flutter/purchases_flutter.dart' if (dart.library.html) 'purchases_stub.dart';
import 'package:lawbug829/helpers/platform_helper.dart';

final class PurchaseHelper {
  static bool isConfigured = false;

  static String get _apiKey => SafePlatform.isIOS
      ? 'appl_KRGrpiexvdKwLrAnMkJCnWnXbcO' // Replace with your iOS key
      : 'goog_vTVgDDgLoAimnZzqmAEkgyOxYKH'; // Replace with your Android key


  /// Initialize RevenueCat with optional app user ID
  static Future<void> init({required String? id}) async {
    if (kIsWeb) {
      log("Skipping PurchaseHelper.init on Web");
      return;
    }

    if (isConfigured) {
      log("✅ Purchases already configured. Skipping re-init.");
      return;
    }

    try {
      await Purchases.setLogLevel(LogLevel.debug);

      final dynamic config = PurchasesConfiguration(_apiKey)..appUserID = id;
      await Purchases.configure(config);

      isConfigured = true;
      log("✅ Purchases configured with user ID: $id");
    } catch (e, stack) {
      log("❌ Failed to configure Purchases: $e", stackTrace: stack);
    } finally {
      logOut(id);
    }
  }

  /// Log in user to RevenueCat manually if needed
  static Future<void> logIn(String userId) async {
    if (kIsWeb) return;
    try {
      await Purchases.logIn(userId);
      log("🔐 RevenueCat login success for $userId");
      hasActiveSubscription();
    } catch (e) {
      log("❌ RevenueCat login failed: $e");
    }
  }

  /// Log out user
  static Future<void> logOut(id) async {
    if (kIsWeb) return;
    try {
      await Purchases.logOut();
      log("🚪 RevenueCat logout successful.");
      logIn(id ?? 'guest_user');
    } catch (e) {
      log("❌ RevenueCat logout failed: $e");
    }
  }

  /// Check if user has active subscription
  static Future<bool> hasActiveSubscription() async {
    if (kIsWeb) return false;
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      final isActive = customerInfo.entitlements.active.isNotEmpty;
      log("🔍 Active Subscription: $isActive");
      return isActive;
    } catch (e) {
      log("❌ Error fetching customer info: $e");
      return false;
    }
  }
}
