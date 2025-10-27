import 'dart:convert';

AmbulanceDataResponse ambulanceDataResponseFromJson(String str) =>
    AmbulanceDataResponse.fromJson(json.decode(str));

String ambulanceDataResponseToJson(AmbulanceDataResponse data) =>
    json.encode(data.toJson());

class AmbulanceDataResponse {
  String? message;
  bool? success;
  List<AmbulanceData>? data;

  AmbulanceDataResponse({
    this.message,
    this.success,
    this.data,
  });

  factory AmbulanceDataResponse.fromJson(Map<String, dynamic> json) =>
      AmbulanceDataResponse(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<AmbulanceData>.from(
                json["data"]!.map((x) => AmbulanceData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AmbulanceData {
  String? id;
  String? email;
  String? phoneNumber;
  String? mediid;
  String? owner;
  String? password;
  String? role;
  String? verificationToken;
  dynamic createdBy;
  String? createdAt;
  String? updatedAt;
  int? v;

  AmbulanceData({
    this.id,
    this.email,
    this.phoneNumber,
    this.mediid,
    this.owner,
    this.password,
    this.role,
    this.verificationToken,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AmbulanceData.fromJson(Map<String, dynamic> json) => AmbulanceData(
        id: json["_id"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        mediid: json["mediid"],
        owner: json["owner"],
        password: json["password"],
        role: json["role"],
        verificationToken: json["verificationToken"],
        createdBy: json["createdBy"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "phoneNumber": phoneNumber,
        "mediid": mediid,
        "owner": owner,
        "password": password,
        "role": role,
        "verificationToken": verificationToken,
        "createdBy": createdBy,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}
