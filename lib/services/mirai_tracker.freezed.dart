// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mirai_tracker.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Location _$LocationFromJson(Map<String, dynamic> json) {
  return _Location.fromJson(json);
}

/// @nodoc
mixin _$Location {
  double get lon => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get rad => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationCopyWith<Location> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationCopyWith<$Res> {
  factory $LocationCopyWith(Location value, $Res Function(Location) then) =
      _$LocationCopyWithImpl<$Res, Location>;
  @useResult
  $Res call({double lon, double lat, double rad});
}

/// @nodoc
class _$LocationCopyWithImpl<$Res, $Val extends Location>
    implements $LocationCopyWith<$Res> {
  _$LocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lon = null,
    Object? lat = null,
    Object? rad = null,
  }) {
    return _then(_value.copyWith(
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      rad: null == rad
          ? _value.rad
          : rad // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocationCopyWith<$Res> implements $LocationCopyWith<$Res> {
  factory _$$_LocationCopyWith(
          _$_Location value, $Res Function(_$_Location) then) =
      __$$_LocationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double lon, double lat, double rad});
}

/// @nodoc
class __$$_LocationCopyWithImpl<$Res>
    extends _$LocationCopyWithImpl<$Res, _$_Location>
    implements _$$_LocationCopyWith<$Res> {
  __$$_LocationCopyWithImpl(
      _$_Location _value, $Res Function(_$_Location) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lon = null,
    Object? lat = null,
    Object? rad = null,
  }) {
    return _then(_$_Location(
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      rad: null == rad
          ? _value.rad
          : rad // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Location extends _Location {
  _$_Location({required this.lon, required this.lat, required this.rad})
      : super._();

  factory _$_Location.fromJson(Map<String, dynamic> json) =>
      _$$_LocationFromJson(json);

  @override
  final double lon;
  @override
  final double lat;
  @override
  final double rad;

  @override
  String toString() {
    return 'Location(lon: $lon, lat: $lat, rad: $rad)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Location &&
            (identical(other.lon, lon) || other.lon == lon) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.rad, rad) || other.rad == rad));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, lon, lat, rad);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocationCopyWith<_$_Location> get copyWith =>
      __$$_LocationCopyWithImpl<_$_Location>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocationToJson(
      this,
    );
  }
}

abstract class _Location extends Location {
  factory _Location(
      {required final double lon,
      required final double lat,
      required final double rad}) = _$_Location;
  _Location._() : super._();

  factory _Location.fromJson(Map<String, dynamic> json) = _$_Location.fromJson;

  @override
  double get lon;
  @override
  double get lat;
  @override
  double get rad;
  @override
  @JsonKey(ignore: true)
  _$$_LocationCopyWith<_$_Location> get copyWith =>
      throw _privateConstructorUsedError;
}

HumTempMeasure _$HumTempMeasureFromJson(Map<String, dynamic> json) {
  return _HumTempMeasure.fromJson(json);
}

/// @nodoc
mixin _$HumTempMeasure {
  DateTime get timestamp => throw _privateConstructorUsedError;
  double? get temp => throw _privateConstructorUsedError;
  double? get hum => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HumTempMeasureCopyWith<HumTempMeasure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HumTempMeasureCopyWith<$Res> {
  factory $HumTempMeasureCopyWith(
          HumTempMeasure value, $Res Function(HumTempMeasure) then) =
      _$HumTempMeasureCopyWithImpl<$Res, HumTempMeasure>;
  @useResult
  $Res call({DateTime timestamp, double? temp, double? hum});
}

/// @nodoc
class _$HumTempMeasureCopyWithImpl<$Res, $Val extends HumTempMeasure>
    implements $HumTempMeasureCopyWith<$Res> {
  _$HumTempMeasureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? temp = freezed,
    Object? hum = freezed,
  }) {
    return _then(_value.copyWith(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      temp: freezed == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as double?,
      hum: freezed == hum
          ? _value.hum
          : hum // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HumTempMeasureCopyWith<$Res>
    implements $HumTempMeasureCopyWith<$Res> {
  factory _$$_HumTempMeasureCopyWith(
          _$_HumTempMeasure value, $Res Function(_$_HumTempMeasure) then) =
      __$$_HumTempMeasureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime timestamp, double? temp, double? hum});
}

/// @nodoc
class __$$_HumTempMeasureCopyWithImpl<$Res>
    extends _$HumTempMeasureCopyWithImpl<$Res, _$_HumTempMeasure>
    implements _$$_HumTempMeasureCopyWith<$Res> {
  __$$_HumTempMeasureCopyWithImpl(
      _$_HumTempMeasure _value, $Res Function(_$_HumTempMeasure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? temp = freezed,
    Object? hum = freezed,
  }) {
    return _then(_$_HumTempMeasure(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      temp: freezed == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as double?,
      hum: freezed == hum
          ? _value.hum
          : hum // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HumTempMeasure implements _HumTempMeasure {
  _$_HumTempMeasure({required this.timestamp, this.temp, this.hum});

  factory _$_HumTempMeasure.fromJson(Map<String, dynamic> json) =>
      _$$_HumTempMeasureFromJson(json);

  @override
  final DateTime timestamp;
  @override
  final double? temp;
  @override
  final double? hum;

  @override
  String toString() {
    return 'HumTempMeasure(timestamp: $timestamp, temp: $temp, hum: $hum)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HumTempMeasure &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.temp, temp) || other.temp == temp) &&
            (identical(other.hum, hum) || other.hum == hum));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, timestamp, temp, hum);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HumTempMeasureCopyWith<_$_HumTempMeasure> get copyWith =>
      __$$_HumTempMeasureCopyWithImpl<_$_HumTempMeasure>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HumTempMeasureToJson(
      this,
    );
  }
}

abstract class _HumTempMeasure implements HumTempMeasure {
  factory _HumTempMeasure(
      {required final DateTime timestamp,
      final double? temp,
      final double? hum}) = _$_HumTempMeasure;

  factory _HumTempMeasure.fromJson(Map<String, dynamic> json) =
      _$_HumTempMeasure.fromJson;

  @override
  DateTime get timestamp;
  @override
  double? get temp;
  @override
  double? get hum;
  @override
  @JsonKey(ignore: true)
  _$$_HumTempMeasureCopyWith<_$_HumTempMeasure> get copyWith =>
      throw _privateConstructorUsedError;
}

LocationInfo _$LocationInfoFromJson(Map<String, dynamic> json) {
  return _LocationInfo.fromJson(json);
}

/// @nodoc
mixin _$LocationInfo {
  DateTime get timestamp => throw _privateConstructorUsedError;
  Location get loc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationInfoCopyWith<LocationInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationInfoCopyWith<$Res> {
  factory $LocationInfoCopyWith(
          LocationInfo value, $Res Function(LocationInfo) then) =
      _$LocationInfoCopyWithImpl<$Res, LocationInfo>;
  @useResult
  $Res call({DateTime timestamp, Location loc});

  $LocationCopyWith<$Res> get loc;
}

/// @nodoc
class _$LocationInfoCopyWithImpl<$Res, $Val extends LocationInfo>
    implements $LocationInfoCopyWith<$Res> {
  _$LocationInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? loc = null,
  }) {
    return _then(_value.copyWith(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      loc: null == loc
          ? _value.loc
          : loc // ignore: cast_nullable_to_non_nullable
              as Location,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res> get loc {
    return $LocationCopyWith<$Res>(_value.loc, (value) {
      return _then(_value.copyWith(loc: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_LocationInfoCopyWith<$Res>
    implements $LocationInfoCopyWith<$Res> {
  factory _$$_LocationInfoCopyWith(
          _$_LocationInfo value, $Res Function(_$_LocationInfo) then) =
      __$$_LocationInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime timestamp, Location loc});

  @override
  $LocationCopyWith<$Res> get loc;
}

/// @nodoc
class __$$_LocationInfoCopyWithImpl<$Res>
    extends _$LocationInfoCopyWithImpl<$Res, _$_LocationInfo>
    implements _$$_LocationInfoCopyWith<$Res> {
  __$$_LocationInfoCopyWithImpl(
      _$_LocationInfo _value, $Res Function(_$_LocationInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? loc = null,
  }) {
    return _then(_$_LocationInfo(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      loc: null == loc
          ? _value.loc
          : loc // ignore: cast_nullable_to_non_nullable
              as Location,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LocationInfo implements _LocationInfo {
  _$_LocationInfo({required this.timestamp, required this.loc});

  factory _$_LocationInfo.fromJson(Map<String, dynamic> json) =>
      _$$_LocationInfoFromJson(json);

  @override
  final DateTime timestamp;
  @override
  final Location loc;

  @override
  String toString() {
    return 'LocationInfo(timestamp: $timestamp, loc: $loc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocationInfo &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.loc, loc) || other.loc == loc));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, timestamp, loc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocationInfoCopyWith<_$_LocationInfo> get copyWith =>
      __$$_LocationInfoCopyWithImpl<_$_LocationInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocationInfoToJson(
      this,
    );
  }
}

abstract class _LocationInfo implements LocationInfo {
  factory _LocationInfo(
      {required final DateTime timestamp,
      required final Location loc}) = _$_LocationInfo;

  factory _LocationInfo.fromJson(Map<String, dynamic> json) =
      _$_LocationInfo.fromJson;

  @override
  DateTime get timestamp;
  @override
  Location get loc;
  @override
  @JsonKey(ignore: true)
  _$$_LocationInfoCopyWith<_$_LocationInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
