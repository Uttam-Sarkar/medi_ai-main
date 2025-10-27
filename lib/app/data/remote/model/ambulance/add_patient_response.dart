import 'dart:convert';

AddPatientResponse addPatientResponseFromJson(String str) =>
    AddPatientResponse.fromJson(json.decode(str));

String addPatientResponseToJson(AddPatientResponse data) =>
    json.encode(data.toJson());

class AddPatientResponse {
  String? message;
  bool? success;
  String? error;

  AddPatientResponse({
    this.message,
    this.success,
    this.error,
  });

  factory AddPatientResponse.fromJson(Map<String, dynamic> json) =>
      AddPatientResponse(
        message: json["message"],
        success: json["success"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "error": error,
      };
}
