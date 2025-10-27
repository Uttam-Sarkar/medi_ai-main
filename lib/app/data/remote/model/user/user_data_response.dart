import 'dart:convert';

UserDataResponse userDataResponseFromJson(String str) => UserDataResponse.fromJson(json.decode(str));

String userDataResponseToJson(UserDataResponse data) => json.encode(data.toJson());

class UserDataResponse {
  String? message;
  bool? success;
  List<UserFilteredData>? data;

  UserDataResponse({
    this.message,
    this.success,
    this.data,
  });

  factory UserDataResponse.fromJson(Map<String, dynamic> json) => UserDataResponse(
    message: json["message"],
    success: json["success"],
    data: json["data"] == null ? [] : List<UserFilteredData>.from(json["data"]!.map((x) => UserFilteredData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class UserFilteredData {
  String? id;
  String? email;
  String? phoneNumber;
  String? mediid;
  String? owner;
  String? password;
  String? role;
  String? verificationToken;
  dynamic createdBy;
  int? v;
  DatumDetails? details;
  List<RequestDetail>? requestDetails;

  UserFilteredData({
    this.id,
    this.email,
    this.phoneNumber,
    this.mediid,
    this.owner,
    this.password,
    this.role,
    this.verificationToken,
    this.createdBy,
    this.v,
    this.details,
    this.requestDetails,
  });

  factory UserFilteredData.fromJson(Map<String, dynamic> json) => UserFilteredData(
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
    details: json["details"] == null ? null : DatumDetails.fromJson(json["details"]),
    requestDetails: json["requestDetails"] == null ? [] : List<RequestDetail>.from(json["requestDetails"]!.map((x) => RequestDetail.fromJson(x))),
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
    "details": details?.toJson(),
    "requestDetails": requestDetails == null ? [] : List<dynamic>.from(requestDetails!.map((x) => x.toJson())),
  };
}

class DatumDetails {
  PersonalDetails? personalDetails;
  TravelDetails? travelDetails;
  MedicalHistory? medicalHistory;
  VaccineHistory? vaccineHistory;
  List<EmergencyContact>? emergencyContacts;
  LifestyleFactors? lifestyleFactors;
  List<UploadDocument>? uploadDocuments;

  DatumDetails({
    this.personalDetails,
    this.travelDetails,
    this.medicalHistory,
    this.vaccineHistory,
    this.emergencyContacts,
    this.lifestyleFactors,
    this.uploadDocuments,
  });

  factory DatumDetails.fromJson(Map<String, dynamic> json) => DatumDetails(
    personalDetails: json["personalDetails"] == null ? null : PersonalDetails.fromJson(json["personalDetails"]),
    travelDetails: json["travelDetails"] == null ? null : TravelDetails.fromJson(json["travelDetails"]),
    medicalHistory: json["medicalHistory"] == null ? null : MedicalHistory.fromJson(json["medicalHistory"]),
    vaccineHistory: json["vaccineHistory"] == null ? null : VaccineHistory.fromJson(json["vaccineHistory"]),
    emergencyContacts: json["emergencyContacts"] == null ? [] : List<EmergencyContact>.from(json["emergencyContacts"]!.map((x) => EmergencyContact.fromJson(x))),
    lifestyleFactors: json["lifestyleFactors"] == null ? null : LifestyleFactors.fromJson(json["lifestyleFactors"]),
    uploadDocuments: json["uploadDocuments"] == null ? [] : List<UploadDocument>.from(json["uploadDocuments"]!.map((x) => UploadDocument.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "personalDetails": personalDetails?.toJson(),
    "travelDetails": travelDetails?.toJson(),
    "medicalHistory": medicalHistory?.toJson(),
    "vaccineHistory": vaccineHistory?.toJson(),
    "emergencyContacts": emergencyContacts == null ? [] : List<dynamic>.from(emergencyContacts!.map((x) => x.toJson())),
    "lifestyleFactors": lifestyleFactors?.toJson(),
    "uploadDocuments": uploadDocuments == null ? [] : List<dynamic>.from(uploadDocuments!.map((x) => x.toJson())),
  };
}

class EmergencyContact {
  String? nameOfEmergencyContact;
  String? phoneNumber;
  String? relationship;
  String? email;
  String? mediaiId;

  EmergencyContact({
    this.nameOfEmergencyContact,
    this.phoneNumber,
    this.relationship,
    this.email,
    this.mediaiId,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) => EmergencyContact(
    nameOfEmergencyContact: json["nameOfEmergencyContact"],
    phoneNumber: json["phoneNumber"],
    relationship: json["relationship"],
    email: json["email"],
    mediaiId: json["mediaiId"],
  );

  Map<String, dynamic> toJson() => {
    "nameOfEmergencyContact": nameOfEmergencyContact,
    "phoneNumber": phoneNumber,
    "relationship": relationship,
    "email": email,
    "mediaiId": mediaiId,
  };
}

class LifestyleFactors {
  String? smokingHabits;
  String? alcoholConsumptions;
  String? physicalActivityLevel;
  String? preferences;

  LifestyleFactors({
    this.smokingHabits,
    this.alcoholConsumptions,
    this.physicalActivityLevel,
    this.preferences,
  });

  factory LifestyleFactors.fromJson(Map<String, dynamic> json) => LifestyleFactors(
    smokingHabits: json["smokingHabits"],
    alcoholConsumptions: json["alcoholConsumptions"],
    physicalActivityLevel: json["physicalActivityLevel"],
    preferences: json["preferences"],
  );

  Map<String, dynamic> toJson() => {
    "smokingHabits": smokingHabits,
    "alcoholConsumptions": alcoholConsumptions,
    "physicalActivityLevel": physicalActivityLevel,
    "preferences": preferences,
  };
}

class MedicalHistory {
  String? medicalCondition;
  List<String>? sicknessHistory;
  List<String>? surgicalHistory;
  List<String>? allergy;
  String? medication;
  List<dynamic>? medicationTypes;
  List<dynamic>? customInputMedications;
  String? currentSymptoms;

  MedicalHistory({
    this.medicalCondition,
    this.sicknessHistory,
    this.surgicalHistory,
    this.allergy,
    this.medication,
    this.medicationTypes,
    this.customInputMedications,
    this.currentSymptoms,
  });

  factory MedicalHistory.fromJson(Map<String, dynamic> json) => MedicalHistory(
    medicalCondition: json["medicalCondition"],
    sicknessHistory: json["sicknessHistory"] == null ? [] : List<String>.from(json["sicknessHistory"]!.map((x) => x)),
    surgicalHistory: json["surgicalHistory"] == null ? [] : List<String>.from(json["surgicalHistory"]!.map((x) => x)),
    allergy: json["allergy"] == null ? [] : List<String>.from(json["allergy"]!.map((x) => x)),
    medication: json["medication"],
    medicationTypes: json["medicationTypes"] == null ? [] : List<dynamic>.from(json["medicationTypes"]!.map((x) => x)),
    customInputMedications: json["customInputMedications"] == null ? [] : List<dynamic>.from(json["customInputMedications"]!.map((x) => x)),
    currentSymptoms: json["currentSymptoms"],
  );

  Map<String, dynamic> toJson() => {
    "medicalCondition": medicalCondition,
    "sicknessHistory": sicknessHistory == null ? [] : List<dynamic>.from(sicknessHistory!.map((x) => x)),
    "surgicalHistory": surgicalHistory == null ? [] : List<dynamic>.from(surgicalHistory!.map((x) => x)),
    "allergy": allergy == null ? [] : List<dynamic>.from(allergy!.map((x) => x)),
    "medication": medication,
    "medicationTypes": medicationTypes == null ? [] : List<dynamic>.from(medicationTypes!.map((x) => x)),
    "customInputMedications": customInputMedications == null ? [] : List<dynamic>.from(customInputMedications!.map((x) => x)),
    "currentSymptoms": currentSymptoms,
  };
}

class PersonalDetails {
  String? firstName;
  String? lastName;
  String? email;
  String? language;
  DateTime? dateOfBirth;
  String? age;
  String? gender;
  String? country;
  String? state;
  String? address1;
  String? address2;
  String? bloodType;
  String? city;
  String? postalCode;
  String? passportNumber;
  String? height;
  String? weight;

  PersonalDetails({
    this.firstName,
    this.lastName,
    this.email,
    this.language,
    this.dateOfBirth,
    this.age,
    this.gender,
    this.country,
    this.state,
    this.address1,
    this.address2,
    this.bloodType,
    this.city,
    this.postalCode,
    this.passportNumber,
    this.height,
    this.weight,
  });

  factory PersonalDetails.fromJson(Map<String, dynamic> json) => PersonalDetails(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    language: json["language"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    age: json["age"],
    gender: json["gender"],
    country: json["country"],
    state: json["state"],
    address1: json["address1"],
    address2: json["address2"],
    bloodType: json["bloodType"],
    city: json["city"],
    postalCode: json["postalCode"],
    passportNumber: json["passportNumber"],
    height: json["height"],
    weight: json["weight"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "language": language,
    "dateOfBirth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "age": age,
    "gender": gender,
    "country": country,
    "state": state,
    "address1": address1,
    "address2": address2,
    "bloodType": bloodType,
    "city": city,
    "postalCode": postalCode,
    "passportNumber": passportNumber,
    "height": height,
    "weight": weight,
  };
}

class TravelDetails {
  String? pregnant;
  String? nursing;
  String? medication;
  String? daysAgoArrived;
  String? daysStay;
  String? arriveFrom;
  String? visitedCountries;
  String? symptomsStart;
  String? medicalInsurance;
  String? medicalFee;
  String? travelReason;
  String? dateOfTravel;
  String? travelLocation;

  TravelDetails({
    this.pregnant,
    this.nursing,
    this.medication,
    this.daysAgoArrived,
    this.daysStay,
    this.arriveFrom,
    this.visitedCountries,
    this.symptomsStart,
    this.medicalInsurance,
    this.medicalFee,
    this.travelReason,
    this.dateOfTravel,
    this.travelLocation,
  });

  factory TravelDetails.fromJson(Map<String, dynamic> json) => TravelDetails(
    pregnant: json["pregnant"],
    nursing: json["nursing"],
    medication: json["medication"],
    daysAgoArrived: json["daysAgoArrived"],
    daysStay: json["daysStay"],
    arriveFrom: json["arriveFrom"],
    visitedCountries: json["visitedCountries"],
    symptomsStart: json["symptomsStart"],
    medicalInsurance: json["medicalInsurance"],
    medicalFee: json["medicalFee"],
    travelReason: json["travelReason"],
    dateOfTravel: json["dateOfTravel"],
    travelLocation: json["travelLocation"],
  );

  Map<String, dynamic> toJson() => {
    "pregnant": pregnant,
    "nursing": nursing,
    "medication": medication,
    "daysAgoArrived": daysAgoArrived,
    "daysStay": daysStay,
    "arriveFrom": arriveFrom,
    "visitedCountries": visitedCountries,
    "symptomsStart": symptomsStart,
    "medicalInsurance": medicalInsurance,
    "medicalFee": medicalFee,
    "travelReason": travelReason,
    "dateOfTravel": dateOfTravel,
    "travelLocation": travelLocation,
  };
}

class UploadDocument {
  String? fileName;

  UploadDocument({
    this.fileName,
  });

  factory UploadDocument.fromJson(Map<String, dynamic> json) => UploadDocument(
    fileName: json["fileName"],
  );

  Map<String, dynamic> toJson() => {
    "fileName": fileName,
  };
}

class VaccineHistory {
  List<ImmunizationHistory>? immunizationHistory;

  VaccineHistory({
    this.immunizationHistory,
  });

  factory VaccineHistory.fromJson(Map<String, dynamic> json) => VaccineHistory(
    immunizationHistory: json["immunizationHistory"] == null ? [] : List<ImmunizationHistory>.from(json["immunizationHistory"]!.map((x) => ImmunizationHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "immunizationHistory": immunizationHistory == null ? [] : List<dynamic>.from(immunizationHistory!.map((x) => x.toJson())),
  };
}

class ImmunizationHistory {
  String? vaccines;
  DateTime? dateOfVaccine;
  String? hasReceivedCovidVaccine;
  String? dosesReceived;
  String? timeSinceLastVaccination;

  ImmunizationHistory({
    this.vaccines,
    this.dateOfVaccine,
    this.hasReceivedCovidVaccine,
    this.dosesReceived,
    this.timeSinceLastVaccination,
  });

  factory ImmunizationHistory.fromJson(Map<String, dynamic> json) => ImmunizationHistory(
    vaccines: json["vaccines"],
    dateOfVaccine: json["dateOfVaccine"] == null ? null : DateTime.parse(json["dateOfVaccine"]),
    hasReceivedCovidVaccine: json["hasReceivedCovidVaccine"],
    dosesReceived: json["dosesReceived"],
    timeSinceLastVaccination: json["timeSinceLastVaccination"],
  );

  Map<String, dynamic> toJson() => {
    "vaccines": vaccines,
    "dateOfVaccine": "${dateOfVaccine!.year.toString().padLeft(4, '0')}-${dateOfVaccine!.month.toString().padLeft(2, '0')}-${dateOfVaccine!.day.toString().padLeft(2, '0')}",
    "hasReceivedCovidVaccine": hasReceivedCovidVaccine,
    "dosesReceived": dosesReceived,
    "timeSinceLastVaccination": timeSinceLastVaccination,
  };
}

class RequestDetail {
  String? id;
  String? email;
  String? phoneNumber;
  String? mediid;
  String? owner;
  String? password;
  String? role;
  String? verificationToken;
  dynamic createdBy;
  int? v;
  RequestDetailDetails? details;
  String? status;

  RequestDetail({
    this.id,
    this.email,
    this.phoneNumber,
    this.mediid,
    this.owner,
    this.password,
    this.role,
    this.verificationToken,
    this.createdBy,
    this.v,
    this.details,
    this.status,
  });

  factory RequestDetail.fromJson(Map<String, dynamic> json) => RequestDetail(
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
    details: json["details"] == null ? null : RequestDetailDetails.fromJson(json["details"]),
    status: json["status"],
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
    "details": details?.toJson(),
    "status": status,
  };
}

class RequestDetailDetails {
  GeneralInfo? generalInfo;
  String? uploadLogo;
  List<Hour>? workingHours;
  List<Hour>? secondHours;
  List<dynamic>? availableDoctors;
  double? lat;
  double? long;
  String? geohash;

  RequestDetailDetails({
    this.generalInfo,
    this.uploadLogo,
    this.workingHours,
    this.secondHours,
    this.availableDoctors,
    this.lat,
    this.long,
    this.geohash,
  });

  factory RequestDetailDetails.fromJson(Map<String, dynamic> json) => RequestDetailDetails(
    generalInfo: json["generalInfo"] == null ? null : GeneralInfo.fromJson(json["generalInfo"]),
    uploadLogo: json["uploadLogo"],
    workingHours: json["workingHours"] == null ? [] : List<Hour>.from(json["workingHours"]!.map((x) => Hour.fromJson(x))),
    secondHours: json["secondHours"] == null ? [] : List<Hour>.from(json["secondHours"]!.map((x) => Hour.fromJson(x))),
    availableDoctors: json["availableDoctors"] == null ? [] : List<dynamic>.from(json["availableDoctors"]!.map((x) => x)),
    lat: json["lat"]?.toDouble(),
    long: json["long"]?.toDouble(),
    geohash: json["geohash"],
  );

  Map<String, dynamic> toJson() => {
    "generalInfo": generalInfo?.toJson(),
    "uploadLogo": uploadLogo,
    "workingHours": workingHours == null ? [] : List<dynamic>.from(workingHours!.map((x) => x.toJson())),
    "secondHours": secondHours == null ? [] : List<dynamic>.from(secondHours!.map((x) => x.toJson())),
    "availableDoctors": availableDoctors == null ? [] : List<dynamic>.from(availableDoctors!.map((x) => x)),
    "lat": lat,
    "long": long,
    "geohash": geohash,
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
  double? taxConsumption;
  List<String>? speciality;
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
    taxConsumption: json["taxConsumption"]?.toDouble(),
    speciality: json["speciality"] == null ? [] : List<String>.from(json["speciality"]!.map((x) => x)),
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
    "speciality": speciality == null ? [] : List<dynamic>.from(speciality!.map((x) => x)),
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
  double? lat;
  double? long;

  Latlng({
    this.lat,
    this.long,
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
