import 'package:flutter/material.dart';
import 'package:refuelety/api/api.dart';

class FuelStationCard extends StatelessWidget {
  const FuelStationCard({super.key, required this.station});

  final FuelStation station;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              station.name ?? 'Unbekannte Tankstelle',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Marke: ${station.brand ?? 'Unbekannt'}'),
            Text('Entfernung: ${station.dist?.toStringAsFixed(2)} km'),
            const SizedBox(height: 8),
            Text(
              'Diesel: ${station.diesel?.toStringAsFixed(2)} €/L',
              style: TextStyle(
                fontSize: 16,
                color: station.isOpen == true ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              station.isOpen == true ? 'Geöffnet' : 'Geschlossen',
              style: TextStyle(
                fontSize: 16,
                color: station.isOpen == true ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
