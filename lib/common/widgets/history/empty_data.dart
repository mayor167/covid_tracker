import 'package:flutter_app_boilerplate/common/widgets/button/elevated_button.dart';
import 'package:flutter_app_boilerplate/common/widgets/images/rounded_image.dart';
import 'package:flutter_app_boilerplate/navigation_menu.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/image_strings.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter_app_boilerplate/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class REmptyTransactionState extends StatelessWidget {
  const REmptyTransactionState({
    super.key,
    this.image,
    this.text = '',
    this.showButton = false,
    this.onPressed,
    this.isNetwork = false,
    this.titleText = '',
  });

  final String? image;
  final String text, titleText;
  final bool showButton, isNetwork;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RRoundedImage(
            height: RHelperFunctions.screenHeight() * 0.25,
            width: RHelperFunctions.screenWidth() * 0.8,
            imageUrl: image ?? RImages.emptyTransactionHistory,
          ),
          const SizedBox(height: RSizes.spaceBtwSections),

          // Title text
          Text(
              titleText.isEmpty
                  ? isNetwork
                      ? 'Network Error'
                      : 'History is Empty'
                  : titleText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: RSizes.md),

          /// Text info
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: RSizes.lg),
              child: Text(
                  text.isEmpty
                      ? isNetwork
                          ? 'Oops! Internet connection failed'
                          : 'You should try out our fast platform, \nyou\'d love it'
                      : text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium)),
          const SizedBox(height: RSizes.spaceBtwItems),
          if (showButton)
            RElevatedButton(
                backgroundColor: RColors.primary,
                text: isNetwork ? 'Retry' : 'Explore',
                textColor: RColors.white,
                useBorder: false,
                onPressed: onPressed ??
                    () => NavigationController.instance.moveToPage(2))
        ],
      ),
    );
  }
}
