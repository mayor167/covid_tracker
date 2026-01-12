import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

enum TooltipPosition { top, bottom, center, middle }

class CustomTooltip extends StatelessWidget {
  final String message;
  final TooltipPosition position;
  final Color iconColor;
  final Color backgroundColor;

  const CustomTooltip({
    super.key,
    required this.message,
    required this.position,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _toggleTooltip(context),
      child: CircleAvatar(
        radius: RSizes.sm,
        backgroundColor: backgroundColor,
        child: Icon(
          Icons.info_outline,
          color: iconColor,
          size: RSizes.iconXm,
        ),
      ),
    );
  }

  // Static variables to manage the tooltip visibility
  static OverlayEntry? _overlayEntry;
  static bool _isTooltipVisible = false;

  void _toggleTooltip(BuildContext context) {
    if (_isTooltipVisible) {
      _removeTooltip();
    } else {
      _showTooltip(context);
    }
  }

  void _showTooltip(BuildContext context) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    // Calculate tooltip position
    double top, left;
    switch (position) {
      case TooltipPosition.top:
        top = offset.dy - 80;
        left = offset.dx + size.width / 2 - 150;
        break;
      case TooltipPosition.bottom:
        top = offset.dy + size.height + 8;
        left = offset.dx + size.width / 2 - 150;
        break;
      case TooltipPosition.center:
        top = offset.dy + size.height / 2 - 30;
        left = offset.dx + size.width / 2 - 150;
        break;
      case TooltipPosition.middle:
        top = offset.dy;
        left = offset.dx + size.width / 2 - 150;
        break;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: top,
        left: left,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent, // Capture taps outside
          onTap: () => _removeTooltip(),
          child: Material(
            color: Colors.transparent,
            child: _TooltipContent(message: message),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
    _isTooltipVisible = true;

    _addDismissListener(context);
  }

  // Add listener to detect outside taps and page navigation
  void _addDismissListener(BuildContext context) {
    // Dismiss on any outside tap or page transition
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus(); // Remove any focus
      // ignore: deprecated_member_use
      ModalRoute.of(context)?.addScopedWillPopCallback(() {
        _removeTooltip(); // Remove tooltip on back press or page transition
        return Future.value(true);
      });
    });
  }

  void _removeTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isTooltipVisible = false;
  }
}

// Tooltip content widget
class _TooltipContent extends StatelessWidget {
  final String message;

  const _TooltipContent({required this.message});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth * 0.8;

        return Stack(
          alignment: Alignment.topCenter,
          children: [
            // Tooltip container
            Container(
              margin: const EdgeInsets.only(top: RSizes.sm),
              padding: const EdgeInsets.all(RSizes.lg / 2),
              width: maxWidth.clamp(200, 300),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(RSizes.lg / 2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Quick Tip",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: RSizes.sm),
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Arrow for the tooltip
            Positioned(
              top: 0,
              child: CustomPaint(
                size: const Size(RSizes.md, RSizes.sm),
                painter: _ArrowPainter(),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Arrow painter for the tooltip
class _ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.grey[800]!;
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
