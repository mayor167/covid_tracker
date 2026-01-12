import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class RStatusColorHelper {
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return RColors.warning;
      case 'processing':
        return RColors.warning;
      case 'approved':
        return RColors.success;
      case 'success':
        return RColors.success;
      case 'confirmed':
        return RColors.success;
      case 'in':
        return RColors.success;
      default:
        return RColors.error;
    }
  }
}
