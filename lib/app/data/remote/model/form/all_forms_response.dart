
import 'dart:convert';

List<AllFormsResponse> allFormsResponseFromJson(String str) => List<AllFormsResponse>.from(json.decode(str).map((x) => AllFormsResponse.fromJson(x)));

String allFormsResponseToJson(List<AllFormsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllFormsResponse {
  String? id;
  String? language;
  String? createdBy;
  String? createdAt;
  String? title;
  List<Field>? fields;

  AllFormsResponse({
    this.id,
    this.language,
    this.createdBy,
    this.createdAt,
    this.title,
    this.fields,
  });

  factory AllFormsResponse.fromJson(Map<String, dynamic> json) => AllFormsResponse(
    id: json["_id"],
    language: json["language"],
    createdBy: json["createdBy"],
    createdAt: json["createdAt"],
    title: json["title"],
    fields: json["fields"] == null ? [] : List<Field>.from(json["fields"]!.map((x) => Field.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "language": language,
    "createdBy": createdBy,
    "createdAt": createdAt,
    "title": title,
    "fields": fields == null ? [] : List<dynamic>.from(fields!.map((x) => x.toJson())),
  };
}

class Field {
  String? label;
  String? type;
  String? question;
  List<String>? options;
  String? id;

  Field({
    this.label,
    this.type,
    this.question,
    this.options,
    this.id,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    label: json["label"],
    type: json["type"],
    question: json["question"],
    options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "type": type,
    "question": question,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
    "_id": id,
  };
}
