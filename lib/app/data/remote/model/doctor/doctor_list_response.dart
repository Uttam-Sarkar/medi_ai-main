import 'dart:convert';

DoctorListResponse doctorListResponseFromJson(String str) => DoctorListResponse.fromJson(json.decode(str));

String doctorListResponseToJson(DoctorListResponse data) => json.encode(data.toJson());

class DoctorListResponse {
  String? message;
  bool? success;
  List<Datum>? data;

  DoctorListResponse({
    this.message,
    this.success,
    this.data,
  });

  factory DoctorListResponse.fromJson(Map<String, dynamic> json) => DoctorListResponse(
    message: json["message"],
    success: json["success"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? email;
  String? phoneNumber;
  String? mediid;
  String? owner;
  Details? details;
  String? password;
  String? role;
  String? verificationToken;
  String? createdBy;
  int? v;

  Datum({
    this.id,
    this.email,
    this.phoneNumber,
    this.mediid,
    this.owner,
    this.details,
    this.password,
    this.role,
    this.verificationToken,
    this.createdBy,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    mediid: json["mediid"],
    owner: json["owner"],
    details: json["details"] == null ? null : Details.fromJson(json["details"]),
    password: json["password"],
    role: json["role"],
    verificationToken: json["verificationToken"],
    createdBy: json["createdBy"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "phoneNumber": phoneNumber,
    "mediid": mediid,
    "owner": owner,
    "details": details?.toJson(),
    "password": password,
    "role": role,
    "verificationToken": verificationToken,
    "createdBy": createdBy,
    "__v": v,
  };
}

class Details {
  String? fullName;
  dynamic specialization;
  String? qualifications;
  String? license;
  String? hospitalName;
  String? department;
  String? workingHours;
  String? bio;
  String? profilePicture;
  String? socialMedia;
  String? languages;
  String? insuranceInfo;
  String? emergencyContact;
  String? owner;
  String? createdBy;

  Details({
    this.fullName,
    this.specialization,
    this.qualifications,
    this.license,
    this.hospitalName,
    this.department,
    this.workingHours,
    this.bio,
    this.profilePicture,
    this.socialMedia,
    this.languages,
    this.insuranceInfo,
    this.emergencyContact,
    this.owner,
    this.createdBy,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    fullName: json["fullName"],
    specialization: json["specialization"],
    qualifications: json["qualifications"],
    license: json["license"],
    hospitalName: json["hospitalName"],
    department: json["department"],
    workingHours: json["workingHours"],
    bio: json["bio"],
    profilePicture: json["profilePicture"],
    socialMedia: json["socialMedia"],
    languages: json["languages"],
    insuranceInfo: json["insuranceInfo"],
    emergencyContact: json["emergencyContact"],
    owner: json["owner"],
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "specialization": specialization,
    "qualifications": qualifications,
    "license": license,
    "hospitalName": hospitalName,
    "department": department,
    "workingHours": workingHours,
    "bio": bio,
    "profilePicture": profilePicture,
    "socialMedia": socialMedia,
    "languages": languages,
    "insuranceInfo": insuranceInfo,
    "emergencyContact": emergencyContact,
    "owner": owner,
    "createdBy": createdBy,
  };
}
