import 'package:dash_flags/dash_flags.dart';

/// Converts a three-letter country code (ISO 3166-1 alpha-3) to `Country` enum
Country mapCountryCode(String code) {
  switch (code.toUpperCase()) {
    case "USD":
      return Country.us;
    case "USA":
      return Country.us;
    case "CAD":
      return Country.ca;
    case "GBR":
      return Country.gb;
    case "AUD":
      return Country.au;
    case "NGN":
      return Country.ng;
    case "FRA":
      return Country.fr;
    case "NGA":
      return Country.ng;
    default:
      return Country.us; // Default to US if not found
  }
}
