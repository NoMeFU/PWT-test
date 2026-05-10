// #################################################################################
// ignore_for_file: unnecessary_null_comparison, unused_field, unused_local_variable
import 'dart:developer';
import 'package:flutter/foundation.dart'; // Added for kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lawbug829/constants/app_constants.dart';
import 'package:lawbug829/helpers/di.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:purchases_flutter/purchases_flutter.dart' if (dart.library.html) 'purchases_stub.dart';

class PurchaseProvider extends ChangeNotifier {
  dynamic _purchaserInfo;
  List<dynamic> availablePackages = [];
  dynamic _selectedPackage;
  bool _isPremium = false;
  bool _isLoading = false;
  bool _isTrialAvailable = false;

  List<dynamic> get packages => availablePackages;
  dynamic get selectedPackage => _selectedPackage;
  bool get isPremium => _isPremium;
  bool get isLoading => _isLoading;
  bool get isTrialAvailable => _isTrialAvailable;

  Future<void> init() async {
    try {
      log("Initializing PurchaseProvider...");
      _isLoading = true;
      notifyListeners();

      await checkSubscriptionStatus();
      await fetchSubscriptions();

      log("PurchaseProvider initialized successfully");
    } catch (e) {
      log("Error in PurchaseProvider.init(): \${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSubscriptions() async {
    try {
      _isLoading = true;
      notifyListeners();

      if (kIsWeb) {
        log("Skipping fetchSubscriptions on Web");
        availablePackages = [];
        return;
      }

      final offerings = await Purchases.getOfferings();
      final currentOffering = offerings.all;
      dynamic monthlyPackage;
      dynamic yearlyPackage;

      if (currentOffering != null) {
        final allPackages = currentOffering.values
            .expand((offering) => offering.availablePackages)
            .toList();

        for (var package in allPackages) {
          if (package.packageType == PackageType.monthly) {
            monthlyPackage = package;
          } else if (package.packageType == PackageType.annual) {
            yearlyPackage = package;
          }
        }
      }

      availablePackages = [
        monthlyPackage,
        yearlyPackage,
      ].where((pkg) => pkg != null).toList();

      log("Fetched packages count: \${availablePackages.length}");
      
      _isTrialAvailable =
          monthlyPackage?.storeProduct.introductoryPrice != null;
    } catch (e) {
      log("Error fetching offers: \${e.toString()}");
      availablePackages = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> purchaseSubscription({required String type}) async {
    try {
      _isLoading = true;
      notifyListeners();

      if (kIsWeb) {
        log("purchaseSubscription bypassed on Web");
        return true; 
      }

      if (availablePackages.isEmpty) {
        log("No available subscriptions");
        return false;
      }

      dynamic pkgToPurchase;
      for (var package in availablePackages) {
        if (type == "monthly" && package.packageType == PackageType.monthly) {
          pkgToPurchase = package;
          break;
        } else if (type == "yearly" &&
            package.packageType == PackageType.annual) {
          pkgToPurchase = package;
          break;
        }
      }

      if (pkgToPurchase == null) {
        log("Requested package type (\$type) not found.");
        return false;
      }

      final purchaserInfo = await Purchases.purchasePackage(pkgToPurchase);
      _purchaserInfo = purchaserInfo;
      
      if (purchaserInfo.entitlements.all['pro']?.isActive ?? false) {
        _isPremium = true;
        log("Purchase successful! Premium access granted.");
        checkSubscriptionStatus();
        return true;
      }
      return false;
    } catch (error) {
      log("An error occurred during purchase: \$error");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> restorePurchases() async {
    try {
      _isLoading = true;
      notifyListeners();

      if (kIsWeb) {
        log("restorePurchases bypassed on Web");
        return true;
      }

      final purchaserInfo = await Purchases.restorePurchases();

      if (purchaserInfo.entitlements.all['pro']?.isActive ?? false) {
        _isPremium = true;
        checkSubscriptionStatus();
        log("Purchases restored successfully.");
      } else {
        _isPremium = false;
        ToastUtil.showLongToast('No premium entitlement found.');
      }
    } catch (error) {
      log("Error restoring purchases: \$error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return _isPremium;
  }

  Future<void> checkSubscriptionStatus() async {
    try {
      if (kIsWeb) {
        log("checkSubscriptionStatus bypassed on Web");
        return;
      }

      final id = await appData.read(kKeyUserID);
      await Purchases.logIn(id ?? 'anonymous');
      final purchaserInfo = await Purchases.getCustomerInfo();
      _purchaserInfo = purchaserInfo;
      _isPremium = purchaserInfo.entitlements.all["pro"]?.isActive ?? false;
      log("User Subscription Status: \$_isPremium");
    } catch (e) {
      log("Error checking subscription status: \$e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> checkFreeTrialEligibility() async {
    try {
      if (kIsWeb) {
        _isTrialAvailable = false;
        return;
      }

      final offerings = await Purchases.getOfferings();
      final currentOffering = offerings.current;

      if (currentOffering != null) {
        final monthlyPackage = currentOffering.monthly;
        _isTrialAvailable = monthlyPackage?.storeProduct.introductoryPrice != null;
      }
    } catch (error) {
      log("Error checking free trial eligibility: \$error");
    } finally {
      notifyListeners();
    }
  }
}
