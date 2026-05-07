// #################################################################################
// ignore_for_file: unnecessary_null_comparison, unused_field, unused_local_variable
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lawbug829/constants/app_constants.dart';
import 'package:lawbug829/helpers/di.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseProvider extends ChangeNotifier {
  CustomerInfo? _purchaserInfo;
  List<Package> availablePackages = [];
  Package? _selectedPackage;
  bool _isPremium = false;
  bool _isLoading = false;
  bool _isTrialAvailable = false;

  List<Package> get packages => availablePackages;
  Package? get selectedPackage => _selectedPackage;
  bool get isPremium => _isPremium;
  bool get isLoading => _isLoading;
  bool get isTrialAvailable => _isTrialAvailable;

  // * comment by nurnabi + nayem
  // * #########################
  // PurchaseProvider() {
  //   init();
  // }
  // * #########################

  // PurchaseProvider
  Future<void> init() async {
    try {
      log("Initializing PurchaseProvider...");
      _isLoading = true;
      notifyListeners();

      await checkSubscriptionStatus();
      await fetchSubscriptions();

      log("PurchaseProvider initialized successfully");
    } catch (e) {
      log("Error in PurchaseProvider.init(): ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSubscriptions() async {
    try {
      _isLoading = true;
      notifyListeners();

      final offerings = await Purchases.getOfferings();
      final currentOffering = offerings.all;
      Package? monthlyPackage;
      Package? yearlyPackage;

      if (currentOffering != null) {
        final allPackages = currentOffering.values
            .expand((offering) => offering.availablePackages)
            .toList();

        for (var package in allPackages) {
          switch (package.packageType) {
            case PackageType.monthly:
              monthlyPackage = package;
              break;
            case PackageType.annual:
              yearlyPackage = package;
              break;
            default:
              break;
          }
        }
      } else {
        log("No offerings available.");
      }

      availablePackages = [
        monthlyPackage,
        yearlyPackage,
      ].whereType<Package>().toList();

      log("Fetched packages: ${availablePackages.map((pkg) => pkg.toString()).toList()}");
      // * Fetch all data from entitlement
      for (var pkg in availablePackages) {
        log("Package Identifier: ${pkg.identifier}");
        log("Package Type: ${pkg.packageType}");
        log("Package Product: ${pkg.storeProduct.toString()}");
        log("Package Price: ${pkg.storeProduct.priceString}");
        log("Package Introductory Price: ${pkg.storeProduct.introductoryPrice}");
        log("Package Introductory Price: ${pkg.storeProduct.description}");
      }

      _isTrialAvailable =
          monthlyPackage?.storeProduct.introductoryPrice != null;
      log("Free trial availability: $_isTrialAvailable");
    } on PlatformException catch (e) {
      log("Error fetching offers: ${e.message}");
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

      if (availablePackages.isEmpty) {
        log("No available subscriptions");
        return false;
      }

      Package? selectedPackage;
      for (var package in availablePackages) {
        if (type == "monthly" && package.packageType == PackageType.monthly) {
          selectedPackage = package;
          break;
        } else if (type == "yearly" &&
            package.packageType == PackageType.annual) {
          selectedPackage = package;
          break;
        }
      }

      if (selectedPackage == null) {
        log("Requested package type ($type) not found.");
        return false;
      }

      log("Attempting purchase for package: ${selectedPackage.identifier}");

      final purchaserInfo = await Purchases.purchasePackage(selectedPackage);

      _purchaserInfo = purchaserInfo;
      log("PurchaserInfo: $purchaserInfo");

      // * #####################################
      // * Must check entitlement after purchase
      // * #####################################
      if (purchaserInfo.entitlements.all['pro']?.isActive ?? false) {
        _isPremium = true;
        //await appData.write(kKeyIsSubscribed, _isPremium);

        // need to profile api hit.
        // alada api nile besi valo hobe
        log("Purchase successful! Premium access granted.");

        checkSubscriptionStatus();
        notifyListeners();
        return true;
      } else {
        log("Purchase completed, but no premium entitlement granted.");
        return false;
      }
    } on PurchasesErrorCode catch (e) {
      log("Purchase failed with error: ${e.toString()}");
      return false;
    } catch (error) {
      log("An unknown error occurred during purchase: $error");
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
      final purchaserInfo = await Purchases.restorePurchases();

      if (purchaserInfo.entitlements.all['pro']?.isActive ?? false) {
        _isPremium = true;
        // await appData.write(kKeyIsSubscribed, _isPremium);

        // Get.to(() => NavigationScreen());
        checkSubscriptionStatus();
        log("Purchases restored successfully. Premium access granted.");
        //return true;
      } else {
        _isPremium = false;
        // await appData.write(kKeyIsSubscribed, _isPremium);
        ToastUtil.showLongToast(
            'No premium entitlement found after restoring purchases.');
        log("No premium entitlement found after restoring purchases.");
        // return false;
      }
    } catch (error) {
      log("Error restoring purchases: $error");
      // return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return _isPremium;
  }

  Future<void> checkSubscriptionStatus() async {
    final id = await appData.read(kKeyUserID);
    try {
      LogInResult result = await Purchases.logIn(id ?? 'anonymous');
      log("LogInResult: ${result.customerInfo}");
      final purchaserInfo = await Purchases.getCustomerInfo();
      _purchaserInfo = purchaserInfo;

      log("Active Subscriptions: ${purchaserInfo.activeSubscriptions}");
      log("All Purchased Products: ${purchaserInfo.allPurchasedProductIdentifiers}");
      log("Entitlements: ${purchaserInfo.entitlements.all}");
      log("Pro Entitlement Active: ${purchaserInfo.entitlements.all['pro']?.isActive ?? false}");

      _isPremium = purchaserInfo.entitlements.all["pro"]?.isActive ?? false;
      // await appData.write(kKeyIsSubscribed, _isPremium);
      log("User Subscription Status: $_isPremium");
    } catch (e) {
      log("Error checking subscription status: $e");
      _isPremium = false;
      // await appData.write(kKeyIsSubscribed, _isPremium);
    } finally {
      notifyListeners();
    }
  }

  Future<void> checkFreeTrialEligibility() async {
    try {
      final offerings = await Purchases.getOfferings();
      final currentOffering = offerings.current;

      if (currentOffering != null) {
        final monthlyPackage = currentOffering.monthly;
        _isTrialAvailable =
            monthlyPackage?.storeProduct.introductoryPrice != null;
        log("Free trial eligibility: $_isTrialAvailable");
      } else {
        _isTrialAvailable = false;
        log("No current offering available to check free trial.");
      }
    } catch (error) {
      log("Error checking free trial eligibility: $error");
      _isTrialAvailable = false;
    } finally {
      notifyListeners();
    }
  }
}
