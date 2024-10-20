import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:refuelety/api/api.dart';
import 'package:refuelety/core/app_service_locator.dart';

part 'manage_geo_cubit.freezed.dart';
part 'manage_geo_state.dart';

class ManageGeoCubit extends Cubit<ManageGeoState> {
  ManageGeoCubit() : super(const ManageGeoState.initial());

  Future<void> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    final bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      permission = await Geolocator.requestPermission();
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      emit(const ManageGeoState.permissionDenied());
    }
  }

  Future<void> fetchPositionStream() async {
    emit(const ManageGeoState.loading());
    try {
      final Stream<Position> positionStream =
          app<GeoService>().getPositionStream();
      emit(ManageGeoState.success(positionStream));
    } on Exception catch (e) {
      emit(ManageGeoState.error(e.toString()));
    }
  }
}
