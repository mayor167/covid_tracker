import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app_boilerplate/common/widgets/form/auto_renewal_option_card.dart';
import 'package:flutter_app_boilerplate/common/widgets/form/schedule_order_card.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter_app_boilerplate/utils/helpers/functions.dart';

class OrderSummarySheet extends StatelessWidget {
  // General params
  final String logoPath;
  final String? networkName;
  final String? price;
  // Bills param
  final String? selectedPackage,
      decoderNumber,
      accountID,
      phoneNumber,
      email,
      customerName,
      customerAddress,
      meterNumber,
      quantity;
  // Auto-renew and scheduling
  final RxString? autoRenewOptionDisplay, scheduleDate;
  final TextEditingController? autoRenewController, dateTimeController;
  final VoidCallback onConfirm;
  // Withdrawal params
  final bool isWithdrawal;
  final String? bankName, accountName, accountNumber, amountToWithdraw;

  const OrderSummarySheet({
    super.key,
    required this.logoPath,
    this.networkName,
    this.phoneNumber,
    this.email,
    this.selectedPackage,
    this.price,
    this.autoRenewOptionDisplay,
    this.autoRenewController,
    this.scheduleDate,
    this.dateTimeController,
    required this.onConfirm,
    this.decoderNumber,
    this.accountID,
    this.customerName,
    this.customerAddress,
    this.meterNumber,
    this.quantity,
    this.isWithdrawal = false,
    this.bankName,
    this.accountName,
    this.accountNumber,
    this.amountToWithdraw,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the button text based on the mode
    final buttonText = isWithdrawal ? "Confirm Withdrawal" : "Confirm Purchase";

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(RSizes.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Logo
            Center(
              child: ClipOval(
                child: Image.asset(
                  logoPath,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: RSizes.spaceBtwItems),

            // -----------------------------------------------------------------
            // CONDITIONAL DETAIL ROWS
            // -----------------------------------------------------------------
            if (isWithdrawal)
              // Withdrawal Summary
              ..._buildWithdrawalRows(context)
            else
              // Purchase / Bill Payment Summary
              ..._buildPurchaseRows(context),

            // -----------------------------------------------------------------
            // SCHEDULE AND AUTORENEW CARDS (Only for Purchases)
            // -----------------------------------------------------------------
            if (!isWithdrawal) ...[
              const SizedBox(height: RSizes.spaceBtwItems),

              // Auto-Renew option card
              if (autoRenewOptionDisplay != null && autoRenewController != null)
                AutoRenewalOptionCard(
                  title: 'Auto-Renew Option',
                  items: autoRenewal,
                  selectedValue: 'autoRenew'.obs,
                  displayText: autoRenewOptionDisplay!,
                  labelPrefix: 'Auto-Renew: ',
                  icon: Icons.repeat_outlined,
                  onSelected: (key, value) {
                    autoRenewController!.text = key;
                  },
                ),

              const SizedBox(height: RSizes.spaceBtwItems),

              // Schedule order card
              if (scheduleDate != null && dateTimeController != null)
                SchedulePickerCard(
                  dateTimeController: dateTimeController,
                  selectedDateTime: scheduleDate!,
                  format: 'MMM dd, yyyy – hh:mm a',
                  onChanged: (pickedDate) {
                    dateTimeController!.text = pickedDate.toString();
                  },
                ),

              const SizedBox(height: RSizes.spaceBtwItems * 2),
            ],

            const SizedBox(height: RSizes.spaceBtwItems * 2),

            /// Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: RColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(RSizes.buttonRadius),
                  ),
                ),
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds rows specific to a Bill Payment or Purchase
  List<Widget> _buildPurchaseRows(BuildContext context) {
    return [
      _buildRow("Service", networkName ?? 'N/A', context),
      ..._buildOptionalRow("Phone Number", phoneNumber, context),
      ..._buildOptionalRow("Email", email, context),
      ..._buildOptionalRow("Package", selectedPackage, context),
      ..._buildOptionalRow("Quantity", quantity, context),
      ..._buildOptionalRow("Decoder Number", decoderNumber, context),
      ..._buildOptionalRow("Account ID", accountID, context),
      ..._buildOptionalRow("Meter Number", meterNumber, context),
      ..._buildOptionalRow("Customer Name", customerName, context),
      ..._buildOptionalRow("Customer Address", customerAddress, context),
      _buildRow("Price", "₦${price ?? '0.00'}", context),
    ];
  }

  /// Builds rows specific to a Withdrawal
  List<Widget> _buildWithdrawalRows(BuildContext context) {
    return [
      _buildRow("Service", "Withdrawal", context),
      ..._buildOptionalRow("Bank Name", bankName, context),
      ..._buildOptionalRow("Account Name", accountName, context),
      ..._buildOptionalRow("Account Number", accountNumber, context),
      // Use amountToWithdraw if provided, otherwise fall back to price
      _buildRow("Amount to withdraw", "₦${amountToWithdraw ?? price}", context),
    ];
  }

  Widget _buildRow(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: RSizes.sm),
      child: Row(
        children: [
          Text("$label:", style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(width: RSizes.sm),
          Expanded(
            child: Text(value,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildOptionalRow(
      String label, String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty || value == 'null null') {
      return [];
    }
    return [
      _buildRow(label, value, context),
      const SizedBox(height: RSizes.sm),
    ];
  }
}
