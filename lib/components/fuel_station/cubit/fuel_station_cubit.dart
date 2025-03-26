// Datei: components/fuel_station/cubit/fuel_station_cubit.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:refuelety/api/api.dart';
import 'package:refuelety/core/app_service_locator.dart';
import 'package:refuelety/features/geo/cubit/manage_geo_cubit.dart';
import 'package:refuelety/misc/logger.dart';

part 'fuel_station_state.dart';

class FuelStationCubit extends Cubit<FuelStationState> with LoggerMixin {
  FuelStationCubit({required this.geoCubit}) : super(FuelStationInitial()) {
    _getCurrentUserLocation();
  }

  final ManageGeoCubit geoCubit;
  final FuelService _fuelService = app<FuelService>();

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

    final LatLng userLocation = LatLng(
      currentPosition!.latitude,
      currentPosition.longitude,
    );

    emit(FuelStationLoading(userLocation: userLocation));

    _loadFuelStations(userLocation);
  }

  Future<void> _loadFuelStations(LatLng location, {double radius = 5.0}) async {
    _loadFuelStationsWithParams(
      lat: location.latitude,
      lng: location.longitude,
      radius: radius,
    );
  }

  Future<void> loadFuelStationsWithRadius(
    LatLng location,
    double radius,
  ) async {
    if (state is FuelStationLoaded) {
      emit((state as FuelStationLoaded).toFuelStationLoading());
    } else {
      emit(FuelStationLoading(userLocation: location));
    }

    _loadFuelStationsWithParams(
      lat: location.latitude,
      lng: location.longitude,
      radius: radius,
    );
  }

  Future<void> _loadFuelStationsWithParams({
    required double lat,
    required double lng,
    double radius = 5.0,
    FuelType type = FuelType.all,
    String sort = 'dist',
  }) async {
    try {
      log.info('Lade Tankstellen mit Radius: $radius km');

      if (state case final FuelStationLoading loadingState) {
        final FuelStationPage<FuelStation> fuelStations =
            await _fuelService.getFuelStationInRadius(
          lat: lat,
          lng: lng,
          radius: radius,
          type: type,
          sort: sort,
        );

        emit(
          loadingState.toFuelStationLoaded(
            selectedFuelType: type,
            fuelStations: fuelStations,
            userLocation: LatLng(lat, lng),
          ),
        );
      }
    } catch (e) {
      log.severe('Fehler beim Laden der Tankstellen: $e');
      emit(
        FuelStationError(
          message: 'Fehler beim Laden der Tankstellen: $e',
          userLocation: LatLng(lat, lng),
        ),
      );
    }
  }

  List<FuelStation> filterStations(FuelType? type) {
    if (state case final FuelStationLoaded loadedState) {
      final List<FuelStation> filteredStations = List<FuelStation>.of(
        loadedState.fuelStations.stations ?? <FuelStation>[],
      );

      filteredStations.sort((FuelStation a, FuelStation b) {
        double? priceA;
        double? priceB;

        switch (type) {
          case FuelType.diesel:
            priceA = a.diesel;
            priceB = b.diesel;
            break;
          case FuelType.e5:
            priceA = a.e5;
            priceB = b.e5;
            break;
          case FuelType.e10:
            priceA = a.e10;
            priceB = b.e10;
            break;
          default:
            // Use distance if null
            priceA = a.dist;
            priceB = b.dist;
            break;
        }

        if (priceA == null && priceB == null) {
          return 0;
        }

        if (priceA == null) {
          return 1;
        }
        if (priceB == null) {
          return -1;
        }

        return priceA.compareTo(priceB);
      });

      return filteredStations;
    }
    return <FuelStation>[];
  }

  void onRadiusChanged(double radius) {
    if (state case final FuelStationLoaded loadedState) {
      loadFuelStationsWithRadius(
        loadedState.userLocation!,
        radius,
      );
      emit(state.copyWith(searchRadius: radius));
    }
  }

  void onFuelTypeSelected(FuelType? type) {
    if (state case final FuelStationLoaded loadedState) {
      final List<FuelStation> stations = filterStations(type);

      emit(
        loadedState.copyWith(
          selectedFuelType: type,
          fuelStations: FuelStationPage<FuelStation>(
            ok: true,
            status: loadedState.fuelStations.status,
            message: loadedState.fuelStations.message,
            stations: stations,
          ),
        ),
      );

      log.info(
        'Stationen nach $type sortiert. '
        '${stations.length} Stationen verfügbar.',
      );
    }
  }
}
