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

_$_Record _$$_RecordFromJson(Map<String, dynamic> json) => _$_Record(
      timestamp: DateTime.parse(json['timestamp'] as String),
      recieved: DateTime.parse(json['recieved'] as String),
      temp: (json['temp'] as num?)?.toDouble(),
      hum: (json['hum'] as num?)?.toDouble(),
      bat: (json['bat'] as num?)?.toDouble(),
      loc: json['loc'] == null
          ? null
          : Location.fromJson(json['loc'] as Map<String, dynamic>),
      gps: json['gps'] == null
          ? null
          : Location.fromJson(json['gps'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_RecordToJson(_$_Record instance) => <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'recieved': instance.recieved.toIso8601String(),
      'temp': instance.temp,
      'hum': instance.hum,
      'bat': instance.bat,
      'loc': instance.loc,
      'gps': instance.gps,
    };
