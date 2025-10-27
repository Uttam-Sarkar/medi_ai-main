import 'dart:convert';

CreateInvoiceResponse createInvoiceResponseFromJson(String str) =>
    CreateInvoiceResponse.fromJson(json.decode(str));

String createInvoiceResponseToJson(CreateInvoiceResponse data) =>
    json.encode(data.toJson());

class CreateInvoiceResponse {
  Invoice? invoice;
  String? message;

  CreateInvoiceResponse({
    this.invoice,
    this.message,
  });

  factory CreateInvoiceResponse.fromJson(Map<String, dynamic> json) =>
      CreateInvoiceResponse(
        invoice:
            json["invoice"] == null ? null : Invoice.fromJson(json["invoice"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "invoice": invoice?.toJson(),
        "message": message,
      };
}

class Invoice {
  String? patientMediid;
  String? doctorMediid;
  String? hospitalMediid;
  DoctorDetails? doctorDetails;
  DoctorDetails? translatedDoctorDetails;
  PatientDetails? patientDetails;
  PatientDetails? translatedPatientDetails;
  HospitalDetails? hospitalDetails;
  HospitalDetails? translatedHospitalDetails;
  String? patientLanguage;
  String? hospitalLanguage;
  String? hospitalLogo;
  List<Detail>? details;
  List<Detail>? translatedDetails;
  int? discount;
  int? subtotal;
  Tax? tax;
  Tax? translatedTax;
  String? hospitalCurrency;
  String? createdAt;
  bool? isDeleted;
  double? exchangeRate;
  String? createdBy;
  String? id;
  int? v;

  Invoice({
    this.patientMediid,
    this.doctorMediid,
    this.hospitalMediid,
    this.doctorDetails,
    this.translatedDoctorDetails,
    this.patientDetails,
    this.translatedPatientDetails,
    this.hospitalDetails,
    this.translatedHospitalDetails,
    this.patientLanguage,
    this.hospitalLanguage,
    this.hospitalLogo,
    this.details,
    this.translatedDetails,
    this.discount,
    this.subtotal,
    this.tax,
    this.translatedTax,
    this.hospitalCurrency,
    this.createdAt,
    this.isDeleted,
    this.exchangeRate,
    this.createdBy,
    this.id,
    this.v,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        patientMediid: json["patientMediid"],
        doctorMediid: json["doctorMediid"],
        hospitalMediid: json["hospitalMediid"],
        doctorDetails: json["doctorDetails"] == null
            ? null
            : DoctorDetails.fromJson(json["doctorDetails"]),
        translatedDoctorDetails: json["translatedDoctorDetails"] == null
            ? null
            : DoctorDetails.fromJson(json["translatedDoctorDetails"]),
        patientDetails: json["patientDetails"] == null
            ? null
            : PatientDetails.fromJson(json["patientDetails"]),
        translatedPatientDetails: json["translatedPatientDetails"] == null
            ? null
            : PatientDetails.fromJson(json["translatedPatientDetails"]),
        hospitalDetails: json["hospitalDetails"] == null
            ? null
            : HospitalDetails.fromJson(json["hospitalDetails"]),
        translatedHospitalDetails: json["translatedHospitalDetails"] == null
            ? null
            : HospitalDetails.fromJson(json["translatedHospitalDetails"]),
        patientLanguage: json["patientLanguage"],
        hospitalLanguage: json["hospitalLanguage"],
        hospitalLogo: json["hospitalLogo"],
        details: json["details"] == null
            ? []
            : List<Detail>.from(
                json["details"]!.map((x) => Detail.fromJson(x))),
        translatedDetails: json["translatedDetails"] == null
            ? []
            : List<Detail>.from(
                json["translatedDetails"]!.map((x) => Detail.fromJson(x))),
        discount: json["discount"],
        subtotal: json["subtotal"],
        tax: json["tax"] == null ? null : Tax.fromJson(json["tax"]),
        translatedTax: json["translatedTax"] == null
            ? null
            : Tax.fromJson(json["translatedTax"]),
        hospitalCurrency: json["hospitalCurrency"],
        createdAt: json["createdAt"],
        isDeleted: json["isDeleted"],
        exchangeRate: json["exchangeRate"]?.toDouble(),
        createdBy: json["createdBy"],
        id: json["_id"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "patientMediid": patientMediid,
        "doctorMediid": doctorMediid,
        "hospitalMediid": hospitalMediid,
        "doctorDetails": doctorDetails?.toJson(),
        "translatedDoctorDetails": translatedDoctorDetails?.toJson(),
        "patientDetails": patientDetails?.toJson(),
        "translatedPatientDetails": translatedPatientDetails?.toJson(),
        "hospitalDetails": hospitalDetails?.toJson(),
        "translatedHospitalDetails": translatedHospitalDetails?.toJson(),
        "patientLanguage": patientLanguage,
        "hospitalLanguage": hospitalLanguage,
        "hospitalLogo": hospitalLogo,
        "details": details == null
            ? []
            : List<dynamic>.from(details!.map((x) => x.toJson())),
        "translatedDetails": translatedDetails == null
            ? []
            : List<dynamic>.from(translatedDetails!.map((x) => x.toJson())),
        "discount": discount,
        "subtotal": subtotal,
        "tax": tax?.toJson(),
        "translatedTax": translatedTax?.toJson(),
        "hospitalCurrency": hospitalCurrency,
        "createdAt": createdAt,
        "isDeleted": isDeleted,
        "exchangeRate": exchangeRate,
        "createdBy": createdBy,
        "_id": id,
        "__v": v,
      };
}

class Detail {
  String? name;
  int? price;
  int? qty;
  bool? isFreehand;

  Detail({
    this.name,
    this.price,
    this.qty,
    this.isFreehand,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        name: json["name"],
        price: json["price"],
        qty: json["qty"],
        isFreehand: json["isFreehand"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "qty": qty,
        "isFreehand": isFreehand,
      };
}

class DoctorDetails {
  String? fullName;
  String? specialization;
  bool? isSpecializationArray;
  List<String>? originalSpecialization;
  String? qualifications;
  String? email;
  String? phoneNumber;

  DoctorDetails({
    this.fullName,
    this.specialization,
    this.isSpecializationArray,
    this.originalSpecialization,
    this.qualifications,
    this.email,
    this.phoneNumber,
  });

  factory DoctorDetails.fromJson(Map<String, dynamic> json) => DoctorDetails(
        fullName: json["fullName"],
        specialization: json["specialization"],
        isSpecializationArray: json["isSpecializationArray"],
        originalSpecialization: json["originalSpecialization"] == null
            ? []
            : List<String>.from(json["originalSpecialization"]!.map((x) => x)),
        qualifications: json["qualifications"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "specialization": specialization,
        "isSpecializationArray": isSpecializationArray,
        "originalSpecialization": originalSpecialization == null
            ? []
            : List<dynamic>.from(originalSpecialization!.map((x) => x)),
        "qualifications": qualifications,
        "email": email,
        "phoneNumber": phoneNumber,
      };
}

class HospitalDetails {
  String? hospitalMediid;
  String? hospitalName;
  String? hospitalAddress;
  String? hospitalCity;
  String? hospitalCountry;
  String? hospitalPostalCode;
  String? hospitalEmail;
  String? hospitalPhone;

  HospitalDetails({
    this.hospitalMediid,
    this.hospitalName,
    this.hospitalAddress,
    this.hospitalCity,
    this.hospitalCountry,
    this.hospitalPostalCode,
    this.hospitalEmail,
    this.hospitalPhone,
  });

  factory HospitalDetails.fromJson(Map<String, dynamic> json) =>
      HospitalDetails(
        hospitalMediid: json["hospitalMediid"],
        hospitalName: json["hospitalName"],
        hospitalAddress: json["hospitalAddress"],
        hospitalCity: json["hospitalCity"],
        hospitalCountry: json["hospitalCountry"],
        hospitalPostalCode: json["hospitalPostalCode"],
        hospitalEmail: json["hospitalEmail"],
        hospitalPhone: json["hospitalPhone"],
      );

  Map<String, dynamic> toJson() => {
        "hospitalMediid": hospitalMediid,
        "hospitalName": hospitalName,
        "hospitalAddress": hospitalAddress,
        "hospitalCity": hospitalCity,
        "hospitalCountry": hospitalCountry,
        "hospitalPostalCode": hospitalPostalCode,
        "hospitalEmail": hospitalEmail,
        "hospitalPhone": hospitalPhone,
      };
}

class PatientDetails {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  DateTime? dateOfBirth;
  String? gender;
  String? country;
  String? state;
  String? city;
  String? address;
  String? postalCode;
  String? bloodType;

  PatientDetails({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.country,
    this.state,
    this.city,
    this.address,
    this.postalCode,
    this.bloodType,
  });

  factory PatientDetails.fromJson(Map<String, dynamic> json) => PatientDetails(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        gender: json["gender"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        address: json["address"],
        postalCode: json["postalCode"],
        bloodType: json["bloodType"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "dateOfBirth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "country": country,
        "state": state,
        "city": city,
        "address": address,
        "postalCode": postalCode,
        "bloodType": bloodType,
      };
}

class Tax {
  List<OtherTax>? otherTaxes;
  int? consumptionTax;

  Tax({
    this.otherTaxes,
    this.consumptionTax,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        otherTaxes: json["otherTaxes"] == null
            ? []
            : List<OtherTax>.from(
                json["otherTaxes"]!.map((x) => OtherTax.fromJson(x))),
        consumptionTax: json["consumptionTax"],
      );

  Map<String, dynamic> toJson() => {
        "otherTaxes": otherTaxes == null
            ? []
            : List<dynamic>.from(otherTaxes!.map((x) => x.toJson())),
        "consumptionTax": consumptionTax,
      };
}

class OtherTax {
  String? name;
  int? percent;

  OtherTax({
    this.name,
    this.percent,
  });

  factory OtherTax.fromJson(Map<String, dynamic> json) => OtherTax(
        name: json["name"],
        percent: json["percent"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "percent": percent,
      };
}
