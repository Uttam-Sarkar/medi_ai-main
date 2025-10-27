import 'package:medi/app/core/helper/shared_value_helper.dart';
import 'package:medi/app/data/remote/model/doctor/doctor_list_response.dart';
import 'package:medi/app/network_service/api_client.dart';
import 'package:medi/app/network_service/api_end_points.dart';

import '../../model/default_model.dart';
import '../../model/form/all_forms_response.dart';

class DoctorRepository {
  Future<DoctorListResponse> getDoctorList() async {
    var response = await ApiClient().post(
      ApiEndPoints.userData,
      {
        "filter": {"role": "doctor", "createdBy": userId.$},
      },
      getDoctorList,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );

    return safeFromJson(
      response,
      (json) => DoctorListResponse.fromJson(json),
      DoctorListResponse(),
    );
  }

  Future<DefaultModel> createDoctor(body) async {
    var response = await ApiClient().post(
      ApiEndPoints.register,
     body,
      createDoctor,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return safeFromJson(
      response,
          (json) => DefaultModel.fromJson(json),
      DefaultModel(),
    );
  }
}
