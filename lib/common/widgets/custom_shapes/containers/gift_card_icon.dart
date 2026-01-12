import 'package:flutter/material.dart';

class GiftCardIcon extends StatelessWidget {
  const GiftCardIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.shade400,
            Colors.purple.shade700,
          ],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withAlpha(102),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Shine effect
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
          // Main icon
          const Icon(
            Icons.card_giftcard,
            color: Colors.white,
            size: 28,
          ),
          // Bottom accent
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pink.shade200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
