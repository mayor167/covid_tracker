import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter_app_boilerplate/utils/helpers/functions.dart';
import 'package:flutter_app_boilerplate/utils/helpers/helper_functions.dart';

class RCardSelectInputField extends StatelessWidget {
  final Map<String?, dynamic> items; // Key-Value pair for selection
  final Rx<String?> selectedValue; // To track selected value
  final IconData? icon; // Custom prefix icon
  final TextEditingController controller;
  final String? defaultValue; // Add default value
  final String? Function(String?)? validator;
  final Function(String)? onChanged; // Add the onChanged callback
  final bool? search;
  final bool? useGreyColor;
  final bool? useLogo;

  const RCardSelectInputField({
    super.key,
    required this.items,
    required this.selectedValue,
    this.icon = Iconsax.bank,
    required this.controller,
    required this.defaultValue,
    this.validator,
    this.onChanged, // Include onChanged in constructor
    this.search = true,
    this.useGreyColor = false,
    this.useLogo = true,
  });

  void _showSelectionSheet(BuildContext context) {
    ValueNotifier<String> searchTerm = ValueNotifier<String>('');

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return FractionallySizedBox(
          heightFactor: 0.6,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //only show search when search is set to true
                search == true
                    ? Column(
                        children: [
                          TextField(
                            onChanged: (value) {
                              searchTerm.value = value;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'Search items',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Adjust border radius
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16.0, // Adjust space
                          ),
                          // Filtered list of items
                        ],
                      )
                    : Container(), // Show nothing if `search` is false
                Expanded(
                  child: ValueListenableBuilder<String>(
                    valueListenable: searchTerm,
                    builder: (context, search, child) {
                      final filteredItems = items.entries
                          .where((entry) => entry.key!
                              .toLowerCase()
                              .contains(search.toLowerCase()))
                          .toList();

                      return ListView.builder(
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          // Define the condition for the unclickable item
                          final isUnavailable = item.value
                              .trim()
                              .toLowerCase()
                              .contains('no specific package for this service');

                          return Column(
                            children: [
                              ListTile(
                                leading: useLogo == true
                                    ? ClipOval(
                                        child: Image.asset(
                                          getLogoFromService(item.value),
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : null,
                                title: Text(
                                  item.value,
                                  style: TextStyle(
                                    color: isUnavailable ? Colors.grey : null,
                                    fontStyle: isUnavailable
                                        ? FontStyle.italic
                                        : FontStyle.normal,
                                  ),
                                ),
                                trailing: selectedValue.value == item.value
                                    ? const Icon(Icons.check_circle,
                                        color: RColors.success)
                                    : const Icon(Icons.radio_button_off),
                                onTap: isUnavailable
                                    ? null // Set onTap to null to make the ListTile unclickable
                                    : () {
                                        selectedValue.value = item.value;
                                        onChanged?.call(item.key!);
                                        Navigator.pop(
                                            context); // Close the bottom sheet
                                      },
                              ),
                              const Divider(thickness: 0.4),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = RHelperFunctions.isDarkMode(context);

    // Reactively update the controller text when selectedValue changes
    ever(selectedValue, (value) {
      controller.text = (value ?? defaultValue)!;
    });

    return TextFormField(
      readOnly: true, // Make it non-editable
      controller: controller,
      validator: validator,
      onTap: () => _showSelectionSheet(context), // Open bottom sheet on tap
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(RSizes.xs),
        filled: true,
        fillColor: isDarkMode
            ? RColors.black
            : RColors.white, // Change color based on theme
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RSizes.sm),
          borderSide: (useGreyColor == true)
              ? const BorderSide(color: RColors.grey)
              : const BorderSide(color: RColors.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RSizes.newtworkSelectRadius),
          borderSide: (useGreyColor == true)
              ? const BorderSide(color: RColors.grey)
              : const BorderSide(color: RColors.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RSizes.newtworkSelectRadius),
          borderSide: (useGreyColor == true)
              ? const BorderSide(color: RColors.grey, width: 1)
              : const BorderSide(color: RColors.primary, width: 1),
        ),
        prefixIcon: Icon(
          icon,
          color: (useGreyColor == true) ? RColors.grey : RColors.primary,
          size: RSizes.iconMd,
        ),
        suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
      ),
    );
  }
}
