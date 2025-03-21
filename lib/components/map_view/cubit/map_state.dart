part of 'map_cubit.dart';

class MapState {
  MapState({
    this.isLoading = false,
    this.markers = const <Marker>{},
    this.stations = const <FuelStation>[],
    this.error,
    this.selectedStation,
    this.selectedLocation,
    this.userPosition,
  });

  final bool isLoading;
  final Set<Marker> markers;
  final List<FuelStation> stations;
  final String? error;
  final FuelStation? selectedStation;
  final LatLng? selectedLocation;
  final LatLng? userPosition;

  MapState copyWith({
    bool? isLoading,
    Set<Marker>? markers,
    List<FuelStation>? stations,
    String? error,
    FuelStation? selectedStation,
    LatLng? selectedLocation,
    LatLng? userPosition,
  }) {
    return MapState(
      isLoading: isLoading ?? this.isLoading,
      markers: markers ?? this.markers,
      stations: stations ?? this.stations,
      error: error ?? this.error,
      selectedStation: selectedStation ?? this.selectedStation,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      userPosition: userPosition ?? this.userPosition,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is MapState &&
        other.isLoading == isLoading &&
        other.markers == markers &&
        other.stations == stations &&
        other.error == error &&
        other.selectedStation == selectedStation &&
        other.selectedLocation == selectedLocation &&
        userPosition == userPosition;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        markers.hashCode ^
        stations.hashCode ^
        error.hashCode ^
        selectedStation.hashCode ^
        selectedLocation.hashCode ^
        userPosition.hashCode;
  }
}
