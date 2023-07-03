import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';

import '../utils/interval_cache.dart' as ic;

part 'mirai_tracker.freezed.dart';
part 'mirai_tracker.g.dart';

@freezed
class Location with _$Location {
  const Location._();
  factory Location({
    required double lon,
    required double lat,
    required double rad,
  }) = _Location;

  LatLng get asLatLng => LatLng(lat, lon);

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@freezed
class HumTempMeasure with _$HumTempMeasure implements ic.DataPoint {
  const HumTempMeasure._();
  factory HumTempMeasure({
    required DateTime timestamp,
    double? temp,
    double? hum,
  }) = _HumTempMeasure;

  @override
  DateTime get getTimestamp => timestamp;

  factory HumTempMeasure.fromJson(Map<String, dynamic> json) =>
      _$HumTempMeasureFromJson(json);
}

@freezed
class LocationInfo with _$LocationInfo {
  factory LocationInfo({
    required DateTime timestamp,
    required Location loc,
  }) = _LocationInfo;

  factory LocationInfo.fromJson(Map<String, dynamic> json) =>
      _$LocationInfoFromJson(json);
}

class MiraiTracker {
  static final Dio _dio = Dio();
  final String deviceId;

  static const String basicUrl = 'https://mirai-tracker2.markovvn1.ru';

  const MiraiTracker(this.deviceId);

  Future<List<HumTempMeasure>> getHumTempChart(
    DateTime start,
    DateTime stop, {
    bool byReceive = false,
  }) async {
    final response = await _dio.get(
      '$basicUrl/hum_temp_chart',
      queryParameters: {
        'device_id': deviceId,
        'by_recieve': byReceive,
        'start': start.toUtc().toString(),
        'stop': stop.toUtc().toString(),
      },
      options: Options(
        headers: {
          'Access-Control-Allow-Origin': '*',
        },
      ),
    );
    return List.generate(
      response.data.length,
      (index) {
        final tmp = HumTempMeasure.fromJson(response.data[index]);
        return tmp.copyWith(
          timestamp: tmp.timestamp.copyWith(isUtc: true).toLocal(),
        );
      },
    );
  }

  Future<LocationInfo> getNearestLocationByTime(DateTime timestamp) async {
    final response = await _dio.get(
      '$basicUrl/nearest_location_by_time',
      queryParameters: {
        'device_id': deviceId,
        'timestamp': timestamp.toUtc().toString(),
      },
      options: Options(
        headers: {
          'Access-Control-Allow-Origin': '*',
        },
      ),
    );
    final tmp = LocationInfo.fromJson(response.data);
    return tmp.copyWith(
      timestamp: tmp.timestamp.copyWith(isUtc: true).toLocal(),
    );
  }
}
