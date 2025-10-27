// To parse this JSON data, do
//
//     final hospitalResponse = hospitalResponseFromJson(jsonString);

import 'dart:convert';

HospitalResponse hospitalResponseFromJson(String str) => HospitalResponse.fromJson(json.decode(str));

String hospitalResponseToJson(HospitalResponse data) => json.encode(data.toJson());

class HospitalResponse {
  List<PatientNearbyHospital> data;
  int page;
  int pageSize;
  int totalHospitals;
  int totalPages;
  Pagination pagination;

  HospitalResponse({
    required this.data,
    required this.page,
    required this.pageSize,
    required this.totalHospitals,
    required this.totalPages,
    required this.pagination,
  });

  factory HospitalResponse.fromJson(Map<String, dynamic> json) => HospitalResponse(
    data: List<PatientNearbyHospital>.from(json["data"].map((x) => PatientNearbyHospital.fromJson(x))),
    page: json["page"],
    pageSize: json["pageSize"],
    totalHospitals: json["totalHospitals"],
    totalPages: json["totalPages"],
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "page": page,
    "pageSize": pageSize,
    "totalHospitals": totalHospitals,
    "totalPages": totalPages,
    "pagination": pagination.toJson(),
  };
}

class PatientNearbyHospital {
  String id;
  String email;
  String phoneNumber;
  String mediid;
  String owner;
  String password;
  String role;
  String verificationToken;
  dynamic createdBy;
  int v;
  Details details;
  double distance;
  double lat;
  double lng;

  PatientNearbyHospital({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.mediid,
    required this.owner,
    required this.password,
    required this.role,
    required this.verificationToken,
    required this.createdBy,
    required this.v,
    required this.details,
    required this.distance,
    required this.lat,
    required this.lng,
  });

  factory PatientNearbyHospital.fromJson(Map<String, dynamic> json) => PatientNearbyHospital(
    id: json["_id"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    mediid: json["mediid"],
    owner: json["owner"],
    password: json["password"],
    role: json["role"],
    verificationToken: json["verificationToken"],
    createdBy: json["createdBy"],
    v: json["__v"],
    details: Details.fromJson(json["details"]),
    distance: json["distance"]?.toDouble(),
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
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
    "__v": v,
    "details": details.toJson(),
    "distance": distance,
    "lat": lat,
    "lng": lng,
  };
}

class Details {
  GeneralInfo generalInfo;
  String uploadLogo;
  List<Hour> workingHours;
  List<Hour> secondHours;
  List<AvailableDoctor> availableDoctors;
  double lat;
  double long;
  String geohash;

  Details({
    required this.generalInfo,
    required this.uploadLogo,
    required this.workingHours,
    required this.secondHours,
    required this.availableDoctors,
    required this.lat,
    required this.long,
    required this.geohash,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    generalInfo: GeneralInfo.fromJson(json["generalInfo"]),
    uploadLogo: json["uploadLogo"],
    workingHours: List<Hour>.from(json["workingHours"].map((x) => Hour.fromJson(x))),
    secondHours: List<Hour>.from(json["secondHours"].map((x) => Hour.fromJson(x))),
    availableDoctors: List<AvailableDoctor>.from(json["availableDoctors"].map((x) => AvailableDoctor.fromJson(x))),
    lat: json["lat"]?.toDouble(),
    long: json["long"]?.toDouble(),
    geohash: json["geohash"],
  );

  Map<String, dynamic> toJson() => {
    "generalInfo": generalInfo.toJson(),
    "uploadLogo": uploadLogo,
    "workingHours": List<dynamic>.from(workingHours.map((x) => x.toJson())),
    "secondHours": List<dynamic>.from(secondHours.map((x) => x.toJson())),
    "availableDoctors": List<dynamic>.from(availableDoctors.map((x) => x.toJson())),
    "lat": lat,
    "long": long,
    "geohash": geohash,
  };
}

class AvailableDoctor {
  String fullName;
  List<String> selectAccount;

  AvailableDoctor({
    required this.fullName,
    required this.selectAccount,
  });

  factory AvailableDoctor.fromJson(Map<String, dynamic> json) => AvailableDoctor(
    fullName: json["fullName"],
    selectAccount: List<String>.from(json["selectAccount"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "selectAccount": List<dynamic>.from(selectAccount.map((x) => x)),
  };
}

class GeneralInfo {
  String name;
  String phoneNumber;
  String nightPhone;
  String location;
  String type;
  String email;
  String country;
  String language;
  String address;
  String city;
  String postalCode;
  String currency;
  double taxConsumption;
  List<String> speciality;
  String websiteUrl;
  String buildingName;
  String rooms;
  String medicalSubject;
  bool parking;
  bool wheelChairEntry;
  bool wheelChairToilet;
  bool visuallyImpaired;
  bool hearingImpairements;
  bool foreignLanguageSupport;
  Latlng latlng;

  GeneralInfo({
    required this.name,
    required this.phoneNumber,
    required this.nightPhone,
    required this.location,
    required this.type,
    required this.email,
    required this.country,
    required this.language,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.currency,
    required this.taxConsumption,
    required this.speciality,
    required this.websiteUrl,
    required this.buildingName,
    required this.rooms,
    required this.medicalSubject,
    required this.parking,
    required this.wheelChairEntry,
    required this.wheelChairToilet,
    required this.visuallyImpaired,
    required this.hearingImpairements,
    required this.foreignLanguageSupport,
    required this.latlng,
  });

  factory GeneralInfo.fromJson(Map<String, dynamic> json) => GeneralInfo(
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    nightPhone: json["nightPhone"],
    location: json["location"],
    type: json["type"],
    email: json["email"],
    country: json["country"],
    language: json["language"],
    address: json["address"],
    city: json["city"],
    postalCode: json["postalCode"],
    currency: json["currency"],
    taxConsumption: json["taxConsumption"]?.toDouble(),
    speciality: List<String>.from(json["speciality"].map((x) => x)),
    websiteUrl: json["websiteUrl"],
    buildingName: json["buildingName"],
    rooms: json["rooms"],
    medicalSubject: json["medicalSubject"],
    parking: json["parking"],
    wheelChairEntry: json["wheelChairEntry"],
    wheelChairToilet: json["wheelChairToilet"],
    visuallyImpaired: json["visuallyImpaired"],
    hearingImpairements: json["hearingImpairements"],
    foreignLanguageSupport: json["foreignLanguageSupport"],
    latlng: Latlng.fromJson(json["latlng"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phoneNumber": phoneNumber,
    "nightPhone": nightPhone,
    "location": location,
    "type": type,
    "email": email,
    "country": country,
    "language": language,
    "address": address,
    "city": city,
    "postalCode": postalCode,
    "currency": currency,
    "taxConsumption": taxConsumption,
    "speciality": List<dynamic>.from(speciality.map((x) => x)),
    "websiteUrl": websiteUrl,
    "buildingName": buildingName,
    "rooms": rooms,
    "medicalSubject": medicalSubject,
    "parking": parking,
    "wheelChairEntry": wheelChairEntry,
    "wheelChairToilet": wheelChairToilet,
    "visuallyImpaired": visuallyImpaired,
    "hearingImpairements": hearingImpairements,
    "foreignLanguageSupport": foreignLanguageSupport,
    "latlng": latlng.toJson(),
  };
}

class Latlng {
  double lat;
  double long;

  Latlng({
    required this.lat,
    required this.long,
  });

  factory Latlng.fromJson(Map<String, dynamic> json) => Latlng(
    lat: json["lat"]?.toDouble(),
    long: json["long"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "long": long,
  };
}

class Hour {
  String day;
  bool isOpen;
  OpenTime openTime;
  CloseTime closeTime;

  Hour({
    required this.day,
    required this.isOpen,
    required this.openTime,
    required this.closeTime,
  });

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
    day: json["day"],
    isOpen: json["isOpen"],
    openTime: openTimeValues.map[json["openTime"]]!,
    closeTime: closeTimeValues.map[json["closeTime"]]!,
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "isOpen": isOpen,
    "openTime": openTimeValues.reverse[openTime],
    "closeTime": closeTimeValues.reverse[closeTime],
  };
}

enum CloseTime {
  THE_1700
}

final closeTimeValues = EnumValues({
  "17:00": CloseTime.THE_1700
});

enum OpenTime {
  THE_0900
}

final openTimeValues = EnumValues({
  "09:00": OpenTime.THE_0900
});

class Pagination {
  int currentPage;
  int totalPages;
  int totalCount;
  int limit;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.limit,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    totalCount: json["totalCount"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "currentPage": currentPage,
    "totalPages": totalPages,
    "totalCount": totalCount,
    "limit": limit,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
