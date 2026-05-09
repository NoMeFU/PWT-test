import 'dart:convert';

class HomeUserAndAttendanceDataModel {
  final bool? success;
  final String? message;
  final Data? data;

  HomeUserAndAttendanceDataModel({
    this.success,
    this.message,
    this.data,
  });

  factory HomeUserAndAttendanceDataModel.fromRawJson(String str) => HomeUserAndAttendanceDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeUserAndAttendanceDataModel.fromJson(Map<String, dynamic> json) => HomeUserAndAttendanceDataModel(
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
  final User? user;
  final List<Attendance>? attendance;

  Data({
    this.user,
    this.attendance,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    attendance: json["attendance"] == null ? [] : List<Attendance>.from(json["attendance"]!.map((x) => Attendance.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "attendance": attendance == null ? [] : List<dynamic>.from(attendance!.map((x) => x.toJson())),
  };
}

class Attendance {
  final String? role;
  final DateTime? date;
  final String? checkIn;
  final String? checkOut;
  final String? totalHours;
  final double? lat;
  final double? long;

  Attendance({
    this.role,
    this.date,
    this.checkIn,
    this.checkOut,
    this.totalHours,
    this.lat,
    this.long,
  });

  factory Attendance.fromRawJson(String str) => Attendance.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    role: json["role"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    checkIn: json["check_in"],
    checkOut: json["check_out"],
    totalHours: json["total_hours"],
    lat: json["lat"] is String ? double.tryParse(json["lat"] as String) : (json["lat"] as num?)?.toDouble(),
    long: json["long"] is String ? double.tryParse(json["long"] as String) : (json["long"] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "role": role,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "check_in": checkIn,
    "check_out": checkOut,
    "total_hours": totalHours,
    "lat": lat,
    "long": long,
  };
}

class User {
  final int? id;
  final String? name;
  final String? avatar;
  final int? workingDays;

  User({
    this.id,
    this.name,
    this.avatar,
    this.workingDays,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
    workingDays: json["working_days"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
    "working_days": workingDays,
  };
}
