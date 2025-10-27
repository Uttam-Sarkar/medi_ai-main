import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../core/style/app_colors.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light, // For iOS
      ),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Obx(
            () => AnimatedOpacity(
              opacity: controller.opacity.value,
              duration: const Duration(milliseconds: 1000),
              child: AnimatedScale(
                scale: controller.scale.value,
                duration: const Duration(milliseconds: 1000),
                child: Hero(
                  tag: 'appLogo',
                  child: ClayContainer(
                    color: AppColors.primaryColor,
                    borderRadius: 60,
                    depth: 30,
                    spread: 6,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.userDoctor,
                            size: 32,
                            color: AppColors.primaryAccentColor,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'appName'.tr,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryAccentColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
