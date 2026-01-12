import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter_app_boilerplate/utils/helpers/helper_functions.dart';
import 'package:shimmer/shimmer.dart';

class SummarySheetShimmer extends StatelessWidget {
  const SummarySheetShimmer({super.key});

  Widget _buildShimmerBox(
      {double height = 16, double width = double.infinity, double radius = 8}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  Widget _buildRowShimmer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildShimmerBox(width: 100, height: 14),
        _buildShimmerBox(width: 60, height: 14),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(RSizes.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Logo
              Center(
                child: ClipOval(
                  child: _buildShimmerBox(height: 50, width: 50, radius: 25),
                ),
              ),
              const SizedBox(height: RSizes.spaceBtwItems),

              /// Rows
              _buildRowShimmer(),
              const SizedBox(height: RSizes.spaceBtwItems),
              _buildRowShimmer(),
              const SizedBox(height: RSizes.spaceBtwItems),
              _buildRowShimmer(),
              const SizedBox(height: RSizes.spaceBtwItems),
              _buildRowShimmer(),
              const SizedBox(height: RSizes.spaceBtwItems),
              _buildRowShimmer(),

              const SizedBox(height: RSizes.spaceBtwItems * 2),

              /// Auto renew card placeholder
              _buildShimmerBox(height: 20, radius: RSizes.cardRadiusMd),
              const SizedBox(height: RSizes.spaceBtwItems),

              /// Schedule picker placeholder
              _buildShimmerBox(height: 20, radius: RSizes.cardRadiusMd),

              const SizedBox(height: RSizes.spaceBtwItems * 2),

              /// Confirm button placeholder
              _buildShimmerBox(height: 48, radius: RSizes.buttonRadius),
            ],
          ),
        ),
      ),
    );
  }
}
