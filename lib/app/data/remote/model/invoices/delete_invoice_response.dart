import 'dart:convert';

DeleteInvoiceResponse deleteInvoiceResponseFromJson(String str) =>
    DeleteInvoiceResponse.fromJson(json.decode(str));

String deleteInvoiceResponseToJson(DeleteInvoiceResponse data) =>
    json.encode(data.toJson());

class DeleteInvoiceResponse {
  String? message;
  bool? success;

  DeleteInvoiceResponse({
    this.message,
    this.success,
  });

  factory DeleteInvoiceResponse.fromJson(Map<String, dynamic> json) =>
      DeleteInvoiceResponse(
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
      };
}
