// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app_boilerplate/utils/constants/image_strings.dart';
import 'package:url_launcher/url_launcher.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  String toRate() => "₦$this/\$";

  String formatAmount() {
    String price = this;
    String priceInText = "";
    int counter = 0;

    double priceValue =
        double.tryParse(price) ?? 0.0; // Convert the price to a double

    int roundedPrice =
        priceValue.floor(); // Round up the price to the nearest integer

    String roundedPriceString =
        roundedPrice.toString(); // Convert the rounded price back to a string

    for (int i = (roundedPriceString.length - 1); i >= 0; i--) {
      counter++;
      String str = roundedPriceString[i];

      priceInText = ((counter % 3) != 0 || i == 0)
          ? '$str$priceInText'
          : ',$str$priceInText';
    }

    return priceInText.trim();
  }

  String formatDate() {
    String date = this;
    DateTime tempDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);

    String formattedDate =
        DateFormat('EEE dd, MMMM y; hh:mm a').format(tempDate);
    return formattedDate;
  }

  String formatShortDate() {
    String date = this;
    DateTime tempDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
    String formattedDate =
        DateFormat('EEE dd, MMM. yyyy; hh:mm a').format(tempDate);
    return formattedDate;
  }

  String formatStandardDate() {
    String date = this, formattedDate;
    DateTime tempDate = DateFormat("yyyy-MM-dd").parse(date);
    formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(tempDate);
    return formattedDate;
  }
}

Future<void> launchWebInApp(String url) async {
  if (!await canLaunchUrl(Uri.parse(url))) {
    // throw Exception('Could not launch $url');
  }
  await launchUrl(Uri.parse(url));
}

DateTime parseDate(String dateTimeString) {
  return DateTime.parse(dateTimeString);
}

TimeOfDay parseTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
}

String scheduledDateTimeFormat(String date, String time) {
  // Parse the input date and time strings
  DateTime parsedDate = DateTime.parse(date);
  TimeOfDay parsedTime = TimeOfDay(
    hour: int.parse(time.split(":")[0]),
    minute: int.parse(time.split(":")[1]),
  );

  // Combine date and time
  DateTime combinedDateTime = DateTime(
    parsedDate.year,
    parsedDate.month,
    parsedDate.day,
    parsedTime.hour,
    parsedTime.minute,
  );

  // Format the combined date and time
  String formattedDateTime =
      DateFormat('yyyy-MM-dd HH:mm:00').format(combinedDateTime);

  return formattedDateTime;
}

String extractNetworkName(String service) {
  final lower = service.toLowerCase();

  const networks = [
    'mtn',
    'glo',
    'airtel',
    '9mobile',
    'dstv',
    'gotv',
    'startimes',
    'ibedc'
  ];

  // Find the first network that appears in the service string
  for (final network in networks) {
    if (lower.contains(network)) return network;
  }

  // No match found
  return 'none';
}

String getLogoFromService(String serviceName) {
  final lower = serviceName.toLowerCase();

  // internet
  if (lower.contains('mtn')) return RImages.mtnLogo;
  if (lower.contains('glo')) return RImages.gloLogo;
  if (lower.contains('airtel')) return RImages.airtelLogo;
  if (lower.contains('9mobile') || lower.contains('etisalat')) {
    return RImages.mobileLogo;
  }
  // cable tv logos
  if (lower.contains('dstv')) return RImages.dstvLogo;
  if (lower.contains('gotv')) return RImages.gotvLogo;
  if (lower.contains('startimes')) return RImages.startimesLogo;
  if (lower.contains('showmax')) return RImages.showmaxLogo;

  // electricity logos
  if (lower.contains('aba')) return RImages.abaLogo;
  if (lower.contains('abuja')) return RImages.abujaLogo;
  if (lower.contains('accesspower')) return RImages.accessPowerLogo;
  if (lower.contains('benin')) return RImages.beninLogo;
  if (lower.contains('bh')) return RImages.bhLogo;
  if (lower.contains('eko')) return RImages.ekoLogo;
  if (lower.contains('enugu')) return RImages.enuguLogo;
  if (lower.contains('ikeja')) return RImages.ikejaLogo;
  if (lower.contains('ibadan')) return RImages.ibedcLogo;
  if (lower.contains('jos')) return RImages.josLogo;
  if (lower.contains('kaduna')) return RImages.kadunaLogo;
  if (lower.contains('kano')) return RImages.kanoLogo;
  if (lower.contains('port-harcourt')) return RImages.portHarcortLogo;
  if (lower.contains('yola')) return RImages.yolaLogo;

  // education
  if (lower.contains('waec')) return RImages.waecLogo;
  if (lower.contains('neco')) return RImages.necoLogo;
  if (lower.contains('jamb')) return RImages.jambLogo;
  if (lower.contains('nabteb')) return RImages.nabtebLogo;

  // internet services
  if (lower.contains('smile')) return RImages.smileLogo;
  if (lower.contains('spectranet')) return RImages.spectranetbLogo;

  // bank logos
  if (lower.contains('9payment')) return RImages.ninepsb;
  if (lower.contains('access')) return RImages.access;
  if (lower.contains('carbon')) return RImages.carbon;
  if (lower.contains('ecobank')) return RImages.ecobank;
  if (lower.contains('fcmb')) return RImages.fcmb;
  if (lower.contains('fidelity')) return RImages.fidelity;
  if (lower.contains('first bank')) return RImages.firstbank;
  if (lower.contains('guaranty')) return RImages.gtbank;
  if (lower.contains('jaiz')) return RImages.jaizbank;
  if (lower.contains('keystone')) return RImages.keystone;
  if (lower.contains('kuda')) return RImages.kuda;
  if (lower.contains('moniepoint')) return RImages.moniepoint;
  if (lower.contains('paycom')) return RImages.opay;
  if (lower.contains('paga')) return RImages.paga;
  if (lower.contains('palmpay')) return RImages.palmpay;
  if (lower.contains('parallex')) return RImages.parallax;
  if (lower.contains('polaris')) return RImages.polaris;
  if (lower.contains('providus')) return RImages.providus;
  if (lower.contains('stanbic')) return RImages.stanbic;
  if (lower.contains('standard chartered')) return RImages.standardChartered;
  if (lower.contains('sterling')) return RImages.sterling;
  if (lower.contains('taj')) return RImages.tajbank;
  if (lower.contains('uba') || lower.contains('united')) return RImages.uba;
  if (lower.contains('union')) return RImages.union;
  if (lower.contains('unity')) return RImages.unity;
  if (lower.contains('vfd')) return RImages.vfd;
  if (lower.contains('wema')) return RImages.wema;
  if (lower.contains('zenith')) return RImages.zenith;

  return RImages.appIcon; // fallback logo
}

Map<String, String> autoRenewal = {
  'oneOff': 'One Off',
  'Daily': 'Daily',
  'Weekly': 'Weekly',
  '2_weeks': 'Every 2 Weeks',
  'Monthly': 'Monthly',
};

String getFullServiceName(String serviceName) {
  final lower = serviceName.toLowerCase();

  if (lower.contains('mtn') && lower.contains('vtu')) return 'Mtn Vtu';
  if (lower.contains('mtn') && lower.contains('sme')) return 'Mtn Sme';
  if (lower.contains('mtn') && lower.contains('gifting')) return 'Mtn Gifting';

  if (lower.contains('glo') && lower.contains('vtu')) return 'Glo Vtu';
  if (lower.contains('glo') && lower.contains('sme')) return 'Glo Sme Data';
  if (lower.contains('glo') && lower.contains('gifting')) return 'Glo Gifting';

  if (lower.contains('airtel') && lower.contains('vtu')) return 'Airtel Vtu';
  if (lower.contains('airtel') && lower.contains('gifting')) {
    return 'Airtel Gifting';
  }

  if ((lower.contains('9mobile') || lower.contains('etisalat')) &&
      lower.contains('vtu')) {
    return '9mobile Vtu';
  }
  if ((lower.contains('9mobile') || lower.contains('etisalat')) &&
      lower.contains('sme')) {
    return '9mobile Sme Data';
  }
  if ((lower.contains('9mobile') || lower.contains('etisalat')) &&
      lower.contains('gifting')) {
    return '9mobile Gifting';
  }

  if (lower.contains('dstv')) return 'DSTV Subscription';
  if (lower.contains('gotv')) return 'GOTV Subscription';
  if (lower.contains('startimes')) return 'Startimes Subscription';

  if (lower.contains('withdrawal')) return 'Withdrawal Details';

  return 'Unknown Service'; // fallback
}

String formatAmountInNaira(int amount) {
  // 1. Get the absolute value and convert to string
  String integerPart = amount.abs().toString();
  String formattedIntegerPart = '';
  int counter = 0;

  // 2. Loop backwards to insert commas every 3 digits (thousands separator)
  for (int i = integerPart.length - 1; i >= 0; i--) {
    // Prepend the current digit
    formattedIntegerPart = integerPart[i] + formattedIntegerPart;
    counter++;

    // Insert comma if 3 digits have passed and it's not the first digit
    if (counter % 3 == 0 && i != 0) {
      formattedIntegerPart = ',$formattedIntegerPart';
    }
  }

  // 3. Determine the sign
  final String sign = amount < 0 ? '-' : '';

  // 4. Combine with Naira sign and two decimal places
  return '₦$sign$formattedIntegerPart.00';
}
