import 'package:flutter/material.dart';
import 'package:refuelety/components/map_view/map_screen.dart';
import 'package:refuelety/core/app_service_locator.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: const MapScreen(),
    );
  }
}
