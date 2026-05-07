// import 'dart:convert';
//
// class GetDailyUpdateDetailsModel {
//   final bool? success;
//   final String? message;
//   final List<Datum>? data;
//
//   GetDailyUpdateDetailsModel({
//     this.success,
//     this.message,
//     this.data,
//   });
//
//   factory GetDailyUpdateDetailsModel.fromRawJson(String str) =>
//       GetDailyUpdateDetailsModel.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory GetDailyUpdateDetailsModel.fromJson(Map<String, dynamic> json) =>
//       GetDailyUpdateDetailsModel(
//         success: json["success"],
//         message: json["message"],
//         data: json["data"] == null
//             ? []
//             : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }
//
// class Datum {
//   final int? id;
//   final int? userId;
//   final int? employeeCheckingId;
//   final DateTime? taskDate;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final TotalHours? totalHours;
//   final double? lat;
//   final double? long;
//   final List<NoteDescriptionData>? noteDescriptionsData;
//
//   Datum({
//     this.id,
//     this.userId,
//     this.employeeCheckingId,
//     this.taskDate,
//     this.createdAt,
//     this.updatedAt,
//     this.totalHours,
//     this.lat,
//     this.long,
//     this.noteDescriptionsData,
//   });
//
//   factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         userId: json["user_id"],
//         employeeCheckingId: json["employee_checking_id"],
//         taskDate: json["task_date"] == null
//             ? null
//             : DateTime.parse(json["task_date"]),
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         totalHours: totalHoursValues.map[json["total_hours"]]!,
//         lat: json["lat"]?.toDouble(),
//         long: json["long"]?.toDouble(),
//         noteDescriptionsData: json["descriptions"] == null
//             ? []
//             : List<NoteDescriptionData>.from(
//                 json["descriptions"]!.map((x) => NoteDescriptionData.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "employee_checking_id": employeeCheckingId,
//         "task_date":
//             "${taskDate!.year.toString().padLeft(4, '0')}-${taskDate!.month.toString().padLeft(2, '0')}-${taskDate!.day.toString().padLeft(2, '0')}",
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "total_hours": totalHoursValues.reverse[totalHours],
//         "lat": lat,
//         "long": long,
//         "descriptions": noteDescriptionsData == null
//             ? []
//             : List<dynamic>.from(noteDescriptionsData!.map((x) => x.toJson())),
//       };
// }
//
// class NoteDescriptionData {
//   final int? id;
//   final int? dailyTaskId;
//   final TaskName? taskName;
//   final String? description;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   NoteDescriptionData({
//     this.id,
//     this.dailyTaskId,
//     this.taskName,
//     this.description,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory NoteDescriptionData.fromRawJson(String str) =>
//       NoteDescriptionData.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory NoteDescriptionData.fromJson(Map<String, dynamic> json) => NoteDescriptionData(
//         id: json["id"],
//         dailyTaskId: json["daily_task_id"],
//         taskName: taskNameValues.map[json["task_name"]]!,
//         description: json["description"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "daily_task_id": dailyTaskId,
//         "task_name": taskNameValues.reverse[taskName],
//         "description": description,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
//
// enum TaskName { PLAN_MEETING, PLAN_MEETING_14, TASK_1, TASK_2, TASK_3 }
//
// final taskNameValues = EnumValues({
//   "Plan Meeting": TaskName.PLAN_MEETING,
//   "Plan Meeting 14": TaskName.PLAN_MEETING_14,
//   "Task 1": TaskName.TASK_1,
//   "Task 2": TaskName.TASK_2,
//   "Task 3": TaskName.TASK_3
// });
//
// enum TotalHours { THE_0_HOURS_0_MIN, THE_4_HOURS_0_MIN }
//
// final totalHoursValues = EnumValues({
//   "0 Hours 0 min": TotalHours.THE_0_HOURS_0_MIN,
//   "4 Hours 0 min": TotalHours.THE_4_HOURS_0_MIN
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
