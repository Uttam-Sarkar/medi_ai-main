import 'package:medi/app/core/helper/shared_value_helper.dart';
import 'package:medi/app/network_service/api_client.dart';
import 'package:medi/app/network_service/api_end_points.dart';

import '../../model/default_model.dart';
import '../../model/form/all_forms_response.dart';

class FormRepository {
  Future<List<AllFormsResponse>> getAllForm() async {
    var response = await ApiClient(customBaseUrl: 'https://mediai.tech/api/')
        .get(
          ApiEndPoints.getAllForms(userId: userId.$),
          getAllForm,
          isHeaderRequired: true,
          isLoaderRequired: true,
        );

    // Handle array response
    if (response is List) {
      return response.map((json) => AllFormsResponse.fromJson(json)).toList();
    } else if (response is Map<String, dynamic>) {
      // If single object, wrap in list
      return [AllFormsResponse.fromJson(response)];
    } else {
      return [];
    }
  }


  Future<DefaultModel> deleteForm(String formId) async {
    var response = await ApiClient(customBaseUrl: 'https://mediai.tech/api/')
        .delete(
          ApiEndPoints.deleteForm(formId: formId ),
          {

          },
          getAllForm,
          isHeaderRequired: true,
          isLoaderRequired: true,
        );
    return DefaultModel.fromJson(response);
  }

  Future<DefaultModel> createForm(body) async {
    var response = await ApiClient(customBaseUrl: 'https://mediai.tech/api/')
        .post(
          ApiEndPoints.createForm, body,
          getAllForm,
          isHeaderRequired: true,
          isLoaderRequired: true,
        );
    return DefaultModel.fromJson(response);
  }
}
