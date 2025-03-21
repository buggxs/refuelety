import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:refuelety/api/api.dart';
import 'package:refuelety/core/app_service_locator.dart';
import 'package:refuelety/features/geo/cubit/manage_geo_cubit.dart';
import 'package:refuelety/misc/logger.dart';
import 'package:refuelety/misc/widgets/custom_marker_snippet.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> with LoggerMixin {
  MapCubit({
    required this.geoCubit,
  }) : super(MapState());

  final FuelService _fuelService = app<FuelService>();
  final ManageGeoCubit geoCubit;

  void updateUserPosition(
    Stream<Position>? userPositionStream,
    Position? userPosition,
  ) {
    if (userPosition?.latitude == null || userPosition?.longitude == null) {
      log.warning('User position could not be fetched!');
      return;
    }

    log.info(
      'User position found: lat(${userPosition!.latitude}) '
      'lng(${userPosition.longitude})',
    );

    emit(
      state.copyWith(
        userPosition: LatLng(
          userPosition.latitude,
          userPosition.longitude,
        ),
      ),
    );
  }

  void selectStation(FuelStation? station, [LatLng? location]) {
    emit(
      state.copyWith(
        selectedStation: station,
        selectedLocation: location,
      ),
    );
  }

  Future<void> loadFuelStations({
    required LatLng location,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final FuelStationPage<FuelStation> response =
          await _fuelService.getFuelStationInRadius(
        lat: location.latitude,
        lng: location.longitude,
        radius: 20,
      );

      if (response.ok && response.stations != null) {
        final List<Marker> markers = await Future.wait(
          response.stations!.map((FuelStation station) async {
            // Erstelle custom marker für jede Station
            final BitmapDescriptor customMarker =
                await CustomMarkerGenerator().createCustomMarker(station);

            return Marker(
              markerId: MarkerId(station.id ?? 'unknown'),
              position: LatLng(
                station.lat ?? 0.0,
                station.lng ?? 0.0,
              ),
              icon: customMarker,
              anchor: const Offset(
                0.5,
                1,
              ), // Setzt den Ankerpunkt an die untere Mitte
              onTap: () {
                selectStation(
                  station,
                  LatLng(station.lat ?? 0.0, station.lng ?? 0.0),
                );
              },
            );
          }),
        );

        emit(
          state.copyWith(
            isLoading: false,
            markers: markers.toSet(),
            stations: response.stations,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            error: response.message ?? 'Fehler beim Laden der Tankstellen',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: e.toString(),
        ),
      );
    }
  }
}
