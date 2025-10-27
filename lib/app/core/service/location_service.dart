import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../helper/print_log.dart';
import '../style/app_colors.dart';

Future<Map<String, String>> getLocation() async {
  printLog('🌍 Starting location request...');
  
  // Check if location services are enabled
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    printLog('❌ Location services are disabled');
    Get.snackbar(
      'Location Services Disabled',
      'Please enable location services in your device settings.',
      backgroundColor: AppColors.primaryColor,
      snackPosition: SnackPosition.BOTTOM,
    );
    return {"lat": "0.0", "lon": "0.0"};
  }
  printLog('✅ Location services are enabled');

  // Check location permission using Geolocator
  LocationPermission permission = await Geolocator.checkPermission();
  printLog('📍 Current permission: $permission');
  
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    printLog('📍 Permission after request: $permission');
  }
  
  if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
    try {
      printLog('🔄 Requesting current position...');
      Position? position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
      
      printLog('📍 Position received: lat=${position.latitude}, lon=${position.longitude}');
      
      if (position.isMocked) {
        printLog('⚠️ Mocked location detected');
        Get.snackbar(
          "Warning!",
          "Mocked location detected. Please disable any mock location settings or apps to ensure accurate service.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
        );
        return {"lat": "0.0", "lon": "0.0"};
      } else {
        printLog('✅ Valid location obtained: ${position.latitude}, ${position.longitude}');
        return {"lat": position.latitude.toString(), "lon": position.longitude.toString()};
      }
    } catch (e) {
      printLog('❌ Error getting location: $e');
      Get.snackbar(
        'Location Error',
        'Failed to get current location: ${e.toString()}',
        backgroundColor: AppColors.primaryColor,
        snackPosition: SnackPosition.BOTTOM,
      );
      return {"lat": "0.0", "lon": "0.0"};
    }
  } else if (permission == LocationPermission.denied) {
    printLog('❌ Location permission denied');
    Get.snackbar(
      'Error',
      'Location permission denied',
      backgroundColor: AppColors.primaryColor,
      snackPosition: SnackPosition.BOTTOM,
    );
    return {"lat": "0.0", "lon": "0.0"};
  } else if (permission == LocationPermission.deniedForever) {
    printLog('❌ Location permission permanently denied');
    Get.snackbar(
      'Error',
      'Location permission permanently denied. Please enable it from settings.',
      backgroundColor: AppColors.primaryColor,
      snackPosition: SnackPosition.BOTTOM,
    );
    await Geolocator.openAppSettings();
    return {"lat": "0.0", "lon": "0.0"};
  }
  printLog('❌ Unknown permission status: $permission');
  return {"lat": "0.0", "lon": "0.0"};
}