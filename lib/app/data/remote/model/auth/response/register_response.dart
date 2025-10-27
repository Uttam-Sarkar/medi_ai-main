import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  String? message;
  bool? success;
  Data? data;

  RegisterResponse({
    this.message,
    this.success,
    this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  String? email;
  String? phoneNumber;
  String? mediid;
  String? owner;
  String? password;
  String? role;
  String? verificationToken;
  dynamic createdBy;
  String? id;
  int? v;

  Data({
    this.email,
    this.phoneNumber,
    this.mediid,
    this.owner,
    this.password,
    this.role,
    this.verificationToken,
    this.createdBy,
    this.id,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        mediid: json["mediid"],
        owner: json["owner"],
        password: json["password"],
        role: json["role"],
        verificationToken: json["verificationToken"],
        createdBy: json["createdBy"],
        id: json["_id"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "phoneNumber": phoneNumber,
        "mediid": mediid,
        "owner": owner,
        "password": password,
        "role": role,
        "verificationToken": verificationToken,
        "createdBy": createdBy,
        "_id": id,
        "__v": v,
      };
}
