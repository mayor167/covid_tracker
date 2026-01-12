
import 'package:universal_html/html.dart' as html;

class PWAUtils {
  static bool get isRunningInBrowser {
    try {
      // ignore: unnecessary_null_comparison
      return html.window != null;
    } catch (e) {
      return false;
    }
  }

  static bool get isIOS {
    try {
      final userAgent = html.window.navigator.userAgent.toLowerCase();
      return userAgent.contains('iphone') || userAgent.contains('ipad');
    } catch (e) {
      return false;
    }
  }

  static bool get isAndroid {
    try {
      final userAgent = html.window.navigator.userAgent.toLowerCase();
      return userAgent.contains('android');
    } catch (e) {
      return false;
    }
  }

  static bool get isStandaloneMode {
    try {
      // Check for display-mode: standalone (works on most browsers)
      final isStandalone = html.window.matchMedia('(display-mode: standalone)').matches;
      
      // For iOS, we can also check various indicators
      if (isIOS) {
        // iOS specific checks
        final isInStandaloneMode = _checkIOSStandalone();
        return isStandalone || isInStandaloneMode;
      }
      
      return isStandalone;
    } catch (e) {
      return false;
    }
  }

  static bool _checkIOSStandalone() {
    try {
      // iOS specific checks for standalone mode
      //final navigator = html.window.navigator;
      
      // Check if running in standalone mode (iOS)
      // These are common indicators for iOS standalone mode
     // const isIOSSafari = true; // Assume Safari if we're on iOS
      
      // Check screen dimensions (standalone mode often has different dimensions)
      final screenWidth = html.window.screen?.width;
      final windowWidth = html.window.innerWidth;
      
      // In standalone mode, window width is typically slightly less than screen width
      // due to status bar and other UI elements
      final widthDifference = (screenWidth! - windowWidth!).abs();
      const typicalWidthDifference = 20.0; // Approximate difference in standalone mode
      
      // Check if the app seems to be in standalone mode based on width difference
      final hasStandaloneWidth = widthDifference > 0 && widthDifference < typicalWidthDifference;
      
      // Additional iOS-specific checks
      final hasStandaloneUI = !html.window.navigator.userAgent.contains('Safari') && 
                             html.window.navigator.userAgent.contains('Mobile');
      
      return hasStandaloneWidth || hasStandaloneUI;
    } catch (e) {
      return false;
    }
  }

  static bool get canBeInstalled {
    return isRunningInBrowser && !isStandaloneMode;
  }

  // Additional method to check if app might be in standalone mode
  static Future<bool> checkInstallStatus() async {
    return !canBeInstalled;
  }
}