import 'dart:convert';

DefaultModel defaultModelFromJson(String str) =>
    DefaultModel.fromJson(json.decode(str));

String defaultModelToJson(DefaultModel data) => json.encode(data.toJson());

class DefaultModel {
  String? message;
  int? status;

  DefaultModel({this.message, this.status});

  factory DefaultModel.fromJson(Map<String, dynamic> json) =>
      DefaultModel(message: json["message"], status: json["status"]);

  Map<String, dynamic> toJson() => {"message": message, "status": status};
}
