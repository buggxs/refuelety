part of 'manage_geo_cubit.dart';

@freezed
class ManageGeoState with _$ManageGeoState {
  const factory ManageGeoState.initial() = _Initial;
  const factory ManageGeoState.loading() = _Loading;
  const factory ManageGeoState.success({
    Stream<Position>? position,
    Position? currentPosition,
  }) = ManageGeoSuccessState;
  const factory ManageGeoState.permissionDenied() = _PermissionDenied;
  const factory ManageGeoState.error(String message) = _Error;
}
