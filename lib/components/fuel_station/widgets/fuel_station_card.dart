// Datei: fuel_station_card.dart
import 'package:flutter/material.dart';
import 'package:refuelety/api/api.dart';

class FuelStationCard extends StatelessWidget {
  const FuelStationCard({super.key, required this.station});

  final FuelStation station;

  @override
  Widget build(BuildContext context) {
    // Bestimme Statusfarbe basierend auf Öffnungsstatus
    final Color statusColor =
        station.isOpen == true ? Colors.green : Colors.red;
    final ThemeData theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: statusColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Hier könnte Navigation zur Detailansicht erfolgen
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Oberer Abschnitt mit Brand-Logo und Entfernung
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Logo und Markenname
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              (station.brand?.isNotEmpty == true)
                                  ? station.brand![0]
                                  : '?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                station.name ?? 'Unbekannte Tankstelle',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                station.brand ?? 'Unbekannte Marke',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey[600],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Entfernungsanzeige
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color:
                          theme.colorScheme.primaryContainer.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.directions_car,
                          size: 16,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${station.dist?.toStringAsFixed(1) ?? '?'} km',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Mittlerer Abschnitt mit Kraftstoffpreisen
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildPriceColumn('Diesel', station.diesel),
                  _buildPriceColumn('E5', station.e5),
                  _buildPriceColumn('E10', station.e10),
                ],
              ),

              const SizedBox(height: 16),

              // Unterer Abschnitt mit Adresse und Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Adresse
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            _buildAddressString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Status-Anzeige
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          station.isOpen == true
                              ? Icons.check_circle_outline
                              : Icons.cancel_outlined,
                          size: 16,
                          color: statusColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          station.isOpen == true ? 'Geöffnet' : 'Geschlossen',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hilfsmethode zum Erstellen der Preisanzeige
  Widget _buildPriceColumn(String label, double? price) {
    final bool hasPrice = price != null;

    // Wähle das passende Icon je nach Kraftstofftyp
    IconData fuelIcon;
    switch (label) {
      case 'Diesel':
        fuelIcon = Icons.local_gas_station;
        break;
      case 'E5':
        fuelIcon = Icons.ev_station;
        break;
      case 'E10':
        fuelIcon = Icons.eco;
        break;
      default:
        fuelIcon = Icons.local_gas_station;
    }

    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              fuelIcon,
              size: 16,
              color: Colors.grey,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          hasPrice ? '${price.toStringAsFixed(2)} €' : '—',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: hasPrice ? Colors.black87 : Colors.grey,
          ),
        ),
      ],
    );
  }

  // Hilfsmethode zum Erstellen des Adressstrings
  String _buildAddressString() {
    final List<String> addressParts = <String>[];

    if (station.street != null) {
      final String adressPart = station.street! +
          (station.houseNumber != null ? ' ${station.houseNumber}' : '');
      addressParts.add(
        adressPart,
      );
    }

    if (station.postCode != null || station.place != null) {
      final String locationPart = <String?>[
        if (station.postCode != null) station.postCode.toString(),
        if (station.place != null) station.place,
      ].join(' ');

      if (locationPart.isNotEmpty) {
        addressParts.add(locationPart);
      }
    }

    return addressParts.join(', ');
  }
}
