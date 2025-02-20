part of 'map_cubit.dart';

class MapState {
  final bool isLoading;
  final Set<Marker> markers;
  final List<FuelStation> stations;
  final String? error;
  final FuelStation? selectedStation;
  final LatLng? selectedLocation;

  MapState({
    this.isLoading = false,
    this.markers = const {},
    this.stations = const [],
    this.error,
    this.selectedStation,
    this.selectedLocation,
  });

  MapState copyWith({
    bool? isLoading,
    Set<Marker>? markers,
    List<FuelStation>? stations,
    String? error,
    FuelStation? selectedStation,
    LatLng? selectedLocation,
  }) {
    return MapState(
      isLoading: isLoading ?? this.isLoading,
      markers: markers ?? this.markers,
      stations: stations ?? this.stations,
      error: error,
      selectedStation: selectedStation,
      selectedLocation: selectedLocation,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MapState &&
        other.isLoading == isLoading &&
        other.markers == markers &&
        other.stations == stations &&
        other.error == error &&
        other.selectedStation == selectedStation &&
        other.selectedLocation == selectedLocation;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        markers.hashCode ^
        stations.hashCode ^
        error.hashCode ^
        selectedStation.hashCode ^
        selectedLocation.hashCode;
  }
}
