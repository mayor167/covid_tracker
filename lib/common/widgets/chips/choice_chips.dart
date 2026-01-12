import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/circular_container.dart';

class RChoiceChip extends StatelessWidget {
  const RChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
    this.width = 50,
    this.height = 50,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    final isColor = RHelperFunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? RColors.white : null),
        avatar: isColor
            ? RCircularContainer(
                width: width,
                height: height,
                backgroundColor: RHelperFunctions.getColor(text)!)
            : null,
        labelPadding: isColor ? const EdgeInsets.all(0) : null,
        shape: isColor ? const CircleBorder() : null,
        padding: isColor ? const EdgeInsets.all(0) : null,
        selectedColor: isColor ? RHelperFunctions.getColor(text)! : null,
        backgroundColor: isColor ? RHelperFunctions.getColor(text)! : null,
      ),
    );
  }
}
