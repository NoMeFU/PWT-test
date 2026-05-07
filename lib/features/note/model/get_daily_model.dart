import 'dart:convert';
class GetDailyUpdateModel {
  final bool? success;
  final String? message;
  final List<Datum>? data;
  final String? error;

  GetDailyUpdateModel({
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory GetDailyUpdateModel.fromRawJson(String str) =>
      GetDailyUpdateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetDailyUpdateModel.fromJson(Map<String, dynamic> json) =>
      GetDailyUpdateModel(
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
  final int? userId;
  final DateTime? taskDate;
  final double? lat;
  final double? long;
  final String? totalHours;
  final List<DescriptionDataModelsssss>? descriptions;

  Datum({
    this.id,
    this.userId,
    this.taskDate,
    this.lat,
    this.long,
    this.totalHours,
    this.descriptions,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        taskDate: json["task_date"] == null
            ? null
            : DateTime.parse(json["task_date"]),
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
        totalHours: json["total_hours"],
        descriptions: json["descriptions"] == null
            ? []
            : List<DescriptionDataModelsssss>.from(
                json["descriptions"]!.map((x) => DescriptionDataModelsssss.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "task_date":
            "${taskDate!.year.toString().padLeft(4, '0')}-${taskDate!.month.toString().padLeft(2, '0')}-${taskDate!.day.toString().padLeft(2, '0')}",
        "lat": lat,
        "long": long,
        "total_hours": totalHours,
        "descriptions": descriptions == null
            ? []
            : List<dynamic>.from(descriptions!.map((x) => x.toJson())),
      };
}

class DescriptionDataModelsssss {
  final int? id;
  final int? dailyTaskId;
  final String? taskName;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DescriptionDataModelsssss({
    this.id,
    this.dailyTaskId,
    this.taskName,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory DescriptionDataModelsssss.fromRawJson(String str) =>
      DescriptionDataModelsssss.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DescriptionDataModelsssss.fromJson(Map<String, dynamic> json) => DescriptionDataModelsssss(
        id: json["id"],
        dailyTaskId: json["daily_task_id"],
        taskName: json["task_name"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "daily_task_id": dailyTaskId,
        "task_name": taskName,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
