import 'package:medi/app/core/helper/shared_value_helper.dart';
import 'package:medi/app/data/remote/model/hospital/hospitals_response.dart';
import 'package:medi/app/data/remote/model/user/ambulance_data_response.dart';
import 'package:medi/app/data/remote/model/user/patient_data_response.dart';
import 'package:medi/app/data/remote/model/user/user_data_response.dart';
import 'package:medi/app/network_service/api_client.dart';
import 'package:medi/app/network_service/api_end_points.dart';

class UserRepository {
  Future<UserDataResponse> getUserData() async {
    var response = await ApiClient().post(
      ApiEndPoints.userData,
      userRole.$ == 'patient'
          ? {
              "filter": {"_id": userId.$},
            }
          :  {
              "filter": {
                "role": 'patient',
                "requestDetails"
                        ".userId":
                    userId.$,
              },
            },
      getUserData,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return safeFromJson(
      response,
      (json) => UserDataResponse.fromJson(json),
      UserDataResponse(message: '', success: false, data: []),
    );
  }


  Future<PatientDataResponse> getPatientData() async {
    var response = await ApiClient().post(
      ApiEndPoints.userData, {
              "filter": {
                "role": 'patient',
                "requestDetails"
                        ".userId":
                    userId.$,
              },
            },
      getPatientData,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return safeFromJson(
      response,
      (json) => PatientDataResponse.fromJson(json),
      PatientDataResponse(message: '', success: false, data: []),
    );
  }

  Future<AmbulanceDataResponse> getAmbulanceData() async {
    var response = await ApiClient().post(
      ApiEndPoints.userData,
      {
        "filter": {"role": "ambulance"},
      },
      getUserData,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return safeFromJson(
      response,
      (json) => AmbulanceDataResponse.fromJson(json),
      AmbulanceDataResponse(),
    );
  }

  Future<HospitalResponse> getHospitalData(
    String lat,
    String lon,
    speciality,
  ) async {
    var response = await ApiClient().post(
      ApiEndPoints.getHospitals,
      {
        "filter": {"role": "hospital"},
        "specialties": speciality,
        "currentLocat"
            "ion": {
          "latitude": lat,
          "longitude": lon,
        },
      },
      getHospitalData,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return safeFromJson(
      response,
      (json) => HospitalResponse.fromJson(json),
      HospitalResponse(
        page: 0,
        pageSize: 0,
        totalHospitals: 0,
        totalPages: 0,
        pagination: Pagination(
          currentPage: 0,
          totalPages: 0,
          totalCount: 0,
          limit: 0,
        ),
        data: [],
      ),
    );
  }
}
