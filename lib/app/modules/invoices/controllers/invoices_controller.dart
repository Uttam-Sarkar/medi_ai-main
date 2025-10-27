import 'package:get/get.dart';
import 'package:medi/app/core/helper/app_widgets.dart';
import 'package:medi/app/data/remote/model/invoices/invoice_response.dart';
import 'package:medi/app/data/remote/repository/invoices/invoices_repository.dart';

class InvoicesController extends GetxController {
  var isLoading = false.obs;
  var invoices = <Invoice>[].obs;
  var filteredInvoices = <Invoice>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getInvoices();
  }

  Future<void> deleteInvoice(String id) async {
    var response = await InvoicesRepository().deleteInvoice(id);
    if (response.success == true) {
      getInvoices();
    } else {
      AppWidgets().getSnackBar(message: response.message?.tr ?? 'Error'.tr);
    }
  }

  Future<void> toggleInvoiceStatus(String id) async {
    // Logic to toggle invoice status
    final index = invoices.indexWhere((invoice) => invoice.id == id);
    if (index != -1) {
      // invoices[index].isDeleted = !invoices[index].isDeleted;
      invoices.refresh();
      filteredInvoices.refresh();
    }
  }

  Future<void> getInvoices() async {
    var response = await InvoicesRepository().getAllInvoices();
    if (response.invoices != null) {
      invoices.clear();
      invoices.value = response.invoices!;
    }
  }
}

extension on Invoice {
  // bool matchesQuery(String query) {
  //   return id.contains(query) ||
  //       patientDetails.firstName.contains(query) ||
  //       patientDetails.lastName.contains(query) ||
  //       hospitalDetails.hospitalName.contains(query);
  // }
}
