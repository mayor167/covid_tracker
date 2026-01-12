import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class RSocialButtons extends StatelessWidget {
  const RSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: RColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(onPressed: (){}, icon: Image(
            width: RSizes.iconLg,
            height: RSizes.iconMd,
            image: AssetImage(RImages.google))),
        ),
        const SizedBox(width: RSizes.spaceBtwItems,),
    
         Container(
          decoration: BoxDecoration(
            border: Border.all(color: RColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(onPressed: (){}, icon: Image(
            width: RSizes.iconLg,
            height: RSizes.iconMd,
            image: AssetImage(RImages.facebook))),
        )
      ],
    );
  }
}
