

import 'package:intl/intl.dart';

class RFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {

    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

static String formatPhoneNumber(String phoneNumber) {
  if(phoneNumber.length == 10){
   return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
  }else if(phoneNumber.length == 11){
   return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
  }
  return phoneNumber;
}

static String internationalFormatPhoneNumber(String phoneNumber) {
 //remove non digit characters
  var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

  //extract country code from digits only
  String countryCode = '+${digitsOnly.substring(0, 2)}';
  digitsOnly = digitsOnly.substring(2);

  //add the remaining digits with proper formatting
  final formattedNumber = StringBuffer();
  formattedNumber.write('($countryCode) ');

  int i = 0;
  while (i < digitsOnly.length) {
    int groupLength = 2;
    if(i == 0 && countryCode == '+1') {
      groupLength = 3;
    }

    int end = i + groupLength;
    formattedNumber.write(digitsOnly.substring(i, end));

    if(end < digitsOnly.length){
      formattedNumber.write(' ');
    }

    i = end;

   

  }


 return formattedNumber.toString();

}

  static String formatPhoneNumberDisplay(dynamic phoneNumber) {
    // 1. Sanitize input to a clean string of digits
    String fullNumber = phoneNumber.toString().replaceAll(
          RegExp(r'[^0-9]'),
          '',
        );

    if (fullNumber.isEmpty) {
      return '';
    }

    // 2. Normalize to local format (starting with 0)
    String localNumber;

    if (fullNumber.startsWith('234') && fullNumber.length > 3) {
      // Case 1: Remove '234' and prepend '0'
      localNumber = '0${fullNumber.substring(3)}';
    } else if (fullNumber.startsWith('0')) {
      // Case 2: Already in local format (starts with '0')
      localNumber = fullNumber;
    } else {
      // Case 3: Assume it's a 10-digit number without a country code or leading 0
      // and try to prepend '0' if it looks like a Nigerian mobile number.
      if (fullNumber.length == 10) {
        localNumber = '0$fullNumber';
      } else {
        // If the format is unexpected, return the sanitized number unformatted.
        return fullNumber;
      }
    }

    // 3. Return the full, formatted local number (unmasked).
    return localNumber;
  }

  static String formatPhoneNumberForUpdate(dynamic phoneNumber) {
    // 1. Sanitize input to a clean string of digits
    String fullNumber = phoneNumber.toString().replaceAll(
          RegExp(r'[^0-9]'),
          '',
        );

    if (fullNumber.isEmpty) {
      return '';
    }

    // 2. Normalize to international format (starting with 234)
    if (fullNumber.startsWith('234')) {
      // Case 1: Already in the required format
      return fullNumber;
    } else if (fullNumber.startsWith('0') && fullNumber.length >= 11) {
      // Case 2: Starts with '0' (e.g., 081...) -> remove '0' and prepend '234'
      return '234${fullNumber.substring(1)}';
    } else if (fullNumber.length == 10) {
      // Case 3: Missing both '234' and '0' (e.g., 81...) -> prepend '234'
      return '234$fullNumber';
    }

    // If the format is unexpected, return the sanitized number as is.
    return fullNumber;
  }










}