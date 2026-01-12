import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app_boilerplate/common/widgets/loaders/shimmer_effect.dart';

import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/image_strings.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';

class SelectNetworkInput extends StatelessWidget {
  final List<DataServiceModel> services;
  final Rx<String?> selectedValue;
  final TextEditingController controller;
  final String defaultValue;
  final String? Function(String?)? validator;
  final RxString? selectedLogo;
  final RxBool? loader;
  final void Function(DataServiceModel selected)? onSelected;

  const SelectNetworkInput(
      {super.key,
      required this.services,
      required this.selectedValue,
      required this.controller,
      this.defaultValue = 'Select Network',
      this.validator,
      this.selectedLogo,
      this.loader,
      this.onSelected});

  /// Determines which logo to use based on the service name
  String _getLogoFromService(String serviceName) {
    final lower = serviceName.toLowerCase();
    if (lower.contains('mtn')) return RImages.mtnLogo;
    if (lower.contains('glo')) return RImages.gloLogo;
    if (lower.contains('airtel')) return RImages.airtelLogo;
    if (lower.contains('9mobile') || lower.contains('etisalat')) {
      return RImages.mobileLogo;
    }
    return RImages.appIcon; // fallback logo
  }

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
                    builder: (context, search, _) {
                      final filtered = services
                          .where((s) =>
                              s.name
                                  .toLowerCase()
                                  .contains(search.toLowerCase()) ||
                              s.service
                                  .toLowerCase()
                                  .contains(search.toLowerCase()))
                          .toList();

                      return ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final item = filtered[index];
                          final logoPath = _getLogoFromService(item.name);
                          final isSelected =
                              selectedValue.value == item.service;

                          return ListTile(
                            leading: ClipOval(
                              child: Image.asset(
                                logoPath,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(item.name),
                            trailing: isSelected
                                ? const Icon(Icons.check_circle,
                                    color: Colors.green)
                                : const Icon(Icons.radio_button_off),
                            onTap: () {
                              // update reactive selected value
                              selectedValue.value = item.service;

                              // update visible input field
                              controller.text = item.service;

                              // optionally update selected logo if bound
                              if (selectedLogo != null) {
                                selectedLogo!.value = logoPath;
                              }

                              // Trigger callback if provided
                              if (onSelected != null) {
                                onSelected!(item);
                              }

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
    );
  }

  @override
  Widget build(BuildContext context) {
    // Reactively update the controller text when selectedValue changes
    ever(selectedValue, (value) {
      controller.text = value ?? defaultValue;
    });
    return Obx(
      () {
        if (loader!.value) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: RSizes.sm),
            child: RShimmerEffect(width: double.maxFinite, height: 45),
          );
        }
        return TextFormField(
          readOnly: true, // Make it non-editable
          controller: controller,
          validator: validator,
          onTap: () => _showSelectionSheet(context), // Open bottom sheet on tap
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(RSizes.xs),
            filled: true,
            fillColor: Get.isDarkMode ? RColors.black : RColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(RSizes.newtworkSelectRadius),
              borderSide: const BorderSide(color: RColors.primary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(RSizes.newtworkSelectRadius),
              borderSide: const BorderSide(color: RColors.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(RSizes.newtworkSelectRadius),
              borderSide: const BorderSide(color: RColors.primary, width: 1),
            ),
            prefixIcon: Obx(() => Padding(
                  padding: const EdgeInsets.all(RSizes.sm),
                  child: ClipOval(
                    child: Image.asset(
                      selectedLogo?.value ?? RImages.appIcon,
                      width: 25,
                      height: 25,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ),
        );
      },
    );
  }
}

class DataServiceModel {
  final String name;
  final String service;
  DataServiceModel({required this.name, required this.service});
}
