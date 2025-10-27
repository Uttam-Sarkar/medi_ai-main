import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_value/shared_value.dart';
import 'app/core/binding/initial_binding.dart';
import 'app/core/constants/app_constants.dart';
import 'app/core/helper/language_helper.dart';
import 'app/core/helper/network_helper.dart';
import 'app/core/style/app_colors.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  // Set up global error handling for network profiling errors
  FlutterError.onError = (FlutterErrorDetails details) {
    if (NetworkHelper.isNetworkProfilingError(details.exception)) {
      // Log the network profiling error but don't crash the app
      if (kDebugMode) {
        print(
          '🔧 Network profiling error caught and handled: ${details.exception}',
        );
      }
    } else {
      // Handle other errors normally
      FlutterError.presentError(details);
    }
  };
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.edgeToEdge,
          overlays: [SystemUiOverlay.bottom],
        );

        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light, // For iOS
          ),
        );

        return SharedValue.wrapApp(
          GetMaterialApp(
            title: "Medi AI",
            debugShowCheckedModeBanner: false,
            initialRoute: AppPages.INITIAL,
            initialBinding: InitialBinding(),
            builder: EasyLoading.init(),
            theme: ThemeData(
              useMaterial3: false,
              canvasColor: Colors.white,
              primaryColor: AppColors.primaryColor,
              // textTheme: GoogleFonts.poppinsTextTheme(
              //   Theme.of(context).textTheme,
              // ),
            ),
            locale: LocalizationService.getInitialLocale(),
            fallbackLocale: LocalizationService.fallbackLocal,
            translations: LocalizationService(),
            defaultTransition: transition,
            getPages: AppPages.routes,
            enableLog: kDebugMode,
          ),
        );
      },
    ),
  );
}
