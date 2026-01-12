import 'package:flutter_app_boilerplate/common/widgets/layouts/grid_layout.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class RListGridLayout extends StatelessWidget {
  const RListGridLayout({
    super.key,
    required this.listWidgets,
    this.perRole = 2,
    this.mainAxisExtent = 220,
    this.padding,
    this.spacing = RSizes.lg,
  });

  ///arrange your widget in a  List<widget> and parse it

  final List<Widget> listWidgets;
  final int perRole;
  final double mainAxisExtent;
  final EdgeInsets? padding;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: RSizes.md),
      child: RGridLayout(
        mainAxisExtent: mainAxisExtent,
        perRow: perRole,
        spacing: spacing,
        itemCount: listWidgets.length,
        itemBuilder: (_, index) {
          return listWidgets[index];
        },
      ),
    );
  }
}
