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
class _$_Location implements _Location {
  _$_Location({required this.lon, required this.lat, required this.rad});

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

abstract class _Location implements Location {
  factory _Location(
      {required final double lon,
      required final double lat,
      required final double rad}) = _$_Location;

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

Record _$RecordFromJson(Map<String, dynamic> json) {
  return _Record.fromJson(json);
}

/// @nodoc
mixin _$Record {
  DateTime get timestamp => throw _privateConstructorUsedError;
  DateTime get recieved => throw _privateConstructorUsedError;
  double? get temp => throw _privateConstructorUsedError;
  double? get hum => throw _privateConstructorUsedError;
  double? get bat => throw _privateConstructorUsedError;
  Location? get loc => throw _privateConstructorUsedError;
  Location? get gps => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecordCopyWith<Record> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordCopyWith<$Res> {
  factory $RecordCopyWith(Record value, $Res Function(Record) then) =
      _$RecordCopyWithImpl<$Res, Record>;
  @useResult
  $Res call(
      {DateTime timestamp,
      DateTime recieved,
      double? temp,
      double? hum,
      double? bat,
      Location? loc,
      Location? gps});

  $LocationCopyWith<$Res>? get loc;
  $LocationCopyWith<$Res>? get gps;
}

/// @nodoc
class _$RecordCopyWithImpl<$Res, $Val extends Record>
    implements $RecordCopyWith<$Res> {
  _$RecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? recieved = null,
    Object? temp = freezed,
    Object? hum = freezed,
    Object? bat = freezed,
    Object? loc = freezed,
    Object? gps = freezed,
  }) {
    return _then(_value.copyWith(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recieved: null == recieved
          ? _value.recieved
          : recieved // ignore: cast_nullable_to_non_nullable
              as DateTime,
      temp: freezed == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as double?,
      hum: freezed == hum
          ? _value.hum
          : hum // ignore: cast_nullable_to_non_nullable
              as double?,
      bat: freezed == bat
          ? _value.bat
          : bat // ignore: cast_nullable_to_non_nullable
              as double?,
      loc: freezed == loc
          ? _value.loc
          : loc // ignore: cast_nullable_to_non_nullable
              as Location?,
      gps: freezed == gps
          ? _value.gps
          : gps // ignore: cast_nullable_to_non_nullable
              as Location?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res>? get loc {
    if (_value.loc == null) {
      return null;
    }

    return $LocationCopyWith<$Res>(_value.loc!, (value) {
      return _then(_value.copyWith(loc: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res>? get gps {
    if (_value.gps == null) {
      return null;
    }

    return $LocationCopyWith<$Res>(_value.gps!, (value) {
      return _then(_value.copyWith(gps: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RecordCopyWith<$Res> implements $RecordCopyWith<$Res> {
  factory _$$_RecordCopyWith(_$_Record value, $Res Function(_$_Record) then) =
      __$$_RecordCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime timestamp,
      DateTime recieved,
      double? temp,
      double? hum,
      double? bat,
      Location? loc,
      Location? gps});

  @override
  $LocationCopyWith<$Res>? get loc;
  @override
  $LocationCopyWith<$Res>? get gps;
}

/// @nodoc
class __$$_RecordCopyWithImpl<$Res>
    extends _$RecordCopyWithImpl<$Res, _$_Record>
    implements _$$_RecordCopyWith<$Res> {
  __$$_RecordCopyWithImpl(_$_Record _value, $Res Function(_$_Record) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? recieved = null,
    Object? temp = freezed,
    Object? hum = freezed,
    Object? bat = freezed,
    Object? loc = freezed,
    Object? gps = freezed,
  }) {
    return _then(_$_Record(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recieved: null == recieved
          ? _value.recieved
          : recieved // ignore: cast_nullable_to_non_nullable
              as DateTime,
      temp: freezed == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as double?,
      hum: freezed == hum
          ? _value.hum
          : hum // ignore: cast_nullable_to_non_nullable
              as double?,
      bat: freezed == bat
          ? _value.bat
          : bat // ignore: cast_nullable_to_non_nullable
              as double?,
      loc: freezed == loc
          ? _value.loc
          : loc // ignore: cast_nullable_to_non_nullable
              as Location?,
      gps: freezed == gps
          ? _value.gps
          : gps // ignore: cast_nullable_to_non_nullable
              as Location?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Record implements _Record {
  _$_Record(
      {required this.timestamp,
      required this.recieved,
      this.temp,
      this.hum,
      this.bat,
      this.loc,
      this.gps});

  factory _$_Record.fromJson(Map<String, dynamic> json) =>
      _$$_RecordFromJson(json);

  @override
  final DateTime timestamp;
  @override
  final DateTime recieved;
  @override
  final double? temp;
  @override
  final double? hum;
  @override
  final double? bat;
  @override
  final Location? loc;
  @override
  final Location? gps;

  @override
  String toString() {
    return 'Record(timestamp: $timestamp, recieved: $recieved, temp: $temp, hum: $hum, bat: $bat, loc: $loc, gps: $gps)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Record &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.recieved, recieved) ||
                other.recieved == recieved) &&
            (identical(other.temp, temp) || other.temp == temp) &&
            (identical(other.hum, hum) || other.hum == hum) &&
            (identical(other.bat, bat) || other.bat == bat) &&
            (identical(other.loc, loc) || other.loc == loc) &&
            (identical(other.gps, gps) || other.gps == gps));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, timestamp, recieved, temp, hum, bat, loc, gps);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecordCopyWith<_$_Record> get copyWith =>
      __$$_RecordCopyWithImpl<_$_Record>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecordToJson(
      this,
    );
  }
}

abstract class _Record implements Record {
  factory _Record(
      {required final DateTime timestamp,
      required final DateTime recieved,
      final double? temp,
      final double? hum,
      final double? bat,
      final Location? loc,
      final Location? gps}) = _$_Record;

  factory _Record.fromJson(Map<String, dynamic> json) = _$_Record.fromJson;

  @override
  DateTime get timestamp;
  @override
  DateTime get recieved;
  @override
  double? get temp;
  @override
  double? get hum;
  @override
  double? get bat;
  @override
  Location? get loc;
  @override
  Location? get gps;
  @override
  @JsonKey(ignore: true)
  _$$_RecordCopyWith<_$_Record> get copyWith =>
      throw _privateConstructorUsedError;
}
