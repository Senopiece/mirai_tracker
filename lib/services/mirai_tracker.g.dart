// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mirai_tracker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Location _$$_LocationFromJson(Map<String, dynamic> json) => _$_Location(
      lon: (json['lon'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
      rad: (json['rad'] as num).toDouble(),
    );

Map<String, dynamic> _$$_LocationToJson(_$_Location instance) =>
    <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
      'rad': instance.rad,
    };

_$_HumTempMeasure _$$_HumTempMeasureFromJson(Map<String, dynamic> json) =>
    _$_HumTempMeasure(
      timestamp: DateTime.parse(json['timestamp'] as String),
      temp: (json['temp'] as num?)?.toDouble(),
      hum: (json['hum'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_HumTempMeasureToJson(_$_HumTempMeasure instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'temp': instance.temp,
      'hum': instance.hum,
    };
