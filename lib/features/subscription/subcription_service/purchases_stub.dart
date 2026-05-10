// Stub file to satisfy the compiler on Web
// ignore_for_file: camel_case_types

class Purchases {
  static Future<void> setLogLevel(dynamic level) async {}
  static Future<void> configure(PurchasesConfiguration configuration) async {}
  static Future<dynamic> logIn(String userId) async { return null; }
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
  final Map<String, dynamic>? all = {};
  final dynamic current = null;
}

class Package {
  final packageType = PackageType.unknown;
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
class LogInResult {}
