import 'dart:convert';

class ExpenseModel {
    final bool? success;
    final String? message;
    final List<Datum>? data;

    ExpenseModel({
        this.success,
        this.message,
        this.data,
    });

    factory ExpenseModel.fromRawJson(String str) => ExpenseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    final int? id;
    final int? userId;
    final int? amountSpent;
    final DateTime? date;
    final String? category;
    final String? paymentMethod;
    final String? location;
    final String? description;
    final String? file;
    final String? type;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Datum({
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

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        amountSpent: json["amount_spent"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        category: json["category"],
        paymentMethod: json["payment_method"],
        location: json["location"],
        description: json["description"],
        file: json["file"],
        type: json["type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
