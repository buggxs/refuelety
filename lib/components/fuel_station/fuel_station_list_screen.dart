import 'package:flutter/material.dart';
import 'package:refuelety/api/api.dart';
import 'package:refuelety/components/fuel_station/widgets/fuel_station_card.dart';
import 'package:refuelety/core/app_service_locator.dart';

class FuelStationListScreen extends StatefulWidget {
  const FuelStationListScreen({super.key});

  static const String route = 'fuel_station_list';

  @override
  // ignore: library_private_types_in_public_api
  _FuelStationListScreenState createState() => _FuelStationListScreenState();
}

class _FuelStationListScreenState extends State<FuelStationListScreen> {
  late Future<FuelStationPage<FuelStation>> _fuelStationsFuture;

  @override
  void initState() {
    super.initState();
    _fuelStationsFuture = fetchFuelStations();
  }

  Future<FuelStationPage<FuelStation>> fetchFuelStations() async {
    // TODO: use location of phone
    return app<FuelService>().getFuelStationInRadius(lat: 51.25, lng: 9.77);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement cubit
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tankstellen Übersicht'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Filter-Action implementieren
            },
          ),
        ],
      ),
      body: FutureBuilder<FuelStationPage<FuelStation>>(
        future: _fuelStationsFuture,
        builder: (_, AsyncSnapshot<FuelStationPage<FuelStation>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Fehler beim Laden der Daten'));
          } else if (!snapshot.hasData || snapshot.data!.stations!.isEmpty) {
            return const Center(child: Text('Keine Tankstellen gefunden'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.stations!.length,
              itemBuilder: (_, int index) {
                final FuelStation station = snapshot.data!.stations![index];
                return FuelStationCard(station: station);
              },
            );
          }
        },
      ),
    );
  }
}
