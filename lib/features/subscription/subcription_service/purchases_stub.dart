import 'dart:developer';

/// Stub classes for RevenueCat (purchases_flutter) to satisfy Web builds
class Purchases {
  static Future<void> setLogLevel(String level) async {}
  static Future<void> configure(dynamic configuration) async {}
  static Future<Offerings> getOfferings() async => Offerings();
  static Future<CustomerInfo> purchasePackage(dynamic package) async => CustomerInfo();
  static Future<CustomerInfo> restorePurchases() async => CustomerInfo();
  static Future<LogInResult> logIn(String userId) async => LogInResult();
  static Future<void> logOut() async {}
  static Future<CustomerInfo> getCustomerInfo() async => CustomerInfo();
}

class PurchasesConfiguration {
  final String apiKey;
  String? appUserID;
  PurchasesConfiguration(this.apiKey);
}

class LogLevel {
  static const debug = 'debug';
}

class Offerings {
  final Map<String, Offering> all = {};
  Offering? get current => null;
}

class Offering {
  final String identifier = 'mock';
  final List<Package> availablePackages = [];
  Package? get monthly => null;
}

class Package {
  final String identifier = 'mock_pkg';
  final dynamic packageType = 'monthly';
  final StoreProduct storeProduct = StoreProduct();
}

class PackageType {
  static const monthly = 'monthly';
  static const annual = 'annual';
}

class StoreProduct {
  final String identifier = 'mock_id';
  final String description = 'Mock Description';
  final String title = 'Mock Title';
  final double price = 0.0;
  final String priceString = '\$0.00';
  final dynamic introductoryPrice = null;
}

class CustomerInfo {
  final EntitlementInfos entitlements = EntitlementInfos();
}

class EntitlementInfos {
  final Map<String, EntitlementInfo> all = {};
  final Map<String, EntitlementInfo> active = {};
}

class EntitlementInfo {
  final bool isActive = false;
}

class LogInResult {
  final CustomerInfo customerInfo = CustomerInfo();
  final bool created = false;
}
