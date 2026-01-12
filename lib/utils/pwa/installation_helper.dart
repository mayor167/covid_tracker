import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/utils/pwa/add_to_homescreen_prompt.dart';
import 'package:flutter_app_boilerplate/utils/pwa/pwa_utility.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class InstallationHelper {
  static const String _promptShownKey = 'install_prompt_shown';
  static const String _dismissCountKey = 'install_prompt_dismiss_count';
  static const int _maxDismissCount = 500;

  static Future<bool> shouldShowPrompt() async {
    if (!PWAUtils.canBeInstalled) return false;

    final prefs = await SharedPreferences.getInstance();
    final bool alreadyShown = prefs.getBool(_promptShownKey) ?? false;
    final int dismissCount = prefs.getInt(_dismissCountKey) ?? 0;

    return !alreadyShown && dismissCount < _maxDismissCount;
  }

  static Future<void> markPromptAsShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_promptShownKey, true);
  }

  static Future<void> incrementDismissCount() async {
    final prefs = await SharedPreferences.getInstance();
    final int currentCount = prefs.getInt(_dismissCountKey) ?? 0;
    await prefs.setInt(_dismissCountKey, currentCount + 1);
  }

  static Future<void> resetDismissCount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_dismissCountKey);
  }
}

class InstallationPromptManager extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final bool showAutomatically;

  const InstallationPromptManager({
    super.key,
    required this.child,
    this.delay = const Duration(seconds: 5),
    this.showAutomatically = true,
  });

  @override
  State<InstallationPromptManager> createState() =>
      _InstallationPromptManagerState();
}

class _InstallationPromptManagerState extends State<InstallationPromptManager> {
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    if (widget.showAutomatically) {
      _checkAndShowPrompt();
    }
  }

  Future<void> _checkAndShowPrompt() async {
    if (await InstallationHelper.shouldShowPrompt()) {
      await Future.delayed(widget.delay);
      if (mounted) {
        _showPrompt();
      }
    }
  }

  void _showPrompt() {
    final overlay = Overlay.of(context);
    // ignore: unnecessary_null_comparison
    if (overlay == null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        left: 20,
        right: 20,
        child: AddToHomeScreenPrompt(
          appName: 'MyTrader',
          onDismiss: () {
            _removePrompt();
            InstallationHelper.incrementDismissCount();
          },
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _removePrompt() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removePrompt();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
