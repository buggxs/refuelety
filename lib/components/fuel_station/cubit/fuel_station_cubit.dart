import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:refuelety/api/api.dart';
import 'package:refuelety/core/app_service_locator.dart';
import 'package:refuelety/features/geo/cubit/manage_geo_cubit.dart';

part 'fuel_station_state.dart';

class FuelStationCubit extends Cubit<FuelStationState> {
  FuelStationCubit({required this.geoCubit}) : super(FuelStationInitial()) {
    _getCurrentUserLocation();
  }

  Future<void> _getCurrentUserLocation() async {
    geoCubit.state.when(
      initial: () => null,
      loading: () => null,
      success: _onSuccess,
      permissionDenied: () => null,
      error: (String error) => null,
    );
  }

  void _onSuccess(Stream<Position>? positionStream, Position? currentPosition) {
    if (currentPosition?.latitude == null ||
        currentPosition?.longitude == null) {
      return;
    }
    emit(
      FuelStationLoading(
        userLocation: LatLng(
          currentPosition!.latitude,
          currentPosition.longitude,
        ),
      ),
    );
    _loadFuelStations(
      LatLng(
        currentPosition.latitude,
        currentPosition.longitude,
      ),
    );
  }

  Future<void> _loadFuelStations(LatLng location) async {
    final FuelStationPage<FuelStation> fuelStations =
        await app<FuelService>().getFuelStationInRadius(
      lat: location.latitude,
      lng: location.longitude,
    );
    emit(
      FuelStationLoaded(
        fuelStations: fuelStations,
        userLocation: location,
      ),
    );
  }

  ManageGeoCubit geoCubit;
}
