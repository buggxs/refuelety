// Datei: components/fuel_station/widgets/fuel_station_filter.dart
import 'package:flutter/material.dart';
import 'package:refuelety/api/api.dart';

class FuelStationFilter extends StatefulWidget {
  const FuelStationFilter({
    super.key,
    required this.radius,
    required this.onRadiusChanged,
    required this.selectedFuelType,
    required this.onFuelTypeSelected,
  });

  final double radius;
  final ValueChanged<double> onRadiusChanged;
  final FuelType? selectedFuelType;
  final Function(FuelType?) onFuelTypeSelected;

  @override
  State<FuelStationFilter> createState() => _FuelStationFilterState();
}

class _FuelStationFilterState extends State<FuelStationFilter> {
  late double _currentRadius;
  late FuelType? _selectedFuelType;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _currentRadius = widget.radius;
    _selectedFuelType = widget.selectedFuelType;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Filter-Header mit Toggle
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.filter_list),
                  const SizedBox(width: 8),
                  Text(
                    'Suchfilter',
                    style: theme.textTheme.titleMedium,
                  ),
                  const Spacer(),
                  Text(
                    '${_currentRadius.toStringAsFixed(0)} km',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                ],
              ),
            ),
          ),

          // Erweiterter Filter-Bereich
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox(height: 0),
            secondChild: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Radius-Slider
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.radar,
                        size: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Suchradius: ${_currentRadius.toStringAsFixed(0)} km',
                              style: theme.textTheme.bodyMedium,
                            ),
                            Slider(
                              value: _currentRadius,
                              min: 1,
                              max: 25,
                              divisions: 24,
                              label: '${_currentRadius.toStringAsFixed(0)} km',
                              onChanged: (double value) {
                                setState(() {
                                  _currentRadius = value;
                                });
                              },
                              onChangeEnd: (double value) {
                                widget.onRadiusChanged(value);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Kraftstoff-Typ Filter
                  Text(
                    'Nach günstigsten Preis sortieren:',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      _buildFuelTypeChip(
                        FuelType.diesel,
                        'Diesel',
                        Icons.local_gas_station,
                      ),
                      _buildFuelTypeChip(
                        FuelType.e5,
                        'Benzin (E5)',
                        Icons.ev_station,
                      ),
                      _buildFuelTypeChip(
                        FuelType.e10,
                        'Benzin (E10)',
                        Icons.eco,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFuelTypeChip(FuelType type, String label, IconData icon) {
    final bool isSelected = _selectedFuelType == type;
    final ThemeData theme = Theme.of(context);

    return FilterChip(
      selected: isSelected,
      label: Text(label),
      showCheckmark: false,
      avatar: Icon(
        icon,
        size: 18,
        color: isSelected
            ? theme.colorScheme.onPrimary
            : theme.colorScheme.primary,
      ),
      selectedColor: theme.colorScheme.primary,
      checkmarkColor: theme.colorScheme.onPrimary,
      labelStyle: TextStyle(
        color: isSelected
            ? theme.colorScheme.onPrimary
            : theme.colorScheme.onSurface,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            _selectedFuelType = type;
          } else {
            _selectedFuelType = null;
          }
        });
        widget.onFuelTypeSelected(_selectedFuelType);
      },
    );
  }
}
