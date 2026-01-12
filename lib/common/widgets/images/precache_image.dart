import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app_boilerplate/common/controller/precache_image_controller.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';

class PrecacheWrapper extends StatelessWidget {
  final Widget child;
  final List<String> imagePaths;

  const PrecacheWrapper({
    super.key,
    required this.child,
    required this.imagePaths,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImagePrecacherController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.precacheImages(imagePaths);
    });

    return Obx(() {
      if (!controller.isPrecachingComplete.value) {
        return Scaffold(
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: LinearProgressIndicator(
                  value: controller.progress.value, // 0.0 → 1.0
                  backgroundColor: RColors.darkGrey,
                  color: RColors.primary,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Loading your experience... ${(controller.progress.value * 100).toStringAsFixed(0)}%',
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ],
          )

              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     CircularProgressIndicator(
              //       value: controller.progress.value,
              //     ),
              //     const SizedBox(height: 16),
              //     Text(
              //       'Loading images: ${(controller.progress.value * 100).toStringAsFixed(0)}%',
              //       style: const TextStyle(fontSize: 16),
              //     ),
              //   ],
              // ),
              ),
        );
      }

      return child;
    });
  }
}
