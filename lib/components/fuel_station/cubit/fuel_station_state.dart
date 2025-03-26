// Datei: components/fuel_station/cubit/fuel_station_state.dart
part of 'fuel_station_cubit.dart';

abstract class FuelStationState implements Equatable {
  FuelStationState({
    this.userLocation,
    this.selectedFuelType = FuelType.diesel,
    this.searchRadius = 5,
  });

  final LatLng? userLocation;
  final FuelType selectedFuelType;
  final double searchRadius;

  FuelStationState copyWith({
    LatLng? userLocation,
    FuelType? selectedFuelType,
    double? searchRadius,
  });
}

class FuelStationInitial extends FuelStationState {
  FuelStationInitial() : super();

  @override
  FuelStationState copyWith({
    LatLng? userLocation,
    FuelType? selectedFuelType,
    double? searchRadius,
  }) {
    return FuelStationInitial();
  }

  @override
  List<Object?> get props => <Object?>[
        userLocation,
        selectedFuelType,
        searchRadius,
      ];

  @override
  bool? get stringify => throw UnimplementedError();
}

class FuelStationLoading extends FuelStationState {
  FuelStationLoading({
    super.userLocation,
    super.selectedFuelType,
    super.searchRadius = 5,
  });

  FuelStationLoaded toFuelStationLoaded({
    required FuelStationPage<FuelStation> fuelStations,
    FuelType? selectedFuelTypes,
    LatLng? userLocation,
  }) {
    return FuelStationLoaded(
      fuelStations: fuelStations,
      userLocation: userLocation ?? this.userLocation!,
      selectedFuelType: selectedFuelType,
    );
  }

  @override
  FuelStationState copyWith({
    LatLng? userLocation,
    FuelType? selectedFuelType,
    double? searchRadius,
  }) {
    return FuelStationLoading(
      userLocation: userLocation ?? this.userLocation,
      selectedFuelType: selectedFuelType ?? this.selectedFuelType,
      searchRadius: searchRadius ?? this.searchRadius,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        userLocation,
        selectedFuelType,
        searchRadius,
      ];

  @override
  bool? get stringify => throw UnimplementedError();
}

class FuelStationLoaded extends FuelStationState {
  FuelStationLoaded({
    required this.fuelStations,
    required LatLng userLocation,
    super.selectedFuelType,
    super.searchRadius = 5,
  }) : super(
          userLocation: userLocation,
        );

  final FuelStationPage<FuelStation> fuelStations;

  FuelStationLoading toFuelStationLoading() {
    return FuelStationLoading(
      userLocation: userLocation,
      selectedFuelType: selectedFuelType,
    );
  }

  @override
  FuelStationLoaded copyWith({
    LatLng? userLocation,
    FuelType? selectedFuelType,
    double? searchRadius,
    FuelStationPage<FuelStation>? fuelStations,
  }) {
    return FuelStationLoaded(
      fuelStations: fuelStations ?? this.fuelStations,
      userLocation: userLocation ?? this.userLocation!,
      searchRadius: searchRadius ?? this.searchRadius,
      selectedFuelType: selectedFuelType ?? this.selectedFuelType,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        userLocation,
        selectedFuelType,
        searchRadius,
        fuelStations,
      ];

  @override
  bool? get stringify => throw UnimplementedError();
}

class FuelStationError extends FuelStationState {
  FuelStationError({
    required this.message,
    super.userLocation,
    super.selectedFuelType,
  });

  final String message;

  @override
  FuelStationState copyWith({
    LatLng? userLocation,
    FuelType? selectedFuelType,
    double? searchRadius,
  }) {
    return FuelStationError(
      message: message,
      userLocation: userLocation ?? this.userLocation,
      selectedFuelType: selectedFuelType ?? this.selectedFuelType,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        userLocation,
        selectedFuelType,
        searchRadius,
        message,
      ];

  @override
  bool? get stringify => throw UnimplementedError();
}
