import 'package:medi/app/core/helper/shared_value_helper.dart';
import 'package:medi/app/data/remote/model/ambulance/add_patient_response.dart';
import 'package:medi/app/data/remote/model/user/ambulance_data_response.dart';
import 'package:medi/app/data/remote/model/user/user_data_response.dart';
import 'package:medi/app/network_service/api_client.dart';
import 'package:medi/app/network_service/api_end_points.dart';

import '../../model/ambulance/patient_list_response.dart';

class AmbulanceRepository {
  Future<AddPatientResponse> addPatient(String id) async {
    var response = await ApiClient().post(
      ApiEndPoints.addPatient,
      {"mediId": id, "userId": userId.$},
      addPatient,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return safeFromJson(
      response,
      (json) => AddPatientResponse.fromJson(json),
      AddPatientResponse(),
    );
  }

  Future<PatientListResponse> getPatientList() async {
    var response = await ApiClient().post(
      ApiEndPoints.userData,
      {
        "filter": {
          "role": "patient",
          "requestDetails"
                  ".userId":
              userId.$,
        },
      },
      getPatientList,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return safeFromJson(
      response,
      (json) => PatientListResponse.fromJson(json),
      PatientListResponse(),
    );
  }
}
