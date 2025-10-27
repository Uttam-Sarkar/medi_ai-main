import 'package:get/get.dart';

import '../modules/add_doctor/bindings/add_doctor_binding.dart';
import '../modules/add_doctor/views/add_doctor_view.dart';
import '../modules/add_form/bindings/add_form_binding.dart';
import '../modules/add_form/views/add_form_view.dart';
import '../modules/add_invoice/bindings/add_invoice_binding.dart';
import '../modules/add_invoice/views/add_invoice_view.dart';
import '../modules/add_patient/bindings/add_patient_binding.dart';
import '../modules/add_patient/views/add_patient_view.dart';
import '../modules/ambulance/bindings/ambulance_binding.dart';
import '../modules/ambulance/views/ambulance_view.dart';
import '../modules/ambulance_registration/bindings/ambulance_registration_binding.dart';
import '../modules/ambulance_registration/views/ambulance_registration_view.dart';
import '../modules/chat_list/bindings/chat_list_binding.dart';
import '../modules/chat_list/views/chat_list_view.dart';
import '../modules/chatbox/bindings/chatbox_binding.dart';
import '../modules/chatbox/views/chatbox_view.dart';
import '../modules/chatbox_socket/bindings/chatbox_socket_binding.dart';
import '../modules/chatbox_socket/views/chatbox_socket_view.dart';
import '../modules/doctor/bindings/doctor_binding.dart';
import '../modules/doctor/views/doctor_view.dart';
import '../modules/form/bindings/form_binding.dart';
import '../modules/form/views/form_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/hospital/bindings/hospital_binding.dart';
import '../modules/hospital/views/hospital_view.dart';
import '../modules/hospital_registration/bindings/hospital_registration_binding.dart';
import '../modules/hospital_registration/views/hospital_registration_view.dart';
import '../modules/invoices/bindings/invoices_binding.dart';
import '../modules/invoices/views/invoices_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/medical_history/bindings/medical_history_binding.dart';
import '../modules/medical_history/views/medical_history_view.dart';
import '../modules/my_symptoms/bindings/my_symptoms_binding.dart';
import '../modules/my_symptoms/views/my_symptoms_view.dart';
import '../modules/news/bindings/news_binding.dart';
import '../modules/news/views/news_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/patient_registration/bindings/patient_registration_binding.dart';
import '../modules/patient_registration/views/patient_registration_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/travel_history/bindings/travel_history_binding.dart';
import '../modules/travel_history/views/travel_history_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(name: _Paths.HOME, page: () => HomeView(), binding: HomeBinding()),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOSPITAL,
      page: () => const HospitalView(),
      binding: HospitalBinding(),
    ),
    GetPage(
      name: _Paths.DOCTOR,
      page: () => const DoctorView(),
      binding: DoctorBinding(),
    ),
    GetPage(
      name: _Paths.AMBULANCE,
      page: () => const AmbulanceView(),
      binding: AmbulanceBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT_REGISTRATION,
      page: () => const PatientRegistrationView(),
      binding: PatientRegistrationBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.HOSPITAL_REGISTRATION,
      page: () => const HospitalRegistrationView(),
      binding: HospitalRegistrationBinding(),
    ),
    GetPage(
      name: _Paths.AMBULANCE_REGISTRATION,
      page: () => const AmbulanceRegistrationView(),
      binding: AmbulanceRegistrationBinding(),
    ),
    GetPage(
      name: _Paths.CHATBOX,
      page: () => const ChatboxView(),
      binding: ChatboxBinding(),
    ),
    GetPage(
      name: _Paths.MEDICAL_HISTORY,
      page: () => const MedicalHistoryView(),
      binding: MedicalHistoryBinding(),
    ),
    GetPage(
      name: _Paths.NEWS,
      page: () => const NewsView(),
      binding: NewsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PATIENT,
      page: () => const AddPatientView(),
      binding: AddPatientBinding(),
    ),
    GetPage(
      name: _Paths.MY_SYMPTOMS,
      page: () => const MySymptomsView(),
      binding: MySymptomsBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.INVOICES,
      page: () => const InvoicesView(),
      binding: InvoicesBinding(),
    ),
    GetPage(
      name: _Paths.ADD_INVOICE,
      page: () => const AddInvoiceView(),
      binding: AddInvoiceBinding(),
    ),
    GetPage(
      name: _Paths.ADD_FORM,
      page: () => const AddFormView(),
      binding: AddFormBinding(),
    ),
    GetPage(
      name: _Paths.FORM,
      page: () => const FormView(),
      binding: FormBinding(),
    ),
    GetPage(
      name: _Paths.ADD_DOCTOR,
      page: () => const AddDoctorView(),
      binding: AddDoctorBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_LIST,
      page: () => const ChatListView(),
      binding: ChatListBinding(),
    ),
    GetPage(
      name: _Paths.TRAVEL_HISTORY,
      page: () => const TravelHistoryView(),
      binding: TravelHistoryBinding(),
    ),
    GetPage(
      name: _Paths.CHATBOX_SOCKET,
      page: () => const ChatboxSocketView(),
      binding: ChatboxSocketBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
  ];
}
