import 'dart:convert';

List<ChatListResponse> chatListResponseFromJson(String str) => List<ChatListResponse>.from(json.decode(str).map((x) => ChatListResponse.fromJson(x)));

String chatListResponseToJson(List<ChatListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatListResponse {
  String? id;
  String? language;
  String? createdBy;
  String? title;
  dynamic formCreator;
  String? createdAt;
  String? heading;
  List<Field>? fields;
  String? responseData;
  String? submissionId;

  ChatListResponse({
    this.id,
    this.language,
    this.createdBy,
    this.title,
    this.formCreator,
    this.createdAt,
    this.heading,
    this.fields,
    this.responseData,
    this.submissionId,
  });

  factory ChatListResponse.fromJson(Map<String, dynamic> json) => ChatListResponse(
    id: json["_id"],
    language: json["language"],
    createdBy: json["createdBy"],
    title: json["title"],
    formCreator: json["formCreator"],
    createdAt: json["createdAt"],
    heading: json["heading"],
    fields: json["fields"] == null ? [] : List<Field>.from(json["fields"]!.map((x) => Field.fromJson(x))),
    responseData: json["responseData"],
    submissionId: json["submissionId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "language": language,
    "createdBy": createdBy,
    "title": title,
    "formCreator": formCreator,
    "createdAt": createdAt,
    "heading": heading,
    "fields": fields == null ? [] : List<dynamic>.from(fields!.map((x) => x.toJson())),
    "responseData": responseData,
    "submissionId": submissionId,
  };
}

class Field {
  String? label;
  String? type;
  String? question;
  List<String>? options;

  Field({
    this.label,
    this.type,
    this.question,
    this.options,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    label: json["label"],
    type: json["type"],
    question: json["question"],
    options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "type": type,
    "question": question,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
  };
}
