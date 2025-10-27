import 'dart:convert';

JobListAdminModel jobListAdminModelFromJson(String str) =>
    JobListAdminModel.fromJson(json.decode(str));

String jobListAdminModelToJson(JobListAdminModel data) =>
    json.encode(data.toJson());

class JobListAdminModel {
  int? status;
  List<JobDetailsAdmin>? data;
  String? message;

  JobListAdminModel({this.status, this.data, this.message});

  factory JobListAdminModel.fromJson(Map<String, dynamic> json) =>
      JobListAdminModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<JobDetailsAdmin>.from(
                json["data"]!.map((x) => JobDetailsAdmin.fromJson(x)),
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

class JobDetailsAdmin {
  int? id;
  DateTime? jobDate;
  String? jobTime;
  String? pickUpPoint;
  String? dropOff;
  String? amount;
  String? link;
  String? phoneNo;
  int? isAccept;
  int? acceptBy;
  int? statusId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? statusName;
  String? acceptName;
  DateTime? jobAt;

  JobDetailsAdmin({
    this.id,
    this.jobDate,
    this.jobTime,
    this.pickUpPoint,
    this.dropOff,
    this.amount,
    this.link,
    this.phoneNo,
    this.isAccept,
    this.acceptBy,
    this.statusId,
    this.createdAt,
    this.updatedAt,
    this.statusName,
    this.acceptName,
    this.jobAt,
  });

  factory JobDetailsAdmin.fromJson(Map<String, dynamic> json) =>
      JobDetailsAdmin(
        id: json["id"],
        jobDate:
            json["job_date"] == null ? null : DateTime.parse(json["job_date"]),
        jobTime: json["job_time"],
        pickUpPoint: json["pick_up_point"],
        dropOff: json["drop_off"],
        amount: json["amount"],
        link: json["link"],
        phoneNo: json["phone_no"],
        isAccept: json["is_accept"],
        acceptBy: json["accept_by"],
        statusId: json["status_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        statusName: json["status_name"],
        acceptName: json["accept_name"],
        jobAt: json["job_at"] == null ? null : DateTime.parse(json["job_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_date":
            "${jobDate!.year.toString().padLeft(4, '0')}-${jobDate!.month.toString().padLeft(2, '0')}-${jobDate!.day.toString().padLeft(2, '0')}",
        "job_time": jobTime,
        "pick_up_point": pickUpPoint,
        "drop_off": dropOff,
        "amount": amount,
        "link": link,
        "phone_no": phoneNo,
        "is_accept": isAccept,
        "accept_by": acceptBy,
        "status_id": statusId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status_name": statusName,
        "accept_name": acceptName,
        "job_at": jobAt?.toIso8601String(),
      };
}
