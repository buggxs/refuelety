// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fuel_station_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FuelStationPage<T> _$FuelStationPageFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _FuelStationPage<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$FuelStationPage<T> {
  String? get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  bool get ok => throw _privateConstructorUsedError;
  List<T>? get stations => throw _privateConstructorUsedError;

  /// Serializes this FuelStationPage to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of FuelStationPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FuelStationPageCopyWith<T, FuelStationPage<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FuelStationPageCopyWith<T, $Res> {
  factory $FuelStationPageCopyWith(
          FuelStationPage<T> value, $Res Function(FuelStationPage<T>) then) =
      _$FuelStationPageCopyWithImpl<T, $Res, FuelStationPage<T>>;
  @useResult
  $Res call({String? status, String? message, bool ok, List<T>? stations});
}

/// @nodoc
class _$FuelStationPageCopyWithImpl<T, $Res, $Val extends FuelStationPage<T>>
    implements $FuelStationPageCopyWith<T, $Res> {
  _$FuelStationPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FuelStationPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? message = freezed,
    Object? ok = null,
    Object? stations = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      ok: null == ok
          ? _value.ok
          : ok // ignore: cast_nullable_to_non_nullable
              as bool,
      stations: freezed == stations
          ? _value.stations
          : stations // ignore: cast_nullable_to_non_nullable
              as List<T>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FuelStationPageImplCopyWith<T, $Res>
    implements $FuelStationPageCopyWith<T, $Res> {
  factory _$$FuelStationPageImplCopyWith(_$FuelStationPageImpl<T> value,
          $Res Function(_$FuelStationPageImpl<T>) then) =
      __$$FuelStationPageImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({String? status, String? message, bool ok, List<T>? stations});
}

/// @nodoc
class __$$FuelStationPageImplCopyWithImpl<T, $Res>
    extends _$FuelStationPageCopyWithImpl<T, $Res, _$FuelStationPageImpl<T>>
    implements _$$FuelStationPageImplCopyWith<T, $Res> {
  __$$FuelStationPageImplCopyWithImpl(_$FuelStationPageImpl<T> _value,
      $Res Function(_$FuelStationPageImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of FuelStationPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? message = freezed,
    Object? ok = null,
    Object? stations = freezed,
  }) {
    return _then(_$FuelStationPageImpl<T>(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      ok: null == ok
          ? _value.ok
          : ok // ignore: cast_nullable_to_non_nullable
              as bool,
      stations: freezed == stations
          ? _value._stations
          : stations // ignore: cast_nullable_to_non_nullable
              as List<T>?,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$FuelStationPageImpl<T> implements _FuelStationPage<T> {
  const _$FuelStationPageImpl(
      {this.status, this.message, required this.ok, final List<T>? stations})
      : _stations = stations;

  factory _$FuelStationPageImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$FuelStationPageImplFromJson(json, fromJsonT);

  @override
  final String? status;
  @override
  final String? message;
  @override
  final bool ok;
  final List<T>? _stations;
  @override
  List<T>? get stations {
    final value = _stations;
    if (value == null) return null;
    if (_stations is EqualUnmodifiableListView) return _stations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'FuelStationPage<$T>(status: $status, message: $message, ok: $ok, stations: $stations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FuelStationPageImpl<T> &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.ok, ok) || other.ok == ok) &&
            const DeepCollectionEquality().equals(other._stations, _stations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, ok,
      const DeepCollectionEquality().hash(_stations));

  /// Create a copy of FuelStationPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FuelStationPageImplCopyWith<T, _$FuelStationPageImpl<T>> get copyWith =>
      __$$FuelStationPageImplCopyWithImpl<T, _$FuelStationPageImpl<T>>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$FuelStationPageImplToJson<T>(this, toJsonT);
  }
}

abstract class _FuelStationPage<T> implements FuelStationPage<T> {
  const factory _FuelStationPage(
      {final String? status,
      final String? message,
      required final bool ok,
      final List<T>? stations}) = _$FuelStationPageImpl<T>;

  factory _FuelStationPage.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$FuelStationPageImpl<T>.fromJson;

  @override
  String? get status;
  @override
  String? get message;
  @override
  bool get ok;
  @override
  List<T>? get stations;

  /// Create a copy of FuelStationPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FuelStationPageImplCopyWith<T, _$FuelStationPageImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
