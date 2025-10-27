import 'package:medi/app/core/helper/shared_value_helper.dart';

class ApiEndPoints {
  //Authentication
  static String login = "login";
  static String register = "register";
  static String logout = "logout";
  static String updateUserDetails = "update-details";

  //Authentication

  //Dashboard

  static String userData = "get-data";
  static String getHospitals = "get-hospitals";

  //Dashboard

  //Chat
  static String sendMessage = "chat/assistant";
  static String chatList = "formSubmission/forms/${userId
      .$}/translate/${selectedLanguage.$}";
  static String chatData = "get-chats";

  //Chat

  //Admin
  static String driverJobList = "driver_jobs_list_app";
  static String driverList = "driver-list";
  static String driverProfileList = "driver_profiles_list_app";
  static String driverJobs = "driver_jobs_store_app";
  static String newDriver = "driver_profiles_store_app";

  //Admin

  //news
  static String newsList = "news/translate/all/en";

  //news

  // Add Patient for Ambulance
  static String addPatient = "add-patient";

  //Add Patient for Ambulance

  // Hospital
  static String invoice = "invoice/get-invoices";

  static String invoiceCategories({required String categoryId}) =>
      "invoice/categories/$categoryId";
  static String deleteInvoice = "invoice/delete-invoice";
  static String hospitals = "invoice/delete-invoice";
  static String patients = "invoice/delete-invoice";
  static String addInvoice = "invoice/add-invoice";
  // Hospital

//form
  static String getAllForms({required String userId}) =>
      "form/forms/by-creator/$userId";

  static String deleteForm({required String formId}) =>
      "form/delete/$formId";


  static String createForm = "form/create";
  static String submitForm = "forms/submit-form";

//form



// Notification

static String notification = "formSubmission/forms/67c47960b0e91c39d26951d2/translate/${selectedLanguage.$}";
static String userInvitation = "invitation";

// Notification

}
