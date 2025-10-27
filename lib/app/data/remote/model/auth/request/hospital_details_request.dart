import 'dart:convert';

HospitalDetailsRequest hospitalDetailsRequestFromJson(String str) =>
    HospitalDetailsRequest.fromJson(json.decode(str));

String hospitalDetailsRequestToJson(HospitalDetailsRequest data) =>
    json.encode(data.toJson());

class HospitalDetailsRequest {
  String? email;
  UpdatedFields? updatedFields;

  HospitalDetailsRequest({this.email, this.updatedFields, a});

  factory HospitalDetailsRequest.fromJson(Map<String, dynamic> json) =>
      HospitalDetailsRequest(
        email: json["email"],
        updatedFields: json["updatedFields"] == null
            ? null
            : UpdatedFields.fromJson(json["updatedFields"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "updatedFields": updatedFields?.toJson(),
      };
}

class UpdatedFields {
  GeneralInfo? generalInfo;
  String? uploadLogo;
  List<Hour>? workingHours;
  List<Hour>? secondHours;
  List<AvailableDoctor>? availableDoctors;

  UpdatedFields({
    this.generalInfo,
    this.uploadLogo,
    this.workingHours,
    this.secondHours,
    this.availableDoctors,
  });

  factory UpdatedFields.fromJson(Map<String, dynamic> json) => UpdatedFields(
        generalInfo: json["generalInfo"] == null
            ? null
            : GeneralInfo.fromJson(json["generalInfo"]),
        uploadLogo: json["uploadLogo"],
        workingHours: json["workingHours"] == null
            ? []
            : List<Hour>.from(
                json["workingHours"]!.map((x) => Hour.fromJson(x))),
        secondHours: json["secondHours"] == null
            ? []
            : List<Hour>.from(
                json["secondHours"]!.map((x) => Hour.fromJson(x))),
        availableDoctors: json["availableDoctors"] == null
            ? []
            : List<AvailableDoctor>.from(json["availableDoctors"]!
                .map((x) => AvailableDoctor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "generalInfo": generalInfo?.toJson(),
        "uploadLogo": uploadLogo,
        "workingHours": workingHours == null
            ? []
            : List<dynamic>.from(workingHours!.map((x) => x.toJson())),
        "secondHours": secondHours == null
            ? []
            : List<dynamic>.from(secondHours!.map((x) => x.toJson())),
        "availableDoctors": availableDoctors == null
            ? []
            : List<dynamic>.from(availableDoctors!.map((x) => x.toJson())),
      };
}

class AvailableDoctor {
  String? fullName;
  List<String>? selectAccount;

  AvailableDoctor({
    this.fullName,
    this.selectAccount,
  });

  factory AvailableDoctor.fromJson(Map<String, dynamic> json) =>
      AvailableDoctor(
        fullName: json["fullName"],
        selectAccount: json["selectAccount"] == null
            ? []
            : List<String>.from(json["selectAccount"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "selectAccount": selectAccount == null
            ? []
            : List<dynamic>.from(selectAccount!.map((x) => x)),
      };
}

class GeneralInfo {
  String? name;
  String? phoneNumber;
  String? nightPhone;
  String? location;
  String? type;
  String? email;
  String? country;
  String? language;
  String? address;
  String? city;
  String? postalCode;
  String? currency;
  int? taxConsumption;
  List<dynamic>? speciality;
  String? websiteUrl;
  String? buildingName;
  String? rooms;
  String? medicalSubject;
  bool? parking;
  bool? wheelChairEntry;
  bool? wheelChairToilet;
  bool? visuallyImpaired;
  bool? hearingImpairements;
  bool? foreignLanguageSupport;
  Latlng? latlng;

  GeneralInfo({
    this.name,
    this.phoneNumber,
    this.nightPhone,
    this.location,
    this.type,
    this.email,
    this.country,
    this.language,
    this.address,
    this.city,
    this.postalCode,
    this.currency,
    this.taxConsumption,
    this.speciality,
    this.websiteUrl,
    this.buildingName,
    this.rooms,
    this.medicalSubject,
    this.parking,
    this.wheelChairEntry,
    this.wheelChairToilet,
    this.visuallyImpaired,
    this.hearingImpairements,
    this.foreignLanguageSupport,
    this.latlng,
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
        taxConsumption: json["taxConsumption"],
        speciality: json["speciality"] == null
            ? []
            : List<dynamic>.from(json["speciality"]!.map((x) => x)),
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
        latlng: json["latlng"] == null ? null : Latlng.fromJson(json["latlng"]),
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
        "speciality": speciality == null
            ? []
            : List<dynamic>.from(speciality!.map((x) => x)),
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
        "latlng": latlng?.toJson(),
      };
}

class Latlng {
  String? lat;
  String? long;

  Latlng({
    this.lat,
    this.long,
  });

  factory Latlng.fromJson(Map<String, dynamic> json) => Latlng(
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
      };
}

class Hour {
  String? day;
  bool? isOpen;
  String? openTime;
  String? closeTime;

  Hour({
    this.day,
    this.isOpen,
    this.openTime,
    this.closeTime,
  });

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
        day: json["day"],
        isOpen: json["isOpen"],
        openTime: json["openTime"],
        closeTime: json["closeTime"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "isOpen": isOpen,
        "openTime": openTime,
        "closeTime": closeTime,
      };
}
