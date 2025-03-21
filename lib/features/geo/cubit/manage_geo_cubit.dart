import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:refuelety/api/api.dart';
import 'package:refuelety/core/app_service_locator.dart';
import 'package:refuelety/misc/logger.dart';

part 'manage_geo_cubit.freezed.dart';
part 'manage_geo_state.dart';

class ManageGeoCubit extends Cubit<ManageGeoState> with LoggerMixin {
  ManageGeoCubit() : super(const ManageGeoState.initial());

  Future<void> getCurrentPosition() async {
    final bool hasPermission = await app<GeoService>().checkPermission();
    if (!hasPermission) {
      log.warning('Missing permission for fetching user position');
      emit(const ManageGeoState.permissionDenied());
      return;
    }
    emit(const ManageGeoState.loading());
    try {
      final Position position = await app<GeoService>().getPosition();
      log.info('Current user position found!');
      emit(ManageGeoState.success(currentPosition: position));
    } on Exception catch (e) {
      emit(ManageGeoState.error(e.toString()));
    }
  }

  Future<void> fetchPositionStream() async {
    final bool hasPermission = await app<GeoService>().checkPermission();
    if (!hasPermission) {
      emit(const ManageGeoState.permissionDenied());
      return;
    }
    emit(const ManageGeoState.loading());
    try {
      final Stream<Position> positionStream =
          app<GeoService>().getPositionStream();
      emit(ManageGeoState.success(position: positionStream));
    } on Exception catch (e) {
      emit(ManageGeoState.error(e.toString()));
    }
  }
}
