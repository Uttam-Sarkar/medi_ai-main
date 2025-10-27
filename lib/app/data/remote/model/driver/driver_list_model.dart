import 'dart:convert';

DriverListModel driverListModelFromJson(String str) =>
    DriverListModel.fromJson(json.decode(str));

String driverListModelToJson(DriverListModel data) =>
    json.encode(data.toJson());

class DriverListModel {
  List<Driver>? drivers;
  String? message;
  String? status;

  DriverListModel({this.drivers, this.message, this.status});

  factory DriverListModel.fromJson(Map<String, dynamic> json) =>
      DriverListModel(
        drivers: json["drivers"] == null
            ? []
            : List<Driver>.from(
                json["drivers"]!.map((x) => Driver.fromJson(x)),
              ),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "drivers": drivers == null
            ? []
            : List<dynamic>.from(drivers!.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class Driver {
  int? id;
  String? name;
  String? email;
  DateTime? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? mobile;
  int? isAdmin;
  int? isDriver;

  Driver({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.mobile,
    this.isAdmin,
    this.isDriver,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        mobile: json["mobile"],
        isAdmin: json["is_admin"],
        isDriver: json["is_driver"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "mobile": mobile,
        "is_admin": isAdmin,
        "is_driver": isDriver,
      };
}
