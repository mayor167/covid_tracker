import '../exceptions/covid_exception.dart';

/// Maps typed [CovidException] instances to polished, end-user-facing messages.
///
/// This is the single source of truth for every error string the user will see.
/// The repository throws the right exception subtype; the controller catches it
/// and calls [toUserMessage] — no raw stack traces or technical jargon ever
/// leak into the UI.
class ErrorHandler {
  ErrorHandler._(); // prevent instantiation

  /// Returns a professional, non-technical message for the given [exception].
  ///
  /// The switch is exhaustive thanks to the sealed [CovidException] class,
  /// so the compiler will flag it if a new subtype is added but not handled.
  static String toUserMessage(CovidException exception) {
    return switch (exception) {
      NetworkUnavailableException() =>
        'No internet connection. Please check your network settings and try again.',
      NetworkTimeoutException() =>
        'The request is taking too long. Please check your connection and try again.',
      ServerException() =>
        'The server returned an error. Please try again later.',
      ServiceUnavailableException() =>
        'Our data provider is temporarily unavailable. Please try again later.',
      ParseException() =>
        'Received unexpected data from the server. Please try again.',
      DnsException() =>
        'Unable to reach the server. Please check your connection or try again later.',
      ConnectionException() =>
        'The connection was interrupted. Please try again.',
      UnknownException() =>
        'Something went wrong. Please try again.',
    };
  }
}
