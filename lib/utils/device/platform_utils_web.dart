import 'package:flutter/foundation.dart';
// ignore: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:js' as js;

class RPlatformUtils {
  static bool get isWeb {
    try {
      // Try compile-time detection first
      if (kIsWeb) return true;
    } catch (e) {
      // Fall through to runtime detection
    }

    // Runtime detection fallbacks
    try {
      // JavaScript environment check
      final context = js.context;
      // ignore: unnecessary_null_comparison
      if (context != null && context.hasProperty('window')) {
        return true;
      }
    } catch (e) {
      // Not in JavaScript context
    }

    // Dart number semantics check (web has different number behavior)
    return identical(0, 0.0);
  }

  static bool get isIOSWeb {
    if (!isWeb) return false;

    try {
      final userAgent = js.context['navigator']['userAgent'] as String?;
      return userAgent?.contains('iPhone') == true ||
          userAgent?.contains('iPad') == true ||
          userAgent?.contains('iPod') == true;
    } catch (e) {
      return false;
    }
  }
}

// // Usage
// if (PlatformUtils.isWeb) {
//   // Web-specific code
// }

// if (PlatformUtils.isIOSWeb) {
//   // iOS browser specific code
// }
