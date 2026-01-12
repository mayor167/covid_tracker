import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ImagePrecacherController extends GetxController {
  final RxDouble progress = 0.0.obs;
  final RxBool isPrecachingComplete = false.obs;
  final RxSet<String> precachedImages = <String>{}.obs;

  Future<void> precacheImages(List<String> imagePaths) async {
    isPrecachingComplete.value = false;
    progress.value = 0.0;
    
    for (int i = 0; i < imagePaths.length; i++) {
      try {
        await precacheImage(AssetImage(imagePaths[i]), Get.context!);
        precachedImages.add(imagePaths[i]);
        progress.value = (i + 1) / imagePaths.length;
      } catch (e) {
      //  print('Failed to precache ${imagePaths[i]}: $e');
      }
    }
    
    isPrecachingComplete.value = true;
  }

  Future<void> precacheImageIfNeeded(String imagePath) async {
    if (!precachedImages.contains(imagePath)) {
      try {
        await precacheImage(AssetImage(imagePath), Get.context!);
        precachedImages.add(imagePath);
      } catch (e) {
      //  print('Failed to precache $imagePath: $e');
      }
    }
  }
}