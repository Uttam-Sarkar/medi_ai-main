import 'dart:convert';

PatientChatListResponse patientChatListResponseFromJson(String str) => PatientChatListResponse.fromJson(json.decode(str));

String patientChatListResponseToJson(PatientChatListResponse data) => json.encode(data.toJson());

class PatientChatListResponse {
  String message;
  bool success;
  List<Datum> data;

  PatientChatListResponse({
    required this.message,
    required this.success,
    required this.data,
  });

  factory PatientChatListResponse.fromJson(Map<String, dynamic> json) => PatientChatListResponse(
    message: json["message"],
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
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
  List<RequestDetail> requestDetails;

  Datum({
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
    required this.requestDetails,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    requestDetails: List<RequestDetail>.from(json["requestDetails"].map((x) => RequestDetail.fromJson(x))),
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
    "requestDetails": List<dynamic>.from(requestDetails.map((x) => x.toJson())),
  };
}

class Details {
  PersonalDetails personalDetails;
  TravelDetails travelDetails;
  MedicalHistory medicalHistory;
  VaccineHistory vaccineHistory;
  List<EmergencyContact> emergencyContacts;
  LifestyleFactors lifestyleFactors;
  List<UploadDocument> uploadDocuments;

  Details({
    required this.personalDetails,
    required this.travelDetails,
    required this.medicalHistory,
    required this.vaccineHistory,
    required this.emergencyContacts,
    required this.lifestyleFactors,
    required this.uploadDocuments,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    personalDetails: PersonalDetails.fromJson(json["personalDetails"]),
    travelDetails: TravelDetails.fromJson(json["travelDetails"]),
    medicalHistory: MedicalHistory.fromJson(json["medicalHistory"]),
    vaccineHistory: VaccineHistory.fromJson(json["vaccineHistory"]),
    emergencyContacts: List<EmergencyContact>.from(json["emergencyContacts"].map((x) => EmergencyContact.fromJson(x))),
    lifestyleFactors: LifestyleFactors.fromJson(json["lifestyleFactors"]),
    uploadDocuments: List<UploadDocument>.from(json["uploadDocuments"].map((x) => UploadDocument.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "personalDetails": personalDetails.toJson(),
    "travelDetails": travelDetails.toJson(),
    "medicalHistory": medicalHistory.toJson(),
    "vaccineHistory": vaccineHistory.toJson(),
    "emergencyContacts": List<dynamic>.from(emergencyContacts.map((x) => x.toJson())),
    "lifestyleFactors": lifestyleFactors.toJson(),
    "uploadDocuments": List<dynamic>.from(uploadDocuments.map((x) => x.toJson())),
  };
}

class EmergencyContact {
  String nameOfEmergencyContact;
  String phoneNumber;
  String relationship;
  String email;
  String mediaiId;

  EmergencyContact({
    required this.nameOfEmergencyContact,
    required this.phoneNumber,
    required this.relationship,
    required this.email,
    required this.mediaiId,
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
  String smokingHabits;
  String alcoholConsumptions;
  String physicalActivityLevel;
  String preferences;

  LifestyleFactors({
    required this.smokingHabits,
    required this.alcoholConsumptions,
    required this.physicalActivityLevel,
    required this.preferences,
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
  String medicalCondition;
  List<String> sicknessHistory;
  List<String> surgicalHistory;
  List<String> allergy;
  String medication;
  List<String> medicationTypes;
  List<dynamic> customInputMedications;
  String? currentSymptoms;

  MedicalHistory({
    required this.medicalCondition,
    required this.sicknessHistory,
    required this.surgicalHistory,
    required this.allergy,
    required this.medication,
    required this.medicationTypes,
    required this.customInputMedications,
    this.currentSymptoms,
  });

  factory MedicalHistory.fromJson(Map<String, dynamic> json) => MedicalHistory(
    medicalCondition: json["medicalCondition"],
    sicknessHistory: List<String>.from(json["sicknessHistory"].map((x) => x)),
    surgicalHistory: List<String>.from(json["surgicalHistory"].map((x) => x)),
    allergy: List<String>.from(json["allergy"].map((x) => x)),
    medication: json["medication"],
    medicationTypes: List<String>.from(json["medicationTypes"].map((x) => x)),
    customInputMedications: List<dynamic>.from(json["customInputMedications"].map((x) => x)),
    currentSymptoms: json["currentSymptoms"],
  );

  Map<String, dynamic> toJson() => {
    "medicalCondition": medicalCondition,
    "sicknessHistory": List<dynamic>.from(sicknessHistory.map((x) => x)),
    "surgicalHistory": List<dynamic>.from(surgicalHistory.map((x) => x)),
    "allergy": List<dynamic>.from(allergy.map((x) => x)),
    "medication": medication,
    "medicationTypes": List<dynamic>.from(medicationTypes.map((x) => x)),
    "customInputMedications": List<dynamic>.from(customInputMedications.map((x) => x)),
    "currentSymptoms": currentSymptoms,
  };
}

class PersonalDetails {
  String firstName;
  String lastName;
  String email;
  String language;
  DateTime dateOfBirth;
  String age;
  String gender;
  String country;
  String state;
  String address1;
  String address2;
  String bloodType;
  String city;
  String postalCode;
  String passportNumber;
  String height;
  String weight;

  PersonalDetails({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.language,
    required this.dateOfBirth,
    required this.age,
    required this.gender,
    required this.country,
    required this.state,
    required this.address1,
    required this.address2,
    required this.bloodType,
    required this.city,
    required this.postalCode,
    required this.passportNumber,
    required this.height,
    required this.weight,
  });

  factory PersonalDetails.fromJson(Map<String, dynamic> json) => PersonalDetails(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    language: json["language"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
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
    "dateOfBirth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
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
  String pregnant;
  String nursing;
  String medication;
  String daysAgoArrived;
  String daysStay;
  String arriveFrom;
  String visitedCountries;
  String symptomsStart;
  String medicalInsurance;
  String medicalFee;
  String travelReason;
  String dateOfTravel;
  String travelLocation;

  TravelDetails({
    required this.pregnant,
    required this.nursing,
    required this.medication,
    required this.daysAgoArrived,
    required this.daysStay,
    required this.arriveFrom,
    required this.visitedCountries,
    required this.symptomsStart,
    required this.medicalInsurance,
    required this.medicalFee,
    required this.travelReason,
    required this.dateOfTravel,
    required this.travelLocation,
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
  List<ImmunizationHistory> immunizationHistory;

  VaccineHistory({
    required this.immunizationHistory,
  });

  factory VaccineHistory.fromJson(Map<String, dynamic> json) => VaccineHistory(
    immunizationHistory: List<ImmunizationHistory>.from(json["immunizationHistory"].map((x) => ImmunizationHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "immunizationHistory": List<dynamic>.from(immunizationHistory.map((x) => x.toJson())),
  };
}

class ImmunizationHistory {
  String vaccines;
  DateTime dateOfVaccine;
  String hasReceivedCovidVaccine;
  String dosesReceived;
  String timeSinceLastVaccination;

  ImmunizationHistory({
    required this.vaccines,
    required this.dateOfVaccine,
    required this.hasReceivedCovidVaccine,
    required this.dosesReceived,
    required this.timeSinceLastVaccination,
  });

  factory ImmunizationHistory.fromJson(Map<String, dynamic> json) => ImmunizationHistory(
    vaccines: json["vaccines"],
    dateOfVaccine: DateTime.parse(json["dateOfVaccine"]),
    hasReceivedCovidVaccine: json["hasReceivedCovidVaccine"],
    dosesReceived: json["dosesReceived"],
    timeSinceLastVaccination: json["timeSinceLastVaccination"],
  );

  Map<String, dynamic> toJson() => {
    "vaccines": vaccines,
    "dateOfVaccine": "${dateOfVaccine.year.toString().padLeft(4, '0')}-${dateOfVaccine.month.toString().padLeft(2, '0')}-${dateOfVaccine.day.toString().padLeft(2, '0')}",
    "hasReceivedCovidVaccine": hasReceivedCovidVaccine,
    "dosesReceived": dosesReceived,
    "timeSinceLastVaccination": timeSinceLastVaccination,
  };
}

class RequestDetail {
  String userId;
  String status;

  RequestDetail({
    required this.userId,
    required this.status,
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
