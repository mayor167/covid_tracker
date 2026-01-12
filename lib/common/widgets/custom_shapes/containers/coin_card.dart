import 'package:flutter_app_boilerplate/common/widgets/icons/circular_icon.dart';
import 'package:flutter_app_boilerplate/common/widgets/images/circular_image.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/image_strings.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_app_boilerplate/utils/helpers/functions.dart';

class CoinCard extends StatelessWidget {
  final String coinName;
  final double width;
  final double height;
  final double size;

  const CoinCard(
      {super.key,
      required this.coinName,
      this.width = 45,
      this.height = 45,
      this.size = 25});

  // Define a method to get icon based on coin name or service name
  getCoin() {
    switch (coinName.toLowerCase()) {
      case 'eth':
        return [Icons.currency_bitcoin, Colors.blueAccent]; // Placeholder
      case 'btc':
        return [Icons.currency_bitcoin, Colors.orange];
      case 'usdt':
        return [Icons.attach_money, Colors.green];
      case 'sol':
        return [Icons.sunny, Colors.purple];

      case 'bnb':
        return [Icons.currency_bitcoin, Colors.yellowAccent]; // Placeholder
      case 'ngn':
        return [Iconsax.flag5, const Color.fromARGB(255, 1, 74, 1)];
      case 'bank':
        return [Iconsax.bank, const Color.fromARGB(255, 1, 74, 1)];
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final logoFromService = getLogoFromService(coinName);

    final isDefaultCoin = getCoin() == null || coinName.toLowerCase() == 'ngn';

    // Determine if we should use service logo (e.g., MTN, Glo, etc.)
    final isKnownServiceLogo = logoFromService != RImages.appIcon;

    if (isKnownServiceLogo) {
      return ClipOval(
          child: Image.asset(
        isKnownServiceLogo
            ? logoFromService
            : coinName.toLowerCase() == 'ngn'
                ? RImages.nairaLogo
                : RImages.appIcon,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ));
    } else if (isDefaultCoin) {
      return RCircularImage(
        image: isKnownServiceLogo
            ? logoFromService
            : coinName.toLowerCase() == 'ngn'
                ? RImages.nairaLogo
                : RImages.appIcon,
        width: width,
        height: height,
        backgroundColor: coinName.toLowerCase() == 'ngn'
            ? const Color.fromARGB(255, 1, 74, 1)
            : null,
        padding: RSizes.sm * 1.5,
        fit: BoxFit.fill,
      );
    }
    return RCircularIcon(
      width: width,
      height: height,
      size: size,
      color: RColors.white,
      icon: getCoin()[0],
      backgroundColor: getCoin()[1],
    );
  }
}
