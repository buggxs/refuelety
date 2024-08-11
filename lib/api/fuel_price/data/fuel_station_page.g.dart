// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_station_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FuelStationPageImpl<T> _$$FuelStationPageImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$FuelStationPageImpl<T>(
      status: json['status'] as String?,
      message: json['message'] as String?,
      ok: json['ok'] as bool,
      stations: (json['stations'] as List<dynamic>?)?.map(fromJsonT).toList(),
    );

Map<String, dynamic> _$$FuelStationPageImplToJson<T>(
  _$FuelStationPageImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'ok': instance.ok,
      'stations': instance.stations?.map(toJsonT).toList(),
    };
