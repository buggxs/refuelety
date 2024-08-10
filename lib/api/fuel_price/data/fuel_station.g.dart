// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FuelStationImpl _$$FuelStationImplFromJson(Map<String, dynamic> json) =>
    _$FuelStationImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      brand: json['brand'] as String?,
      street: json['street'] as String?,
      place: json['place'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      dist: (json['dist'] as num?)?.toDouble(),
      diesel: (json['diesel'] as num?)?.toDouble(),
      e5: (json['e5'] as num?)?.toDouble(),
      e10: (json['e10'] as num?)?.toDouble(),
      isOpen: json['isOpen'] as bool?,
      houseNumber: json['houseNumber'] as String?,
      postCode: (json['postCode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$FuelStationImplToJson(_$FuelStationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'brand': instance.brand,
      'street': instance.street,
      'place': instance.place,
      'lat': instance.lat,
      'lng': instance.lng,
      'dist': instance.dist,
      'diesel': instance.diesel,
      'e5': instance.e5,
      'e10': instance.e10,
      'isOpen': instance.isOpen,
      'houseNumber': instance.houseNumber,
      'postCode': instance.postCode,
    };
