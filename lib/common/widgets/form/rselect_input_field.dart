import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter_app_boilerplate/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SelectInputField extends StatelessWidget {
  final Map<String, dynamic> items; // Key-Value pair for selection
  final Rx<String?> selectedValue; // To track selected value
  final IconData? icon; // Custom prefix icon
  final TextEditingController controller;

  const SelectInputField({
    super.key,
    required this.items,
    required this.selectedValue,
    this.icon = Iconsax.bank,
    required this.controller,
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
            padding:
                const EdgeInsets.symmetric(horizontal: RSizes.defaultSpace),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Search bar
                TextField(
                  onChanged: (value) {
                    searchTerm.value = value;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search items',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(RSizes.sm),
                    ),
                  ),
                ),
                const SizedBox(
                  height: RSizes.spaceBtwItems,
                ),
                // Filtered list of items
                Expanded(
                  child: ValueListenableBuilder<String>(
                    valueListenable: searchTerm,
                    builder: (context, search, child) {
                      final filteredItems = items.entries
                          .where((entry) => entry.value
                              .toLowerCase()
                              .contains(search.toLowerCase()))
                          .toList();

                      return ListView.builder(
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return Column(
                            children: [
                              ListTile(
                                title: Text(item.value),
                                trailing: selectedValue.value == item.value
                                    ? const Icon(Icons.check_circle,
                                        color: Colors.green)
                                    : const Icon(Icons.radio_button_off),
                                onTap: () {
                                  selectedValue.value = item.value;
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
    final dark = RHelperFunctions.isDarkMode(context);
    // Reactively update the controller text when selectedValue changes
    ever(selectedValue, (value) {
      controller.text = value ?? 'Select an option';
    });

    return TextFormField(
      readOnly: true, // Make it non-editable
      controller: controller,
      onTap: () => _showSelectionSheet(context), // Open bottom sheet on tap
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            vertical: RSizes.md, horizontal: RSizes.md),
        filled: true,
        fillColor: dark ? RColors.black : RColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RSizes.sm),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        prefixIcon: Icon(icon, color: Colors.grey),
        suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
      ),
    );
  }
}
