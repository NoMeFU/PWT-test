import 'dart:convert';

class ProfileModel {
    final bool? success;
    final String? message;
    final Data? data;
    final String? error;

    ProfileModel({
        this.success,
        this.message,
        this.data,
        this.error,
    });

    factory ProfileModel.fromRawJson(String str) => ProfileModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
    final String? employeeId;
    final String? name;
    final String? email;
    final String? phone;
    final String? countryCode;
    final String? address;
    final dynamic avatar;
    final String? dob;
    final String? gender;

    Data({
        this.id,
        this.employeeId,
        this.name,
        this.email,
        this.phone,
        this.countryCode,
        this.address,
        this.avatar,
        this.dob,
        this.gender,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        employeeId: json["employee_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        countryCode: json["country_code"],
        address: json["address"],
        avatar: json["avatar"],
        dob: json["dob"],
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "name": name,
        "email": email,
        "phone": phone,
        "country_code": countryCode,
        "address": address,
        "avatar": avatar,
        "dob": dob,
        "gender": gender,
    };
}
