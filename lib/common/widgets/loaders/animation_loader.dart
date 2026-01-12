import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter_app_boilerplate/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

///A widget for displaying an animated loading indicator with optional text and action button
class RAnimationLoaderWidget extends StatelessWidget {
  ///Parameters
  /// - text: The text to be displayed below animation
  /// - animation: The path to the lottie animation file
  /// - showAction: whether to show an action button below the text
  /// - actionText: The text to be displayed on the action button
  /// - onActionPressed: Callback function to be executed when the action button is pressed

  const RAnimationLoaderWidget(
      {super.key,
      required this.text,
      required this.animation,
      this.actionText,
      this.showAction = false,
      this.onActionPressed});

  final String text, animation;
  final String? actionText;
  final bool showAction;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    final screenHeight = RHelperFunctions.screenHeight();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie.asset(animation,
          //     width: MediaQuery.of(context).size.width * 0.8),
          SizedBox(
            height:
                (screenHeight / 2) - MediaQuery.of(context).size.width * 0.23,
          ),
          Image.asset(
           'assets/images/loaders/mytrader_loader.gif',
            width: MediaQuery.of(context).size.width * 0.23,
          ),
          const SizedBox(
            height: RSizes.defaultSpace,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: RSizes.defaultSpace,
          ),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    style: OutlinedButton.styleFrom(
                        backgroundColor: RColors.black),
                    child: Text(
                      actionText!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: RColors.light),
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
