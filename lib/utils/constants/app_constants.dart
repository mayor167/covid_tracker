class RAppConstants {
  static const String version = "1.0.0";
  //API
  static const String backendUrl = "https://example.com";
  static const String secretKey =
      "ntml_live_b2da6ds3ddadaf3e785v8ddc59qweq198f7615ba";

  //public urls
  static const String publicPostUrl = "app/post";
  static const String publicGetUrl = "app/get";

  // user
  static const String loginUrl = "app/auth/login";
  static const String confirmTransactionPin =
      "app/account/confirm_transaction_pin";
  static const String signUpUrl = "app/auth/register";
  static const String forgotPasswordUrl = "app/auth/forgot_password";
  static const String generateCodeUrl = "app/auth/verify_account/generate_code";
  static const String getNumberToFlashUrl =
      "app/auth/verify_account/get_number_to_flash";
  static const String verifyFlashUrl = "app/auth/verify_account/verify_flash";
  static const String verifyCodeUrl = "app/auth/verify_account/verify_code";

  //coin
    static const String generateCoinAddressUrl = "app/coin/generate_address";

  //storage
  //Biometrics
  static const String isFaceIDSupported = "IS_FACEID_SUPPORTED";
  static const String isFingerprintSupported = "IS_FINGERPRINT_SUPPORTED";
  static const String isBiometricsSupported = "IS_BIOMETRICS_SUPPORTED";
  static const String isBiometricsEnabled = "IS_BIOMETRICS_ENABLED";

  //local storage
  static const String isLoggedIn = "IS_LOGGED_IN";
  static const String isFirstLogin = "isFirstLogin";
  static const String transactionPin = "TRANSACTION_PIN";
  static const String rememberMeEmail = "REMEMBER_ME_EMAIL";
  static const String rememberMePassword = "REMEMBER_ME_PASSWORD";
  static const String rememberMeValue = "REMEMBER_ME_VALUE";
  static const String userProfile = "USER_PROFILE";
  static const String showBalance = "SHOW_BALANCE";
  static const String themeMode = "THEME_MODE";
  static const String lastRoute = "LAST_ROUTE";

  // notifications
  static const String notificationUrl = "app/notifications/";
  static const String updateNotificationUrl = "app/notifications/update_read";
  static const String deleteNotificationUrl = "app/notifications/delete";




}
