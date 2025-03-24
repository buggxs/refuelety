// Datei: components/fuel_station/cubit/fuel_station_cubit.dart
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

  // Öffentliche Methode zum Neuladen mit spezifischem Radius
  Future<void> loadFuelStationsWithRadius(
      LatLng location, double radius) async {
    if (state is FuelStationLoaded) {
      // Vorherigen Zustand beibehalten, nur Loading-Flag setzen
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

  // Private Methode mit allen Parametern für den API-Aufruf
  Future<void> _loadFuelStationsWithParams({
    required double lat,
    required double lng,
    double radius = 5.0,
    FuelType type = FuelType.all,
    String sort = 'dist',
  }) async {
    try {
      log.info('Lade Tankstellen mit Radius: $radius km');

      final FuelStationPage<FuelStation> fuelStations =
          await _fuelService.getFuelStationInRadius(
        lat: lat,
        lng: lng,
        radius: radius,
        type: type,
        sort: sort,
      );

      emit(
        FuelStationLoaded(
          fuelStations: fuelStations,
          userLocation: LatLng(lat, lng),
        ),
      );
    } catch (e) {
      log.severe('Fehler beim Laden der Tankstellen: $e');
      // Fehlerbehandlung hinzufügen
      emit(
        FuelStationError(
          message: 'Fehler beim Laden der Tankstellen: $e',
          userLocation: LatLng(lat, lng),
        ),
      );
    }
  }

  List<FuelStation> filterStations(List<FuelStation> stations) {
    if (state.selectedFuelTypes.contains(FuelType.all)) {
      return stations;
    }

    return stations.where((FuelStation station) {
      if (state.selectedFuelTypes.contains(FuelType.diesel) &&
          station.diesel != null) {
        return true;
      }
      if (state.selectedFuelTypes.contains(FuelType.e5) && station.e5 != null) {
        return true;
      }
      if (state.selectedFuelTypes.contains(FuelType.e10) &&
          station.e10 != null) {
        return true;
      }
      return false;
    }).toList();
  }

  void onRadiusChanged(double radius) {
    if (state is FuelStationLoaded) {
      emit(state.copyWith(searchRadius: radius));
    }
  }

  void onFuelTypeSelected(FuelType type, bool selected) {
    final List<FuelType> _selectedFuelTypes =
        List<FuelType>.of(state.selectedFuelTypes);
    // Wenn "Alle" ausgewählt wird, leere die anderen Filter
    if (type == FuelType.all && selected) {
      _selectedFuelTypes
        ..clear()
        ..add(FuelType.all);
    } else if (selected) {
      // Wenn ein spezifischer Typ hinzugefügt wird, entferne "Alle"
      _selectedFuelTypes
        ..remove(FuelType.all)
        ..add(type);
    } else {
      // Wenn ein Typ entfernt wird
      _selectedFuelTypes.remove(type);
      // Wenn kein Filter mehr ausgewählt ist, wähle "Alle"
      if (_selectedFuelTypes.isEmpty) {
        _selectedFuelTypes.add(FuelType.all);
      }
    }

    emit(state.copyWith(selectedFuelTypes: _selectedFuelTypes.toSet()));
  }
}
