import 'package:freezed_annotation/freezed_annotation.dart';

part 'fuel_station_page.freezed.dart';
part 'fuel_station_page.g.dart';

@Freezed(genericArgumentFactories: true)
class FuelStationPage<T> with _$FuelStationPage<T> {
  const factory FuelStationPage({
    String? status,
    String? message,
    required bool ok,
    List<T>? stations,
  }) = _FuelStationPage<T>;

  factory FuelStationPage.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, Object?>) fromJsonT,
  ) =>
      _$FuelStationPageFromJson<T>(
        json,
        (Object? json) => fromJsonT(json as Map<String, Object?>),
      );
}
