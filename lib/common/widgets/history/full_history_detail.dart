import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_boilerplate/common/widgets/appbar/appbar.dart';
import 'package:flutter_app_boilerplate/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';

class FullHistoryDetail extends StatelessWidget {
  const FullHistoryDetail({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic data = Get.arguments;
    return Scaffold(
      appBar: RAppBar(
        showBackArrow: true,
        actions: [
          SizedBox(
            width: RSizes.xl * 3.5,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Share'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(RSizes.defaultSpace),
          child: Column(
            children: [
              /// first card
              RHistoryDetailFirstCard(data: data),

              const SizedBox(
                height: RSizes.md,
              ),

              /// second card
              RHistoryDetailSecondCard(data: data),
            ],
          ),
        ),
      ),
    );
  }
}

class RHistoryDetailSecondCard extends StatelessWidget {
  const RHistoryDetailSecondCard({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return RRoundedContainer(
      backgroundColor:
          Get.isDarkMode ? RColors.darkContainer : RColors.lightContainer,
      width: double.maxFinite,
      // height: RDeviceUtils.getScreenHeight(context) * 0.3,
      child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: RSizes.lg, vertical: RSizes.lg * 2),
          child: Column(children: [
            RTransactionDetailRow(
              data: data['time'],
              title: 'Date',
            ),
            const SizedBox(
              height: RSizes.sm,
            ),
            // const Divider(),
            const SizedBox(
              height: RSizes.sm,
            ),
            RTransactionDetailRow(
              data: data['description'],
              title: 'Details',
            ),
            // const Divider()
          ])),
    );
  }
}

class RHistoryDetailFirstCard extends StatelessWidget {
  const RHistoryDetailFirstCard({
    super.key,
    required this.data,
  });

  final dynamic data;

  void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Copied!"),
        backgroundColor: RColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RRoundedContainer(
      backgroundColor:
          Get.isDarkMode ? RColors.darkContainer : RColors.lightContainer,
      width: double.maxFinite,
      // height: RDeviceUtils.getScreenHeight(context) * 0.45,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: RSizes.lg, horizontal: RSizes.lg),
        child: Column(
          children: [
            /// image part
            ClipOval(
              child: Image.asset(
                data['image'],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            // RCircularImage(
            //   image: data['image'],
            //   padding: 20,
            //   width: 100,
            //   height: 100,
            // ),
            const SizedBox(
              height: RSizes.spaceBtwItems,
            ),

            /// trans ID
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data['transactionID'],
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .apply(fontSizeFactor: 1.3),
                ),
                const SizedBox(
                  width: RSizes.lg,
                ),
                IconButton(
                    onPressed: () {
                      copyToClipboard(context, data['transactionID']);
                    },
                    icon: const Icon(Icons.copy))
              ],
            ),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: RSizes.spaceBtwItems,
            ),
            RTransactionDetailRow(
              data: data['amount'],
              title: 'Amount(\$)',
            ),
            //  const SizedBox(
            //           height: RSizes.sm,
            //         ),
            // const Divider(),
            const SizedBox(
              height: RSizes.md * 0.8,
            ),
            RTransactionDetailRow(
              data: data['nairaValue'],
              title: 'Amount(₦)',
            ),
            // const SizedBox(
            //         height: RSizes.sm,
            //       ),
            //  const Divider(),
            const SizedBox(
              height: RSizes.md * 0.8,
            ),
            RTransactionDetailRow(
              data: data['status'],
              title: 'Status',
            ),

            const SizedBox(
              height: RSizes.spaceBtwItems,
            ),
            // const Divider(
            //   thickness: 2,
            // ),
          ],
        ),
      ),
    );
  }
}

class RTransactionDetailRow extends StatelessWidget {
  const RTransactionDetailRow(
      {super.key,
      required this.title,
      required this.data,
      this.titleFontFactor = 1.2,
      this.dataFontFactor = 1.2});

  final String title;
  final dynamic data;
  final double titleFontFactor, dataFontFactor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(fontSizeFactor: titleFontFactor),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            data,
            textAlign: TextAlign.end,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(fontSizeFactor: dataFontFactor),
          ),
        )
      ],
    );
  }
}
