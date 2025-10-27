import 'dart:convert';

ChatResponse chatResponseFromJson(String str) => ChatResponse.fromJson(json.decode(str));

String chatResponseToJson(ChatResponse data) => json.encode(data.toJson());

class ChatResponse {
  String? message;
  bool? success;
  Data? data;

  ChatResponse({
    this.message,
    this.success,
    this.data,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) => ChatResponse(
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
  String? user;
  String? qtn;
  String? message;
  String? threadId;

  Data({
    this.user,
    this.qtn,
    this.message,
    this.threadId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"],
    qtn: json["qtn"],
    message: json["message"],
    threadId: json["threadId"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "qtn": qtn,
    "message": message,
    "threadId": threadId,
  };
}
