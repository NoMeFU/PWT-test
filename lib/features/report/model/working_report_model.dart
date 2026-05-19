import 'dart:convert';
import 'package:flutter/material.dart';

class GetReportModel {
  final bool? success;
  final String? message;
  final Data? data;

  GetReportModel({this.success, this.message, this.data});

  factory GetReportModel.fromRawJson(String str) =>
      GetReportModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetReportModel.fromJson(Map<String, dynamic> json) => GetReportModel(
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
  final dynamic totalEarning;
  final dynamic totalExpense;
  final TotalDutyTime? totalDutyTime;
  final List<ChackingHistory>? chackingHistory;
  final List<ExpenseHistory>? expenseHistory;

  Data({
    this.totalEarning,
    this.totalExpense,
    this.totalDutyTime,
    this.chackingHistory,
    this.expenseHistory,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalEarning: json["total_earning"],
        totalExpense: json["total_expense"],
        totalDutyTime: json["total_duty_time"] == null
            ? null
            : TotalDutyTime.fromJson(json["total_duty_time"]),
        chackingHistory: json["chacking_history"] == null
            ? []
            : List<ChackingHistory>.from(json["chacking_history"]
                .map((x) => ChackingHistory.fromJson(x))),
        expenseHistory: json["expense_history"] == null
            ? []
            : List<ExpenseHistory>.from(
                json["expense_history"].map((x) => ExpenseHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_earning": totalEarning,
        "total_expense": totalExpense,
        "total_duty_time": totalDutyTime?.toJson(),
        "chacking_history": chackingHistory?.map((x) => x.toJson()).toList(),
        "expense_history": expenseHistory?.map((x) => x.toJson()).toList(),
      };
}

class TotalDutyTime {
  final dynamic years;
  final dynamic days;
  final dynamic minutes;

  TotalDutyTime({this.years, this.days, this.minutes});

  factory TotalDutyTime.fromJson(Map<String, dynamic> json) => TotalDutyTime(
        years: json["years"],
        days: json["days"],
        minutes: json["minutes"],
      );

  Map<String, dynamic> toJson() => {
        "years": years,
        "days": days,
        "minutes": minutes,
      };
}

class ChackingHistory {
  final dynamic id;
  final dynamic userId;
  final dynamic employeeCheckingId;
  final DateTime? earningDate;
  final String? role;
  final String? salary;
  final String? workingHours;
  final dynamic vat;
  final String? totalSalary;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final EmployeeChecking? employeeChecking;

  ChackingHistory({
    this.id,
    this.userId,
    this.employeeCheckingId,
    this.earningDate,
    this.role,
    this.salary,
    this.workingHours,
    this.vat,
    this.totalSalary,
    this.createdAt,
    this.updatedAt,
    this.employeeChecking,
  });

  factory ChackingHistory.fromJson(Map<String, dynamic> json) =>
      ChackingHistory(
        id: json["id"],
        userId: json["user_id"],
        employeeCheckingId: json["employee_checking_id"],
        earningDate: _parseDate(json["earning_date"]),
        role: json["role"],
        salary: json["salary"],
        workingHours: json["working_hours"],
        vat: json["vat"],
        totalSalary: json["total_salary"],
        createdAt: _parseDate(json["created_at"]),
        updatedAt: _parseDate(json["updated_at"]),
        employeeChecking: json["employee_checking"] == null
            ? null
            : EmployeeChecking.fromJson(json["employee_checking"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employee_checking_id": employeeCheckingId,
        "earning_date": earningDate?.toIso8601String(),
        "role": role,
        "salary": salary,
        "working_hours": workingHours,
        "vat": vat,
        "total_salary": totalSalary,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "employee_checking": employeeChecking?.toJson(),
      };
}

class EmployeeChecking {
  final dynamic id;
  final dynamic userId;
  final String? role;
  final dynamic currentLocation;
  final double? lat;
  final double? long;
  final String? status;
  final DateTime? date;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final String? totalHours;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  EmployeeChecking({
    this.id,
    this.userId,
    this.role,
    this.currentLocation,
    this.lat,
    this.long,
    this.status,
    this.date,
    this.checkIn,
    this.checkOut,
    this.totalHours,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory EmployeeChecking.fromJson(Map<String, dynamic> json) =>
      EmployeeChecking(
        id: json["id"],
        userId: json["user_id"],
        role: json["role"],
        currentLocation: json["current_location"],
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
        status: json["status"],
        date: _parseDate(json["date"]),
        checkIn: _parseDateOrTime(json["check_in"]),
        checkOut: _parseDateOrTime(json["check_out"]),
        totalHours: json["total_hours"],
        type: json["type"],
        createdAt: _parseDate(json["created_at"]),
        updatedAt: _parseDate(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "role": role,
        "current_location": currentLocation,
        "lat": lat,
        "long": long,
        "status": status,
        "date": date?.toIso8601String(),
        "check_in": checkIn?.toIso8601String(),
        "check_out": checkOut?.toIso8601String(),
        "total_hours": totalHours,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class ExpenseHistory {
  final dynamic id;
  final dynamic userId;
  final dynamic amountSpent;
  final DateTime? date;
  final String? category;
  final String? paymentMethod;
  final String? location;
  final String? description;
  final String? file;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ExpenseHistory({
    this.id,
    this.userId,
    this.amountSpent,
    this.date,
    this.category,
    this.paymentMethod,
    this.location,
    this.description,
    this.file,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory ExpenseHistory.fromJson(Map<String, dynamic> json) => ExpenseHistory(
        id: json["id"],
        userId: json["user_id"],
        amountSpent: json["amount_spent"],
        date: _parseDate(json["date"]),
        category: json["category"],
        paymentMethod: json["payment_method"],
        location: json["location"],
        description: json["description"],
        file: json["file"],
        type: json["type"],
        createdAt: _parseDate(json["created_at"]),
        updatedAt: _parseDate(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "amount_spent": amountSpent,
        "date": date?.toIso8601String(),
        "category": category,
        "payment_method": paymentMethod,
        "location": location,
        "description": description,
        "file": file,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

DateTime? _parseDate(String? input) {
  if (input == null) return null;
  try {
    if (!input.contains('Z') && !input.contains('+') && !input.contains('-') && input.length >= 19) {
      String formattedStr = input.replaceAll(' ', 'T');
      return DateTime.parse('${formattedStr}Z').toLocal();
    }
    return DateTime.parse(input).toLocal();
  } catch (e) {
    debugPrint('Date parse error: $input');
    return null;
  }
}

DateTime? _parseDateOrTime(String? input) {
  if (input == null) return null;
  try {
    if (!input.contains('Z') && !input.contains('+') && !input.contains('-') && input.length >= 19) {
      String formattedStr = input.replaceAll(' ', 'T');
      return DateTime.parse('${formattedStr}Z').toLocal();
    }
    return DateTime.parse(input).toLocal();
  } catch (e) {
    try {
      final parts = input.split(":");
      if (parts.length >= 2) {
        final now = DateTime.now();
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        final second = parts.length > 2 ? int.parse(parts[2]) : 0;
        return DateTime(now.year, now.month, now.day, hour, minute, second).toLocal();
      }
    } catch (_) {}
    debugPrint('Time-only parse error: $input');
    return null;
  }
}
