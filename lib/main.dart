import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/bindings/dependencies.dart' as dep;
import 'app.dart';

void main() async {
  // Ensure Widgets binding is initialized
  // WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  await dep.init();
  runApp(const App());
}
