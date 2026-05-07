import 'dart:convert';

class GetProblemModel {
  final bool? success;
  final String? message;
  final List<Datum>? data;
  final String? error;

  GetProblemModel({
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory GetProblemModel.fromRawJson(String str) =>
      GetProblemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetProblemModel.fromJson(Map<String, dynamic> json) =>
      GetProblemModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "error": error,
      };
}

class Datum {
  final int? id;
  final String? description;
  final int? userId;
  final DateTime? date;
  final String? location;
  final String? status;
  final dynamic feedback;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Datum({
    this.id,
    this.description,
    this.userId,
    this.date,
    this.location,
    this.status,
    this.feedback,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        description: json["description"],
        userId: json["user_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        location: json["location"],
        status: json["status"],
        feedback: json["feedback"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
