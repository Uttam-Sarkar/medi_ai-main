import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../core/style/app_colors.dart';
import '../model/home_items.dart';

class ClayCircleDashboardCard extends StatelessWidget {
  final HomeItem item;
  final Color baseColor;

  const ClayCircleDashboardCard({
    super.key,
    required this.item,
    required this.baseColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(item.route),
      child: ClayContainer(
        color: baseColor,
        borderRadius: 60,
        depth: 30,
        spread: 6,
        child: SizedBox(
          width: 96,
          height: 96,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(item.icon, size: 32, color: AppColors.primaryAccentColor),
              const SizedBox(height: 8),
              Text(
                item.label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryAccentColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
