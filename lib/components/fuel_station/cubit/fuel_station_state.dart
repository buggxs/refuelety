part of 'fuel_station_cubit.dart';

abstract class FuelStationState {
  FuelStationState({this.userLocation});

  LatLng? userLocation;
}

class FuelStationInitial extends FuelStationState {
  FuelStationInitial() : super();
}

class FuelStationLoading extends FuelStationState {
  FuelStationLoading({super.userLocation});

  FuelStationLoaded toFuelStationLoaded({
    required FuelStationPage<FuelStation> fuelStations,
  }) {
    return FuelStationLoaded(
      fuelStations: fuelStations,
      userLocation: userLocation!,
    );
  }
}

class FuelStationLoaded extends FuelStationState {
  FuelStationLoaded({
    required this.fuelStations,
    super.userLocation,
  });

  final FuelStationPage<FuelStation> fuelStations;

  FuelStationLoading toFuelStationLoading() {
    return FuelStationLoading();
  }

  FuelStationLoaded copyWith({
    FuelStationPage<FuelStation>? fuelStations,
    LatLng? userLocation,
  }) {
    return FuelStationLoaded(
      fuelStations: fuelStations ?? this.fuelStations,
      userLocation: userLocation!,
    );
  }
}
