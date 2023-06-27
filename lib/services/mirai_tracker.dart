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
class Record with _$Record {
  factory Record({
    required DateTime timestamp,
    required DateTime recieved,
    double? temp,
    double? hum,
    double? bat,
    Location? loc,
    Location? gps,
  }) = _Record;

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
}

class MiraiTracker {
  static final Dio _dio = Dio();
  final String deviceId;

  const MiraiTracker(this.deviceId);

  Future<List<Record>> getRecords(
    DateTime start,
    DateTime stop, {
    bool byReceive = false,
  }) async {
    final response = await _dio.get(
      'https://mirai-tracker2.markovvn1.ru/records',
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
      (index) => Record.fromJson(response.data[index]),
    );
  }
}
