import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

import '../services/mirai_tracker.dart';
import '../utils/accurate_poller.dart';

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

// TODO: hint on a point of when it is belonging and with what value
class _InternalChart extends StatelessWidget {
  final List<_ChartData> data;

  const _InternalChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
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
        dateTimeFactory: const charts.LocalDateTimeFactory(),
        primaryMeasureAxis: const charts.NumericAxisSpec(
          tickProviderSpec: charts.StaticNumericTickProviderSpec(
            [
              charts.TickSpec(-20, label: ''),
              charts.TickSpec(-10),
              charts.TickSpec(0),
              charts.TickSpec(10),
              charts.TickSpec(20),
              charts.TickSpec(30),
              charts.TickSpec(40),
              charts.TickSpec(50),
              charts.TickSpec(60),
              charts.TickSpec(70),
              charts.TickSpec(80),
              charts.TickSpec(90),
              charts.TickSpec(100),
            ],
          ),
        ),
        domainAxis: const charts.DateTimeAxisSpec(
          tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
            minute: charts.TimeFormatterSpec(
              format: 'MMM d H:mm',
              transitionFormat: 'H:mm',
            ),
            hour: charts.TimeFormatterSpec(
              format: 'H:mm',
              transitionFormat: 'MMM d H:mm',
            ),
          ),
        ),
      ),
    );
  }
}

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
  var shownInterval = const Duration(minutes: 120);
  late Duration _captureInterval;
  DateTime get mostLeft => mostRight.subtract(shownInterval);

  late AnimationController _acontroller;
  late Animation<int> _frictionAnimation;

  late AccuratePoller<List<HumTempMeasure>> poller;
  late Timer actualizator;

  bool _error = false;

  void _createPoller() {
    poller = AccuratePoller<List<HumTempMeasure>>(
      const Duration(seconds: 1),
      () async {
        return await widget.tracker.getHumTempChart(
          mostLeft,
          mostRight,
        );
      },
    );

    actualizator = Timer.periodic(
      const Duration(seconds: 10),
      (_) {
        final gap = DateTime.now().difference(mostRight);
        if (!_error &&
            const Duration(minutes: 3) < gap &&
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

  void _scroll(
    int dx, {
    Duration minResponseTime = const Duration(seconds: 0),
  }) {
    setState(() {
      mostRight = mostRight.add(Duration(
        seconds: dx,
      ));

      // bound to be not further than now
      final now = DateTime.now();
      if (mostRight.compareTo(now) > 0) mostRight = now;

      poller.poll(minResponseTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
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
        margin: const EdgeInsets.fromLTRB(10, 20, 10, 14),
        clipBehavior: Clip.hardEdge,
        height: 300,
        child: StreamBuilder(
          stream: poller.responsesStream,
          builder: (context, snap) {
            _error = !snap.hasData;
            if (snap.hasData) {
              // make chart from reports in (mostLeft, mostRight) window
              final chart = <_ChartData>[];
              chart.add(_ChartData(time: mostLeft));
              for (var report in snap.data!) {
                report = report.copyWith(
                  timestamp: report.timestamp.copyWith(isUtc: true).toLocal(),
                );
                if (report.timestamp.isAfter(mostLeft) &&
                    report.timestamp.isBefore(mostRight)) {
                  chart.add(
                    _ChartData(
                      time: report.timestamp,
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
                    chart[i - 1]
                            .time
                            .difference(chart[i].time)
                            .abs()
                            .inMinutes >
                        6) {
                  modifiedChart.add(
                    _ChartData(time: chart[i].time),
                  );
                }
                modifiedChart.add(chart[i]);
              }

              return GestureDetector(
                onPanDown: (_) => _acontroller.stop(),
                // TODO: some mobile browsers somewhy cannot scroll
                onHorizontalDragUpdate: (details) => _scroll(
                  -shownInterval.inSeconds *
                      details.delta.dx ~/
                      constraints.maxWidth,
                ),
                onHorizontalDragEnd: (details) {
                  int velocity = -details.velocity.pixelsPerSecond.dx.toInt();
                  _frictionAnimation =
                      IntTween(begin: velocity, end: 0).animate(_acontroller);
                  _acontroller.reset();
                  _acontroller.forward();
                },
                // TODO: why is this not working
                // TODO: after making it working, make centrition in focal point
                onScaleStart: (details) => _captureInterval = shownInterval,
                onScaleUpdate: (details) {
                  print(details.scale);
                  shownInterval = _captureInterval * details.scale;
                },
                child: StreamBuilder<bool>(
                  stream: poller.runningFutureStream,
                  builder: (context, snap) {
                    if (poller.isRunningFuture) {
                      return Stack(
                        children: [
                          Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.grey.withOpacity(0.2),
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
                child: StreamBuilder<bool>(
                  stream: poller.runningFutureStream,
                  builder: (context, snap) {
                    // NOTE: poller.isRunningFuture != snap.data ?? false
                    if (poller.isRunningFuture) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Failed to load',
                            style: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            child: IconButton(
                              onPressed: () => _scroll(0,
                                  minResponseTime:
                                      const Duration(milliseconds: 300)),
                              color: Theme.of(context).primaryColor,
                              icon: const Icon(
                                Icons.refresh,
                                size: 50,
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  },
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
    });
  }
}
