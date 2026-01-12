import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';

void showSelectionSheet({
  required String title,
  required Map<String, String> items,
  required String selected,
  required void Function(String key, String value) onSelected,
}) {
  final ValueNotifier<String> searchTerm = ValueNotifier<String>('');

  Get.bottomSheet(
    FractionallySizedBox(
      heightFactor: 0.6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: RSizes.defaultSpace),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: RSizes.defaultSpace),
            // Sheet Title
            Text(
              title,
              style: Get.textTheme.titleMedium,
            ),
            const SizedBox(height: RSizes.spaceBtwItems),

            // Search Field
            TextField(
              onChanged: (value) => searchTerm.value = value,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search $title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(RSizes.sm),
                ),
              ),
            ),
            const SizedBox(height: RSizes.spaceBtwItems),

            // Filtered List
            Expanded(
              child: ValueListenableBuilder<String>(
                valueListenable: searchTerm,
                builder: (context, search, _) {
                  final filtered = items.entries
                      .where((entry) => entry.value
                          .toLowerCase()
                          .contains(search.toLowerCase()))
                      .toList();

                  return ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const Divider(thickness: 0.4),
                    itemBuilder: (_, index) {
                      final entry = filtered[index];
                      final isSelected = selected == entry.value;

                      return ListTile(
                        title: Text(entry.value),
                        trailing: Icon(
                          isSelected
                              ? Icons.check_circle
                              : Icons.radio_button_off,
                          color: isSelected ? RColors.primary : Colors.grey,
                        ),
                        onTap: () {
                          Get.back();
                          onSelected(entry.key, entry.value);
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
    isScrollControlled: true,
    backgroundColor: Get.isDarkMode ? RColors.dark : RColors.light,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
  );
}
