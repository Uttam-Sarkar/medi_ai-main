
import 'dart:convert';

PatientListResponse patientListResponseFromJson(String str) => PatientListResponse.fromJson(json.decode(str));

String patientListResponseToJson(PatientListResponse data) => json.encode(data.toJson());

class PatientListResponse {
  String? message;
  bool? success;
  List<PatientListData>? data;

  PatientListResponse({
    this.message,
    this.success,
    this.data,
  });

  factory PatientListResponse.fromJson(Map<String, dynamic> json) => PatientListResponse(
    message: json["message"],
    success: json["success"],
    data: json["data"] == null ? [] : List<PatientListData>.from(json["data"]!.map((x) => PatientListData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PatientListData {
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
  Details? details;
  List<RequestDetail>? requestDetails;

  PatientListData({
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

  factory PatientListData.fromJson(Map<String, dynamic> json) => PatientListData(
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
    details: json["details"] == null ? null : Details.fromJson(json["details"]),
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

class Details {
  PersonalDetails? personalDetails;
  TravelDetails? travelDetails;
  MedicalHistory? medicalHistory;
  VaccineHistory? vaccineHistory;
  List<EmergencyContact>? emergencyContacts;
  LifestyleFactors? lifestyleFactors;
  List<UploadDocument>? uploadDocuments;

  Details({
    this.personalDetails,
    this.travelDetails,
    this.medicalHistory,
    this.vaccineHistory,
    this.emergencyContacts,
    this.lifestyleFactors,
    this.uploadDocuments,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
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
  List<String>? medicationTypes;
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
    medicationTypes: json["medicationTypes"] == null ? [] : List<String>.from(json["medicationTypes"]!.map((x) => x)),
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
  UploadDocument();

  factory UploadDocument.fromJson(Map<String, dynamic> json) => UploadDocument(
  );

  Map<String, dynamic> toJson() => {
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
  String? userId;
  String? status;

  RequestDetail({
    this.userId,
    this.status,
  });

  factory RequestDetail.fromJson(Map<String, dynamic> json) => RequestDetail(
    userId: json["userId"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "status": status,
  };
}
