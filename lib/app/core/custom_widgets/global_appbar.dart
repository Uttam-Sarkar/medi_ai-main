import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/app_colors.dart';

AppBar globalAppBar(BuildContext context, appbarTitle) {
  return AppBar(
    elevation: 0.5,
    backgroundColor: AppColors.primaryColor,
    leading: InkWell(
        onTap: () => Get.back(),
        child: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.primaryAccentColor,
        )),
    title: InkWell(
      onTap: () => Get.back(),
      child: Text(
        appbarTitle,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryAccentColor,
        ),
      ),
    ),
    centerTitle: false,
    titleSpacing: -10,
  );
}
