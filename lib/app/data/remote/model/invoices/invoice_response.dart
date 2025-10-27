import 'dart:convert';

InvoiceResponse invoiceResponseFromJson(String str) =>
    InvoiceResponse.fromJson(json.decode(str));

String invoiceResponseToJson(InvoiceResponse data) =>
    json.encode(data.toJson());

class InvoiceResponse {
  List<Invoice>? invoices;

  InvoiceResponse({
    this.invoices,
  });

  factory InvoiceResponse.fromJson(Map<String, dynamic> json) =>
      InvoiceResponse(
        invoices: json["invoices"] == null
            ? []
            : List<Invoice>.from(
                json["invoices"]!.map((x) => Invoice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "invoices": invoices == null
            ? []
            : List<dynamic>.from(invoices!.map((x) => x.toJson())),
      };
}

class Invoice {
  String? id;
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
  int? v;
  String? createdBy;

  Invoice({
    this.id,
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
    this.v,
    this.createdBy,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["_id"],
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
        v: json["__v"],
        createdBy: json["createdBy"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
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
        "__v": v,
        "createdBy": createdBy,
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
  String? qualifications;
  String? email;
  String? phoneNumber;
  bool? isSpecializationArray;
  dynamic originalSpecialization;

  DoctorDetails({
    this.fullName,
    this.specialization,
    this.qualifications,
    this.email,
    this.phoneNumber,
    this.isSpecializationArray,
    this.originalSpecialization,
  });

  factory DoctorDetails.fromJson(Map<String, dynamic> json) => DoctorDetails(
        fullName: json["fullName"],
        specialization: json["specialization"],
        qualifications: json["qualifications"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        isSpecializationArray: json["isSpecializationArray"],
        originalSpecialization: json["originalSpecialization"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "specialization": specialization,
        "qualifications": qualifications,
        "email": email,
        "phoneNumber": phoneNumber,
        "isSpecializationArray": isSpecializationArray,
        "originalSpecialization": originalSpecialization,
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
