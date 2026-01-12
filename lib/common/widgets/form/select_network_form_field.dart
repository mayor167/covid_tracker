import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/image_strings.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';

class SelectNetworkFormField extends StatelessWidget {
  final List<DataServiceModel> services;
  final RxString selectedNetworkId;
  final RxString selectedNetworkName;
  final RxString selectedLogo;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final String defaultValue;

  const SelectNetworkFormField({
    super.key,
    required this.services,
    required this.selectedNetworkId,
    required this.selectedNetworkName,
    required this.selectedLogo,
    this.validator,
    this.onSaved,
    this.defaultValue = 'Select Network',
  });

  String _getLogoFromService(String serviceName) {
    final lower = serviceName.toLowerCase();
    if (lower.contains('mtn')) return RImages.mtnLogo;
    if (lower.contains('glo')) return RImages.gloLogo;
    if (lower.contains('airtel')) return RImages.airtelLogo;
    if (lower.contains('9mobile') || lower.contains('etisalat')) {
      return RImages.mobileLogo;
    }
    return RImages.fallback;
  }

  void _showNetworkSheet(BuildContext context, FormFieldState<String> state) {
    ValueNotifier<String> searchTerm = ValueNotifier<String>('');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.6,
        child: Padding(
          padding: const EdgeInsets.all(RSizes.defaultSpace),
          child: Column(
            children: [
              TextField(
                onChanged: (value) => searchTerm.value = value,
                decoration: InputDecoration(
                  hintText: 'Search Network',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(RSizes.sm),
                  ),
                ),
              ),
              const SizedBox(height: RSizes.spaceBtwItems),
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
                          trailing: selectedNetworkId.value == item.service
                              ? const Icon(Icons.check_circle,
                                  color: Colors.green)
                              : null,
                          onTap: () {
                            selectedNetworkId.value = item.service;
                            selectedNetworkName.value = item.name;
                            selectedLogo.value = logoPath;

                            // Update the form field value
                            state.didChange(item.service);

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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: selectedNetworkId.value,
      validator: validator,
      onSaved: onSaved,
      builder: (state) {
        return Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => _showNetworkSheet(context, state),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(RSizes.xs),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(RSizes.newtworkSelectRadius),
                      border: Border.all(
                        color: state.hasError ? Colors.red : RColors.primary,
                      ),
                      color: Get.isDarkMode
                          ? RColors.darkContainer
                          : RColors.lightContainer,
                    ),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            selectedLogo.value,
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: RSizes.xs),
                        Flexible(
                          child: Text(
                            selectedNetworkName.value.isEmpty
                                ? defaultValue
                                : selectedNetworkName.value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down,
                            size: RSizes.iconXxm),
                      ],
                    ),
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      state.errorText ?? '',
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ));
      },
    );
  }
}

class DataServiceModel {
  final String name;
  final String service;
  DataServiceModel({required this.name, required this.service});
}
