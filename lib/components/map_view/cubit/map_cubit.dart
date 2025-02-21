import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:refuelety/api/api.dart';
import 'package:refuelety/misc/widgets/custom_marker_snippet.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit(this._fuelService) : super(MapState());
  final FuelService _fuelService;

  void selectStation(FuelStation? station, [LatLng? location]) {
    emit(state.copyWith(
      selectedStation: station,
      selectedLocation: location,
    ),);
  }

  Future<void> loadFuelStations({
    required LatLng location,
    double radius = 5.0,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final FuelStationPage<FuelStation> response =
          await _fuelService.getFuelStationInRadius(
        lat: location.latitude,
        lng: location.longitude,
        radius: radius,
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
