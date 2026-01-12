class RValidator {
  static String? validateEmptyText(String fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }

  static String? validatePassword(String? value, {String? oldPassword}) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    // Check if new password matches old password
    if (oldPassword != null && value == oldPassword) {
      return 'Old password and new password cannot be the same.';
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    return null; // No error
  }

  static String? validateTransPin(String? value, {String? newPin}) {
    if (value == null || value.isEmpty) {
      return 'Pin is required.';
    }

    // Check if new password matches old password
    if (newPin != null && value != newPin) {
      return 'Your Pin and Confirm Pin input must be the same.';
    }

    // Check for minimum password length
    if (value.length < 4) {
      return 'Your Transaction Pin must be numbers.';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Your Pin must contain only numbers.';
    }

    return null; // No error
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    // final phoneRegExp = RegExp(r'^\d{11}$');
    final phoneRegExp = RegExp(r'^(080|081|090|070|091)\d{8}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (11 digits required).';
    }

    return null;
  }

  static String? validateCardAmount(String? value, int? minAmount,
      int? maxAmount, bool? error, String? message) {
    // Check if the value is empty

    if (value == null || value.isEmpty) {
      return 'Amount is required.';
    }
    // Allow decimals (if needed) by updating the regex
    bool isValidNumber = RegExp(r'^-?\d+(\.\d+)?$')
        .hasMatch(value); // Matches integers and decimals
    if (!isValidNumber) {
      return 'Invalid amount';
    }

    if (error == true) {
      return message; // Return the custom error message if error flag is true
    }

    // Parse the amount to double
    double amount = double.tryParse(value) ?? 0.0;

    // If only minAmount or maxAmount is provided, treat it as both
    minAmount ??= maxAmount; // If minAmount is null, use maxAmount as minAmount
    maxAmount ??= minAmount; // If maxAmount is null, use minAmount as maxAmount

    // If minAmount and maxAmount are the same, ensure the amount is equal to that value
    if (minAmount == maxAmount) {
      if (amount != minAmount) {
        return 'Amount must be exactly $minAmount.';
      }
    } else {
      // Check minimum amount
      if (minAmount != null && amount < minAmount) {
        return 'Min. amount: $minAmount.';
      }

      // Check maximum amount
      if (maxAmount != null && amount > maxAmount) {
        return 'Max. amount: $maxAmount.';
      }
    }

    // If all checks pass, return null (no error)
    return null;
  }

  static String? validateNigPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone Number is required.';
    }
    

    // Nigerian phone number pattern: 080, 081, 090, 070, 091 + 8 digits
    final phoneRegExp = RegExp(r'^(080|081|090|070|091)\d{8}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid Phone Number';
    }

    return null;
  }

  static String? validateAmount(String? value, {int minAmount = 100}) {
    if (value == null || value.isEmpty) {
      return 'Amount is required.';
    }

    // Regular expression for positive integers (no sign, no decimals)
    final amountRegExp = RegExp(r'^\d+$');

    if (!amountRegExp.hasMatch(value)) {
      return 'Invalid amount format. Only whole numbers are allowed.';
    }

    final amount = int.tryParse(value);

    // The regex check should cover this, but a safety check for null is good.
    if (amount == null) {
      return 'Invalid amount format.';
    }

    // Check minimum amount
    if (amount < minAmount) {
      return 'Minimum amount allowed is ₦$minAmount.';
    }

    return null;
  }

  // static String? validateAmount(String? value, double walletBalance) {
  //     if (value == null || value.isEmpty) {
  //       return 'Amount is required.';
  //     }

  //     // Remove commas if present and validate the number
  //     value = value.replaceAll(',', '');

  //     bool isValidNumber = RegExp(r'^-?\d+(\.\d+)?$')
  //         .hasMatch(value); // Matches integers & decimals

  //     if (!isValidNumber) {
  //       return 'Invalid amount format.';
  //     }

  //     double amount = double.parse(value);

  //     if (amount <= 0) {
  //       return 'Amount must be greater than zero.';
  //     }

  //     // Check if wallet balance is sufficient
  //     if (amount > walletBalance) {
  //       return 'Amount is greater than your wallet balance!';
  //     }

  //     return null;
  // }

  static String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Value is required.';
    }

    bool isValidNumber = RegExp(r'^-?\d+$').hasMatch(value); // Matches integers

    if (!isValidNumber) {
      return 'Invalid  number.';
    }

    return null;
  }

  static String? validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Value is required.';
    }
    return null;
  }

  static String? validateWhatsappNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{8,13}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid whatsapp number format. Must be between 8 and 13 digits.';
    }

    return null;
  }

  static String? confirmPasswordValidator(String? value, String newPassword) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != newPassword) {
      return 'Passwords do not match';
    }
    return null; // No error
  }

  static String? validateAccountNumber(String? value) {
    // Check if the value is null or empty
    if (value == null || value.isEmpty) {
      return 'Account number must not be empty';
    }

    // Check if the value contains only numbers
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Account number must contain only numbers';
    }

    // Check if the length of the value is exactly 10
    if (value.length != 10) {
      return 'Account number must be exactly 10 digits long';
    }

    // If all validations pass, return null (no error)
    return null;
  }

  static String? validateSelectInputField(String? value, String defaultValue) {
    if (value == null || value == defaultValue) {
      return 'Please select a valid option.';
    }
    return null; // Input is valid
  }

  static String? Function(String?) modelValidator<T>(
    List<T> items,
    String Function(T) getComparableField, {
    String errorMessage = 'Please select a valid option',
  }) {
    return (String? value) {
      final exists = items.any((item) => getComparableField(item) == value);
      if (value == null || value.isEmpty || !exists) {
        return errorMessage;
      }
      return null;
    };
  }

// Add more custom validators as needed for your specific requirements.
}
