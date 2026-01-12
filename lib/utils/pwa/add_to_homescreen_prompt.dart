// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_boilerplate/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/helpers/helper_functions.dart';
import 'package:flutter_app_boilerplate/utils/pwa/pwa_utility.dart';

class AddToHomeScreenPrompt extends StatefulWidget {
  final String appName;
  final String promptMessage;
  final String instructionMessage;
  final VoidCallback? onDismiss;

  const AddToHomeScreenPrompt({
    super.key,
    required this.appName,
    this.promptMessage =
        'Install our app directly to your home screen.\nNo app store. Just follow the steps below!',
    this.instructionMessage =
        'Tap the share button and select "Add to Home Screen"',
    this.onDismiss,
  });

  @override
  State<AddToHomeScreenPrompt> createState() => _AddToHomeScreenPromptState();
}

class _AddToHomeScreenPromptState extends State<AddToHomeScreenPrompt> {
  bool _showPrompt = true;

  void _closePrompt() {
    setState(() {
      _showPrompt = false;
    });
    widget.onDismiss?.call();
  }

  void _copyInstructions() {
    String instructions;

    if (PWAUtils.isIOS) {
      instructions = 'How to install ${widget.appName} on iOS:\n'
          '1. Tap the Share icon at the bottom in Safari, or at the top in Chrome.\n'
          '2. Scroll down and select "Add to Home Screen"\n'
          '3. Tap "Add" in the top right corner';
    } else if (PWAUtils.isAndroid) {
      instructions = 'How to install ${widget.appName} on Android:\n'
          '1. Tap the menu button (3 dots) in Chrome\n'
          '2. Select "Add to Home Screen"\n'
          '3. Tap "Add" to install';
    } else {
      instructions = 'How to install ${widget.appName}:\n'
          '1. Look for the install option in your browser menu\n'
          '2. Select "Add to Home Screen" or "Install App"';
    }

    Clipboard.setData(ClipboardData(text: instructions));
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Instructions copied to clipboard')));
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = RHelperFunctions.isDarkMode(context);
    if (!_showPrompt || !PWAUtils.canBeInstalled) {
      return const SizedBox.shrink();
    }

    return RRoundedContainer(
      padding: const EdgeInsets.all(16),
      backgroundColor: isDarkMode ? RColors.dark : RColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Install App',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: _closePrompt,
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildPlatformSpecificInstructions(),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _copyInstructions,
                  child: const Text('Copy Instructions'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: _closePrompt,
                  child: const Text('Got It'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformSpecificInstructions() {
    if (PWAUtils.isIOS) {
      return _buildIOSInstructions();
    } else if (PWAUtils.isAndroid) {
      return _buildAndroidInstructions();
    } else {
      return _buildGenericInstructions();
    }
  }

  Widget _buildIOSInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Install our app directly to your home screen.\nNo app store. Just follow the steps below!',
          //style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        _buildInstructionStep(
          icon: CupertinoIcons.share,
          text:
              'Tap the Share icon at the bottom in Safari, or at the top-right in Chrome.',
        ),
        _buildInstructionStep(
          icon: CupertinoIcons.plus_app,
          text: 'Scroll down to find "Add to Home Screen"',
        ),
        _buildInstructionStep(
          icon: Icons.add,
          text: 'Tap "Add" in the top right corner',
        ),
      ],
    );
  }

  Widget _buildAndroidInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Install our app directly to your home screen.\nNo play store. Just follow the steps below!',
        ),
        const SizedBox(height: 15),
        _buildInstructionStep(
          icon: Icons.more_vert,
          text: 'Tap the menu button (3 dots) at the top-right in Chrome',
        ),
        _buildInstructionStep(
          icon: Icons.add_to_home_screen,
          text: 'Scroll down and tap "Add to Home Screen"',
        ),
        _buildInstructionStep(
          icon: Icons.arrow_downward_rounded,
          text: 'Tap "install", and confirm',
        ),
      ],
    );
  }

  Widget _buildGenericInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Install our app directly to your home screen.\nJust follow the steps below!',
          //style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        _buildInstructionStep(
          icon: Icons.menu,
          text: 'Look for the install option in your browser menu',
        ),
        _buildInstructionStep(
          icon: Icons.add_box,
          text: 'Select "Add to Home Screen" or "Install App"',
        ),
        _buildInstructionStep(
          icon: Icons.done,
          text: 'Confirm the installation',
        ),
      ],
    );
  }

  Widget _buildInstructionStep({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}
