
import 'package:flutter/material.dart';
import 'package:refuelety/api/api.dart';

class StationInfoWindow extends StatelessWidget {
  final FuelStation station;
  final VoidCallback? onClose;

  const StationInfoWindow({
    super.key,
    required this.station,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: station.isOpen == true ? Colors.green : Colors.red,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    station.name ?? 'Unbekannte Tankstelle',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              station.brand ?? 'Unbekannte Marke',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${station.street} ${station.houseNumber}, ${station.postCode} ${station.place}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const Divider(height: 16),
            _buildPriceRow('Diesel', station.diesel),
            _buildPriceRow('E5', station.e5),
            _buildPriceRow('E10', station.e10),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      station.isOpen == true
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: station.isOpen == true
                          ? Colors.green
                          : Colors.red,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      station.isOpen == true ? 'Geöffnet' : 'Geschlossen',
                      style: TextStyle(
                        color: station.isOpen == true
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${station.dist?.toStringAsFixed(1)} km',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Navigation zur Tankstelle implementieren
                },
                icon: const Icon(Icons.directions),
                label: const Text('Route planen'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double? price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            price != null ? '${price.toStringAsFixed(2)} €' : 'n/a',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}