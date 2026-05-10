// Stub file to satisfy the compiler on Web
// ignore_for_file: camel_case_types

class Purchases {
  static Future<void> setLogLevel(dynamic level) async {}
  static Future<void> configure(PurchasesConfiguration configuration) async {}
  static Future<LogInResult> logIn(String userId) async { return LogInResult(); }
  static Future<void> logOut() async {}
  static Future<CustomerInfo> getCustomerInfo() async { return CustomerInfo(); }
  static Future<Offerings> getOfferings() async { return Offerings(); }
  static Future<CustomerInfo> purchasePackage(dynamic package) async { return CustomerInfo(); }
  static Future<CustomerInfo> restorePurchases() async { return CustomerInfo(); }
}

class PurchasesConfiguration {
  final String apiKey;
  String? appUserID;
  PurchasesConfiguration(this.apiKey);
}

class LogLevel {
  static const debug = 'debug';
  static const info = 'info';
  static const warn = 'warn';
  static const error = 'error';
}

class CustomerInfo {
  final entitlements = EntitlementInfos();
}

class EntitlementInfos {
  final all = <String, EntitlementInfo>{};
  final active = <String, EntitlementInfo>{};
}

class EntitlementInfo {
  final bool isActive = false;
}

class Offerings {
  final Map<String, Offering> all = {};
  final Offering? current = null;
}

class Offering {
  final List<Package> availablePackages = [];
  final Package? monthly = null;
  final Package? annual = null;
  final Package? lifetime = null;
}

class Package {
  final String packageType = PackageType.unknown;
  final StoreProduct storeProduct = StoreProduct();
}

class StoreProduct {
  final dynamic introductoryPrice = null;
  final String priceString = "";
  final String title = "";
  final String description = "";
  final double price = 0.0;
}

class PackageType {
  static const unknown = 'unknown';
  static const monthly = 'monthly';
  static const annual = 'annual';
  static const custom = 'custom';
  static const lifetime = 'lifetime';
  static const sixMonth = 'sixMonth';
  static const threeMonth = 'threeMonth';
  static const twoMonth = 'twoMonth';
  static const weekly = 'weekly';
}

class PurchasesErrorCode {}
class LogInResult {
  final CustomerInfo customerInfo = CustomerInfo();
}

