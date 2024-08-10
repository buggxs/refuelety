import 'package:freezed_annotation/freezed_annotation.dart';

part 'fuel_station.freezed.dart';
part 'fuel_station.g.dart';

@freezed
class FuelStation with _$FuelStation {
  factory FuelStation({
    String? id,
    String? name,
    String? brand,
    String? street,
    String? place,
    double? lat,
    double? lng,
    double? dist,
    double? diesel,
    double? e5,
    double? e10,
    bool? isOpen,
    String? houseNumber,
    int? postCode,
  }) = _FuelStation;

  factory FuelStation.fromJson(Map<String, Object?> json) =>
      _$FuelStationFromJson(json);
}
