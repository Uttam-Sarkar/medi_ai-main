import 'dart:convert';

DriverProfileListModel driverProfileListModelFromJson(String str) =>
    DriverProfileListModel.fromJson(json.decode(str));

String driverProfileListModelToJson(DriverProfileListModel data) =>
    json.encode(data.toJson());

class DriverProfileListModel {
  int? status;
  List<DriverProfile>? data;
  String? message;

  DriverProfileListModel({this.status, this.data, this.message});

  factory DriverProfileListModel.fromJson(Map<String, dynamic> json) =>
      DriverProfileListModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<DriverProfile>.from(
                json["data"]!.map((x) => DriverProfile.fromJson(x)),
              ),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class DriverProfile {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  DateTime? dateOfBirth;
  String? nswDriverLicenceNumber;
  String? taxiNumber;
  String? frontPicDriverLicence;
  String? backPicDriverLicence;
  String? nswDriverIdNumber;
  String? frontPicDriverId;
  String? backPicDriverId;
  int? policeClearance;
  String? picPoliceClearance;
  DateTime? createdAt;
  DateTime? updatedAt;

  DriverProfile({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.nswDriverLicenceNumber,
    this.taxiNumber,
    this.frontPicDriverLicence,
    this.backPicDriverLicence,
    this.nswDriverIdNumber,
    this.frontPicDriverId,
    this.backPicDriverId,
    this.policeClearance,
    this.picPoliceClearance,
    this.createdAt,
    this.updatedAt,
  });

  factory DriverProfile.fromJson(Map<String, dynamic> json) => DriverProfile(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        nswDriverLicenceNumber: json["nsw_driver_licence_number"],
        taxiNumber: json["taxi_number"],
        frontPicDriverLicence: json["front_pic_driver_licence"],
        backPicDriverLicence: json["back_pic_driver_licence"],
        nswDriverIdNumber: json["nsw_driver_id_number"],
        frontPicDriverId: json["front_pic_driver_id"],
        backPicDriverId: json["back_pic_driver_id"],
        policeClearance: json["police_clearance"],
        picPoliceClearance: json["pic_police_clearance"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "nsw_driver_licence_number": nswDriverLicenceNumber,
        "taxi_number": taxiNumber,
        "front_pic_driver_licence": frontPicDriverLicence,
        "back_pic_driver_licence": backPicDriverLicence,
        "nsw_driver_id_number": nswDriverIdNumber,
        "front_pic_driver_id": frontPicDriverId,
        "back_pic_driver_id": backPicDriverId,
        "police_clearance": policeClearance,
        "pic_police_clearance": picPoliceClearance,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
