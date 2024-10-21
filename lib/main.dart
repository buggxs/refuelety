import 'package:flutter/material.dart';
import 'package:refuelety/components/fuel_station/fuel_station_list_screen.dart';
import 'package:refuelety/core/app_service_locator.dart';

void main() {
  // Register services and logging
  setup();

  // Start the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement routing
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FuelStationListScreen(),
    );
  }
}
