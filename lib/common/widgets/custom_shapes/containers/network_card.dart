import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/utils/helpers/functions.dart';

class NetworkCard extends StatelessWidget {
  final String networkName;
  final double width;
  final double height;
  final double size;

  const NetworkCard(
      {super.key,
      required this.networkName,
      this.width = 45,
      this.height = 45,
      this.size = 25});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: Image.asset(
      getLogoFromService(networkName.toLowerCase()),
      width: 40,
      height: 40,
      fit: BoxFit.cover,
    ));
  }
}
