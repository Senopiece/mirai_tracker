import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'services/mirai_tracker.dart';
import 'utils/accurate_poller.dart';

class _ChartData {
  final DateTime time;
  final double? temperature;
  final double? humidity;

  _ChartData({
    required this.time,
    this.temperature,
    this.humidity,
  });
}

class _InternalChart extends StatelessWidget {
  final List<_ChartData> data;

  const _InternalChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
      child: charts.TimeSeriesChart(
        [
          charts.Series<_ChartData, DateTime>(
            id: 'Temperature',
            overlaySeries: true,
            colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
            domainFn: (_ChartData data, _) => data.time,
            measureFn: (_ChartData data, _) => data.temperature,
            data: data,
          ),
          charts.Series<_ChartData, DateTime>(
            id: 'Humidity',
            overlaySeries: true,
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            domainFn: (_ChartData data, _) => data.time,
            measureFn: (_ChartData data, _) => data.humidity,
            data: data,
          ),
        ],
        animate: false,
        behaviors: [
          // charts.PanAndZoomBehavior(),
        ],
        dateTimeFactory: const charts.LocalDateTimeFactory(),
        primaryMeasureAxis: const charts.NumericAxisSpec(
          tickProviderSpec: charts.BasicNumericTickProviderSpec(
            dataIsInWholeNumbers: true,
            desiredTickCount: 5,
          ),
        ),
        domainAxis: const charts.DateTimeAxisSpec(
          tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
            day: charts.TimeFormatterSpec(
              format: 'd',
              transitionFormat: 'MM/dd/yyyy',
            ),
          ),
        ),
      ),
    );
  }
}

// class _InternalChart extends StatelessWidget {
//   final List<_ChartData> data;

//   const _InternalChart({
//     Key? key,
//     required this.data,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
//         child: SfCartesianChart(
//           // zoomPanBehavior: ZoomPanBehavior(enablePinching: true),
//           primaryXAxis: DateTimeAxis(
//             dateFormat: DateFormat('MM/dd/yyyy'),
//             intervalType: DateTimeIntervalType.days,
//           ),
//           primaryYAxis: NumericAxis(
//             minimum: -10,
//             maximum: 60,
//             interval: 20,
//           ),
//           series: <ChartSeries>[
//             LineSeries<_ChartData, DateTime>(
//               dataSource: data,
//               xValueMapper: (_ChartData data, _) => data.time,
//               yValueMapper: (_ChartData data, _) => data.temperature,
//               name: 'Temperature',
//               color: Colors.deepOrange,
//             ),
//             LineSeries<_ChartData, DateTime>(
//               dataSource: data,
//               xValueMapper: (_ChartData data, _) => data.time,
//               yValueMapper: (_ChartData data, _) => data.humidity,
//               name: 'Humidity',
//               color: Colors.blue,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// TODO: zooming
class HumidityAndTemperatureChart extends StatefulWidget {
  final MiraiTracker tracker;

  const HumidityAndTemperatureChart({
    Key? key,
    required this.tracker,
  }) : super(key: key);

  @override
  State<HumidityAndTemperatureChart> createState() =>
      _HumidityAndTemperatureChartState();
}

class _HumidityAndTemperatureChartState
    extends State<HumidityAndTemperatureChart> with TickerProviderStateMixin {
  var mostRight = DateTime.now();
  DateTime get mostLeft => mostRight.subtract(const Duration(days: 1));

  late AnimationController _acontroller;
  late Animation<int> _frictionAnimation;

  late AccuratePoller<List<Record>> poller;
  late Timer actualizator;

  void _createPoller() {
    poller = AccuratePoller<List<Record>>(
      const Duration(seconds: 1),
      () async {
        return await widget.tracker.getRecords(
          mostLeft,
          mostRight,
        );
      },
    );

    actualizator = Timer.periodic(
      const Duration(seconds: 10),
      (_) {
        final gap = DateTime.now().difference(mostRight);
        if (const Duration(minutes: 3) < gap &&
            gap < const Duration(minutes: 7)) {
          _scroll(gap.inSeconds);
        }
      },
    );

    _acontroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() {
        _scroll(_frictionAnimation.value.toInt());
      });
  }

  @override
  void initState() {
    super.initState();
    _createPoller();
    poller.poll();
  }

  @override
  void reassemble() {
    _acontroller.dispose();
    super.reassemble();
    actualizator.cancel();
    _createPoller();
    poller.poll();
  }

  @override
  void dispose() {
    _acontroller.dispose();
    super.dispose();
    actualizator.cancel();
  }

  void _scroll(int dx) {
    setState(() {
      mostRight = mostRight.add(Duration(
        seconds: dx,
      ));

      // bound to be not further than now
      final now = DateTime.now();
      if (mostRight.compareTo(now) > 0) mostRight = now;

      poller.poll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.transparent,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      clipBehavior: Clip.hardEdge,
      height: 300,
      child: StreamBuilder(
        stream: poller.responsesStream,
        builder: (context, snap) {
          if (snap.hasData) {
            // make chart from reports in (mostLeft, mostRight) window
            final chart = <_ChartData>[];
            chart.add(_ChartData(time: mostLeft));
            for (var report in snap.data!) {
              if (report.timestamp.isAfter(mostLeft) &&
                  report.timestamp.isBefore(mostRight)) {
                chart.add(
                  _ChartData(
                    time: report.timestamp.toLocal(),
                    temperature: report.temp,
                    humidity: report.hum,
                  ),
                );
              }
            }
            chart.add(_ChartData(time: mostRight));

            // add gaps when time dist between points is more than 6 minutes
            List<_ChartData> modifiedChart = [];
            for (int i = 0; i < chart.length; i++) {
              if (i > 0 &&
                  chart[i].time.difference(chart[i - 1].time).inMinutes > 6) {
                modifiedChart.add(
                  _ChartData(time: chart[i].time),
                );
              }
              modifiedChart.add(chart[i]);
            }

            return GestureDetector(
              onPanDown: (_) => _acontroller.stop(),
              onHorizontalDragUpdate: (details) => _scroll(
                details.delta.dx * -90000 ~/ MediaQuery.of(context).size.width,
              ),
              onHorizontalDragEnd: (details) {
                double velocity = details.velocity.pixelsPerSecond.dx;
                _frictionAnimation = IntTween(begin: -velocity.toInt(), end: 0)
                    .animate(_acontroller);
                _acontroller.reset();
                _acontroller.forward();
              },
              child: StreamBuilder<bool>(
                stream: poller.runningFutureStream,
                builder: (context, snap) {
                  if (snap.data ?? false) {
                    return Stack(
                      children: [
                        Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.grey.withOpacity(0.1),
                            ),
                          ),
                        ),
                        _InternalChart(
                          data: modifiedChart,
                        ),
                      ],
                    );
                  } else {
                    return _InternalChart(
                      data: modifiedChart,
                    );
                  }
                },
              ),
            );
          } else if (snap.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.close,
                    size: 60,
                    color: Colors.red,
                  ),
                  Text(
                    'Failed to load',
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}