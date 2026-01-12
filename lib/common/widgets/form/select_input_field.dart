import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/image_strings.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter_app_boilerplate/utils/helpers/functions.dart';
import 'package:flutter_app_boilerplate/utils/helpers/helper_functions.dart';

class RSelectInputField<T> extends StatelessWidget {
  final List<T> items; // Accepts any model type
  final Rx<T?> selectedValue; // Track selected item
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? defaultValue;
  final Function(T)? onChanged;
  final bool search;
  final bool useGreyColor;
  final bool useLogo;
  final bool useSubtitle;
  final IconData? icon;

  /// Function to display the label of each item
  final String Function(T) displayBuilder;
  final String Function(T)? subtitleBuilder;

  /// (Optional) Function to display the leading widget (logo, avatar, etc.)
  final Widget Function(T)? leadingBuilder;
  final int Function(T a, T b)? sortComparator;

  const RSelectInputField({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.controller,
    required this.displayBuilder,
    this.subtitleBuilder,
    this.leadingBuilder,
    this.validator,
    this.defaultValue,
    this.onChanged,
    this.search = true,
    this.useGreyColor = false,
    this.useLogo = true,
    this.useSubtitle = false,
    this.icon = Iconsax.bank,
    this.sortComparator,
  });

  void _showSelectionSheet(BuildContext context) async {
    ValueNotifier<String> searchTerm = ValueNotifier<String>('');
    final isDarkMode = RHelperFunctions.isDarkMode(context);

    await showModalBottomSheet(
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
                if (search) ...[
                  TextField(
                    onChanged: (value) => searchTerm.value = value,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search items',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
                Expanded(
                  child: ValueListenableBuilder<String>(
                    valueListenable: searchTerm,
                    builder: (context, search, child) {
                      final filteredItems = items.where((item) {
                        final text = displayBuilder(item).toLowerCase();
                        return text.contains(search.toLowerCase());
                      }).toList();

                      if (filteredItems.isEmpty) {
                        return const Center(child: Text("No results found"));
                      }

                      // 👇 Apply sorting if comparator is provided
                      // 👇 Apply sorting if comparator is provided
                      if (sortComparator != null) {
                        filteredItems.sort(sortComparator);
                      } else {
                        filteredItems.sort(
                          (a, b) => displayBuilder(a).toLowerCase().compareTo(
                                displayBuilder(b).toLowerCase(),
                              ),
                        );
                      }

                      return ListView.separated(
                        itemCount: filteredItems.length,
                        separatorBuilder: (_, __) =>
                            const Divider(thickness: 0.4),
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          final isSelected = selectedValue.value == item;

                          // 🔎 Detect if unavailable
                          bool isUnavailable = false;
                          try {
                            final statusValue = (item as dynamic)
                                .status
                                ?.toString()
                                .trim()
                                .toLowerCase();
                            if (statusValue == 'unavailable') {
                              isUnavailable = true;
                            }
                          } catch (_) {}

                          return ListTile(
                            enabled: !isUnavailable,
                            leading: leadingBuilder != null
                                ? leadingBuilder!(item)
                                : useLogo
                                    ? ClipOval(
                                        child: Image.asset(
                                          getLogoFromService(
                                            displayBuilder(item),
                                          ),
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : null,
                            title: Text(
                              displayBuilder(item),
                              style: TextStyle(
                                color: isUnavailable
                                    ? Colors.grey
                                    : (isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                            subtitle: useSubtitle
                                ? Text(
                                    subtitleBuilder!(item),
                                    style: TextStyle(
                                      color: isUnavailable
                                          ? Colors.grey
                                          : (isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  )
                                : null,
                            trailing: isSelected
                                ? const Icon(
                                    Icons.check_circle,
                                    color: RColors.successStatus,
                                  )
                                : isUnavailable
                                    ? const Icon(Icons.block,
                                        color: RColors.grey)
                                    : const Icon(Icons.radio_button_off),
                            onTap: isUnavailable
                                ? null
                                : () {
                                    selectedValue.value = item;
                                    onChanged?.call(item);
                                    Navigator.pop(context);
                                  },
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
    ).whenComplete(() {
      // When the sheet closes — clear focus safely here instead
      Future.delayed(const Duration(milliseconds: 50), () {
        FocusManager.instance.primaryFocus?.unfocus();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = RHelperFunctions.isDarkMode(context);

    // Sync controller text with selected value
    ever(selectedValue, (value) {
      controller.text =
          value != null ? displayBuilder(value as T) : (defaultValue ?? "");
    });

    // ✅ Auto-select single item logic
    if (items.length == 1) {
      final item = items.first;
      if (selectedValue.value != item) {
        selectedValue.value = item;
        onChanged?.call(item);
      }
    }

    final bool isSingleAndSelected =
        items.length == 1 && selectedValue.value == items.first;

    return TextFormField(
      controller: controller,
      enabled: !isSingleAndSelected && items.isNotEmpty,
      readOnly: true,
      validator: (value) {
        if (validator != null) {
          return validator!(
              value); // works for both normal and RValidator.modelValidator
        }
        return null;
      },
      onTap: () {
        if (items.isNotEmpty) {
          _showSelectionSheet(context);
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(RSizes.xs),
        filled: true,
        fillColor: isDarkMode ? RColors.black : RColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RSizes.sm),
          borderSide: BorderSide(
            color: useGreyColor ? RColors.grey : RColors.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RSizes.newtworkSelectRadius),
          borderSide: BorderSide(
            color: useGreyColor ? RColors.grey : RColors.primary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RSizes.newtworkSelectRadius),
          borderSide: BorderSide(
            color: useGreyColor ? RColors.grey : RColors.primary,
            width: 1,
          ),
        ),
        prefixIcon: useLogo
            ? Obx(() {
                final value = selectedValue.value;
                return Padding(
                  padding: const EdgeInsets.all(RSizes.sm),
                  child: ClipOval(
                    child: Image.asset(
                      value != null
                          ? getLogoFromService(displayBuilder(value))
                          : RImages.appIcon, // fallback logo
                      width: 33,
                      height: 33,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              })
            : Padding(
                padding: const EdgeInsets.all(RSizes.sm),
                child: Icon(
                  icon ?? Iconsax.element_3,
                  size: RSizes.iconMd,
                  color: RColors.primary,
                ),
              ),
        suffixIcon: isSingleAndSelected
            ? null
            : const Icon(Icons.arrow_drop_down, color: Colors.grey),
      ),
    );
  }
}
