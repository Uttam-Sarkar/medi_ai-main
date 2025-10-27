import 'dart:convert';

CreateInvoiceRequest createInvoiceRequestFromJson(String str) =>
    CreateInvoiceRequest.fromJson(json.decode(str));

String createInvoiceRequestToJson(CreateInvoiceRequest data) =>
    json.encode(data.toJson());

class CreateInvoiceRequest {
  String? patientMediid;
  String? doctorMediid;
  List<Detail>? details;
  int? discount;
  int? subtotal;
  Tax? tax;
  HospitalDetails? hospitalDetails;
  String? hospitalLogo;
  String? hospitalCurrency;
  String? hospitalLanguage;
  int? date;
  String? createdBy;

  CreateInvoiceRequest({
    this.patientMediid,
    this.doctorMediid,
    this.details,
    this.discount,
    this.subtotal,
    this.tax,
    this.hospitalDetails,
    this.hospitalLogo,
    this.hospitalCurrency,
    this.hospitalLanguage,
    this.date,
    this.createdBy,
  });

  factory CreateInvoiceRequest.fromJson(Map<String, dynamic> json) =>
      CreateInvoiceRequest(
        patientMediid: json["patientMediid"],
        doctorMediid: json["doctorMediid"],
        details: json["details"] == null
            ? []
            : List<Detail>.from(
                json["details"]!.map((x) => Detail.fromJson(x))),
        discount: json["discount"],
        subtotal: json["subtotal"],
        tax: json["tax"] == null ? null : Tax.fromJson(json["tax"]),
        hospitalDetails: json["hospitalDetails"] == null
            ? null
            : HospitalDetails.fromJson(json["hospitalDetails"]),
        hospitalLogo: json["hospitalLogo"],
        hospitalCurrency: json["hospitalCurrency"],
        hospitalLanguage: json["hospitalLanguage"],
        date: json["date"],
        createdBy: json["createdBy"],
      );

  Map<String, dynamic> toJson() => {
        "patientMediid": patientMediid,
        "doctorMediid": doctorMediid,
        "details": details == null
            ? []
            : List<dynamic>.from(details!.map((x) => x.toJson())),
        "discount": discount,
        "subtotal": subtotal,
        "tax": tax?.toJson(),
        "hospitalDetails": hospitalDetails?.toJson(),
        "hospitalLogo": hospitalLogo,
        "hospitalCurrency": hospitalCurrency,
        "hospitalLanguage": hospitalLanguage,
        "date": date,
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
