import 'package:get/get.dart';
import 'package:medi/app/core/helper/print_log.dart';
import 'package:medi/app/core/helper/shared_value_helper.dart';
import 'package:medi/app/data/remote/repository/chat/chat_repository.dart';
import 'package:medi/app/data/remote/repository/user/user_repository.dart';
import 'package:medi/app/modules/home/controllers/home_controller.dart';
import '../../../data/remote/model/user/user_data_response.dart';

class ChatListController extends GetxController {
  final chatList = <RequestDetail>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getChatList();
  }

  void getChatList() async {
      isLoading.value = true;
      chatList.clear();

      if (userRole.$ == 'patient') {
        Get.find<HomeController>().getUserData();
        if (Get.find<HomeController>().userData.first.requestDetails != null) {
          chatList.value = Get.find<HomeController>()
              .userData
              .first
              .requestDetails!
              .cast<RequestDetail>();
        }
        return;
      } else if (userRole.$ == 'hospital') {
        var response = await ChatRepository().getPatientListForChat();

        if (response.success) {
          response.data.forEach((user) {
            // printLog('Patient: ${user.name}, Requests: ${user.requestDetails?.length ?? 0}');

            user.requestDetails.forEach((request) {
              // Convert PatientData.RequestDetail to user_data_response RequestDetail
              chatList.add(RequestDetail(
                id: user.id,
                email: user.email,
                phoneNumber: user.phoneNumber,
                mediid: user.mediid,
                owner: user.owner,
                password: user.password,
                role: user.role,
                verificationToken: user.verificationToken,
                createdBy: user.createdBy,
                v: user.v,
                details: RequestDetailDetails(
                  generalInfo: GeneralInfo(
                    name: '${user.details.personalDetails.firstName} ${user.details.personalDetails.lastName}',
                    phoneNumber: user.phoneNumber, // Use user's phone number instead
                    email: user.details.personalDetails.email,
                    country: user.details.personalDetails.country,
                    language: user.details.personalDetails.language,
                    address: user.details.personalDetails.address1,
                    city: user.details.personalDetails.city,
                    postalCode: user.details.personalDetails.postalCode,
                  ),
                ),
                status: request.status,
              ));
            });

          });
        } else {
          printLog('Failed to fetch patient data: ${response.message}');
        }
      } else {}
      isLoading.value = false;
  }
}
