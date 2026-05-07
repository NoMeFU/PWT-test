import 'dart:convert';

class CheckSubscription {
  final bool? success;
  final String? message;
  final Data? data;

  CheckSubscription({
    this.success,
    this.message,
    this.data,
  });

  factory CheckSubscription.fromRawJson(String str) =>
      CheckSubscription.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckSubscription.fromJson(Map<String, dynamic> json) =>
      CheckSubscription(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final bool? isSubscribed;

  Data({
    this.isSubscribed,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        isSubscribed: json["is_subscribed"],
      );

  Map<String, dynamic> toJson() => {
        "is_subscribed": isSubscribed,
      };
}
