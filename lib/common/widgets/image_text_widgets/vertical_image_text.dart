import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class RVerticalImageText extends StatelessWidget {
  const RVerticalImageText({
    super.key, required this.image, required this.title,  this.textColor = RColors.white, this.backgroundColor, this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: RSizes.spaceBtwItems),
        child: Column(
          children: [
            //circular icon
            Container(
                width: 56,
                height: 56,
                padding: const EdgeInsets.all(RSizes.sm),
                decoration: BoxDecoration(
                  color: backgroundColor ?? (RHelperFunctions.isDarkMode(context) ? RColors.black : RColors.white),
                  borderRadius:
                      BorderRadius.circular(100),
                ),
                child: Center(
                  child: Image(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                    color: RHelperFunctions.isDarkMode(context) ? RColors.light : RColors.dark,
                  ),
                )),
                const SizedBox(height: RSizes.spaceBtwItems / 2,),
                SizedBox(
                  width: 55,
                   child: Text(
                    title, 
                    style: Theme.of(context).textTheme.labelMedium!.apply(color: textColor),
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis
                   )
                   )
          ],
        ),
      ),
    );
  }
}