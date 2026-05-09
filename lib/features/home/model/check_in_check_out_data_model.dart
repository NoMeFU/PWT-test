class CheckInCheckOutDataModel {
  bool? success;
  String? message;
  List<CheckInData>? data;
  String? error;

  CheckInCheckOutDataModel({this.success, this.message, this.data, this.error});

  CheckInCheckOutDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CheckInData>[];
      json['data'].forEach((v) {
        data!.add(new CheckInData.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    return data;
  }
}

class CheckInData {
  num? id;
  num? userId;
  String? role;
  Null currentLocation;
  double? lat;
  double? long;
  String? status;
  String? date;
  String? checkIn;
  String? checkOut;
  String? totalHours;
  String? createdAt;
  String? updatedAt;

  CheckInData(
      {this.id,
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
        this.createdAt,
        this.updatedAt});

  CheckInData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    role = json['role'];
    currentLocation = json['current_location'];
    lat = json['lat'] is String ? double.tryParse(json['lat']) : (json['lat'] as num?)?.toDouble();
    long = json['long'] is String ? double.tryParse(json['long']) : (json['long'] as num?)?.toDouble();
    status = json['status'];
    date = json['date'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    totalHours = json['total_hours'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['role'] = this.role;
    data['current_location'] = this.currentLocation;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['status'] = this.status;
    data['date'] = this.date;
    data['check_in'] = this.checkIn;
    data['check_out'] = this.checkOut;
    data['total_hours'] = this.totalHours;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
