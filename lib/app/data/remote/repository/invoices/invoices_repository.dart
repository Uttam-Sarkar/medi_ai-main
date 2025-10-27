import 'package:medi/app/core/helper/shared_value_helper.dart';
import 'package:medi/app/data/remote/model/invoices/create_invoice_response.dart';
import 'package:medi/app/data/remote/model/invoices/delete_invoice_response.dart';
import 'package:medi/app/data/remote/model/invoices/doctor_response.dart';
import 'package:medi/app/data/remote/model/invoices/invoice_response.dart';
import 'package:medi/app/data/remote/model/invoices/patient_response.dart';
import 'package:medi/app/network_service/api_client.dart';
import 'package:medi/app/network_service/api_end_points.dart';

class InvoicesRepository {
  Future<InvoiceResponse> getAllInvoices() async {
    var response =
        await ApiClient(customBaseUrl: 'https://mediai.tech/api/').post(
      ApiEndPoints.invoice,
      {"hospitalMediid": '88710521h'},
      getAllInvoices,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return safeFromJson(
      response,
      (json) => InvoiceResponse.fromJson(json),
      InvoiceResponse(invoices: []),
    );
  }

  Future<DeleteInvoiceResponse> deleteInvoice(String deleteInvoice) async {
    var response =
        await ApiClient(customBaseUrl: 'https://mediai.tech/api/').post(
      ApiEndPoints.deleteInvoice,
      {"invoiceId": deleteInvoice},
      deleteInvoice,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return safeFromJson(
      response,
      (json) => DeleteInvoiceResponse.fromJson(json),
      DeleteInvoiceResponse(),
    );
  }

  Future<InvoiceResponse> getCategories(String categoryId) async {
    var response =
        await ApiClient(customBaseUrl: 'https://mediai.tech/api/').get(
      ApiEndPoints.invoiceCategories(categoryId: categoryId),
      getCategories,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return safeFromJson(
      response,
      (json) => InvoiceResponse.fromJson(json),
      InvoiceResponse(invoices: []),
    );
  }

  Future<PatientListResponse> getAllPatients() async {
    var response = await ApiClient().post(
      ApiEndPoints.userData,
      {
        "filter": {
          "role": "patient",
          "requestDetails"
              ".userId": userId.$,
        },
      },
      getAllPatients,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return safeFromJson(
      response,
      (json) => PatientListResponse.fromJson(json),
      PatientListResponse(),
    );
  }

  Future<DoctorListResponse> getAllDoctors() async {
    var response = await ApiClient().post(
      ApiEndPoints.userData,
      {
        "filter": {"role": "doctor", "createdBy": userId.$},
      },
      getAllDoctors,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return safeFromJson(
      response,
      (json) => DoctorListResponse.fromJson(json),
      DoctorListResponse(),
    );
  }

  Future<CreateInvoiceResponse> addInvoice(body) async {
    var response =
        await ApiClient(customBaseUrl: 'https://mediai.tech/api/').post(
      ApiEndPoints.addInvoice,
      body,
      addInvoice,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return safeFromJson(
      response,
      (json) => CreateInvoiceResponse.fromJson(json),
      CreateInvoiceResponse(),
    );
  }
}
