import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';

part 'mirai_tracker.freezed.dart';
part 'mirai_tracker.g.dart';

@freezed
class Location with _$Location {
  factory Location({
    required double lon,
    required double lat,
    required double rad,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@freezed
class HumTempMeasure with _$HumTempMeasure {
  factory HumTempMeasure({
    required DateTime timestamp,
    double? temp,
    double? hum,
  }) = _HumTempMeasure;

  factory HumTempMeasure.fromJson(Map<String, dynamic> json) =>
      _$HumTempMeasureFromJson(json);
}

class MiraiTracker {
  static final Dio _dio = Dio();
  final String deviceId;

  const MiraiTracker(this.deviceId);

  Future<List<HumTempMeasure>> getHumTempChart(
    DateTime start,
    DateTime stop, {
    bool byReceive = false,
  }) async {
    final response = await _dio.get(
      'https://mirai-tracker2.markovvn1.ru/hum_temp_chart',
      queryParameters: {
        'device_id': deviceId,
        'by_recieve': byReceive,
        'start': start.toString(),
        'stop': stop.toString(),
      },
      options: Options(
        headers: {
          'Access-Control-Allow-Origin': '*',
        },
      ),
    );
    return List.generate(
      response.data.length,
      (index) => HumTempMeasure.fromJson(response.data[index]),
    );
  }
}
