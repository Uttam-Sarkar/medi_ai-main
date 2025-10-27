import 'package:shared_value/shared_value.dart';

final SharedValue<bool> isLoggedIn = SharedValue(
  value: false,
  key: "isLoggedIn",
);
final SharedValue<String> accessToken = SharedValue(
  value: "",
  key: "accessToken",
);

final SharedValue<String> email = SharedValue(value: "", key: "email");
final SharedValue<String> userId = SharedValue(value: "", key: "userId");
final SharedValue<String> userRole = SharedValue(value: "", key: "role");
final SharedValue<String> mediId = SharedValue(value: "", key: "mediId");
final SharedValue<String> gender = SharedValue(value: "", key: "gender");

final SharedValue<String> userName = SharedValue(value: "", key: "userName");

final SharedValue<bool> onBoardView = SharedValue(
  value: true,
  key: "onBoardView",
);

final SharedValue<bool> translateDocs = SharedValue(
  value: false,
  key: "translateDocs",
);
final SharedValue<String> selectedLanguage = SharedValue(
  value: "en",
  key: "selectedLanguage",
);
