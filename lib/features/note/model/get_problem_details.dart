import 'dart:convert';

class GetProblemDetailsModel {
  final bool? success;
  final String? message;
  final Data? data;
  final String? error;

  GetProblemDetailsModel({
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory GetProblemDetailsModel.fromRawJson(String str) =>
      GetProblemDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetProblemDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetProblemDetailsModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "error": error,
      };
}

class Data {
  final int? id;
  final String? description;
  final int? userId;
  final DateTime? date;
  final String? location;
  final String? status;
  final String? feedback;

  Data({
    this.id,
    this.description,
    this.userId,
    this.date,
    this.location,
    this.status,
    this.feedback,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        description: json["description"],
        userId: json["user_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        location: json["location"],
        status: json["status"],
        feedback: json["feedback"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "user_id": userId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "location": location,
        "status": status,
        "feedback": feedback,
      };
}
