// Datei: components/fuel_station/cubit/fuel_station_state.dart
part of 'fuel_station_cubit.dart';

abstract class FuelStationState {
  FuelStationState({
    this.userLocation,
    this.selectedFuelTypes = const <FuelType>{},
    this.searchRadius = 5,
  });

  final LatLng? userLocation;
  final Set<FuelType> selectedFuelTypes;
  final double searchRadius;

  FuelStationState copyWith({
    LatLng? userLocation,
    Set<FuelType>? selectedFuelTypes,
    double? searchRadius,
  });
}

class FuelStationInitial extends FuelStationState {
  FuelStationInitial() : super();

  @override
  FuelStationState copyWith({
    LatLng? userLocation,
    Set<FuelType>? selectedFuelTypes,
    double? searchRadius,
  }) {
    return FuelStationInitial();
  }
}

class FuelStationLoading extends FuelStationState {
  FuelStationLoading({
    super.userLocation,
    super.selectedFuelTypes = const <FuelType>{},
    super.searchRadius = 5,
  });

  FuelStationLoaded toFuelStationLoaded({
    required FuelStationPage<FuelStation> fuelStations,
    Set<FuelType> selectedFuelTypes = const <FuelType>{},
  }) {
    return FuelStationLoaded(
      fuelStations: fuelStations,
      userLocation: userLocation!,
      selectedFuelTypes: selectedFuelTypes,
    );
  }

  @override
  FuelStationState copyWith({
    LatLng? userLocation,
    Set<FuelType>? selectedFuelTypes,
    double? searchRadius,
  }) {
    return FuelStationLoading(
      userLocation: userLocation ?? this.userLocation,
      selectedFuelTypes: selectedFuelTypes ?? this.selectedFuelTypes,
      searchRadius: searchRadius ?? this.searchRadius,
    );
  }
}

class FuelStationLoaded extends FuelStationState {
  FuelStationLoaded({
    required this.fuelStations,
    required LatLng userLocation,
    super.selectedFuelTypes = const <FuelType>{},
    super.searchRadius = 5,
  }) : super(
          userLocation: userLocation,
        );

  final FuelStationPage<FuelStation> fuelStations;

  FuelStationLoading toFuelStationLoading() {
    return FuelStationLoading(
      userLocation: userLocation,
      selectedFuelTypes: selectedFuelTypes,
    );
  }

  @override
  FuelStationLoaded copyWith({
    LatLng? userLocation,
    Set<FuelType>? selectedFuelTypes,
    double? searchRadius,
    FuelStationPage<FuelStation>? fuelStations,
  }) {
    return FuelStationLoaded(
      fuelStations: fuelStations ?? this.fuelStations,
      userLocation: userLocation ?? this.userLocation!,
      searchRadius: searchRadius ?? this.searchRadius,
      selectedFuelTypes: selectedFuelTypes ?? this.selectedFuelTypes,
    );
  }
}

class FuelStationError extends FuelStationState {
  FuelStationError({
    required this.message,
    super.userLocation,
    super.selectedFuelTypes,
  });

  final String message;

  @override
  FuelStationState copyWith({
    LatLng? userLocation,
    Set<FuelType>? selectedFuelTypes,
    double? searchRadius,
  }) {
    return FuelStationError(
      message: message,
      userLocation: userLocation ?? this.userLocation,
      selectedFuelTypes: selectedFuelTypes ?? this.selectedFuelTypes,
    );
  }
}
