import 'dart:convert';

ChatDataResponse chatDataResponseFromJson(String str) => ChatDataResponse.fromJson(json.decode(str));

String chatDataResponseToJson(ChatDataResponse data) => json.encode(data.toJson());

class ChatDataResponse {
  String? message;
  bool? success;
  List<Datum>? data;

  ChatDataResponse({
    this.message,
    this.success,
    this.data,
  });

  factory ChatDataResponse.fromJson(Map<String, dynamic> json) => ChatDataResponse(
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
  String? sender;
  String? receiver;
  String? message;
  String? translatedResponse;
  int? v;

  Datum({
    this.id,
    this.sender,
    this.receiver,
    this.message,
    this.translatedResponse,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    sender: json["sender"],
    receiver: json["receiver"],
    message: json["message"],
    translatedResponse: json["translatedResponse"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sender": sender,
    "receiver": receiver,
    "message": message,
    "translatedResponse": translatedResponse,
    "__v": v,
  };
}
