import 'dart:async';

class _PendingParameters {
  final Duration minResponseTime;
  final Interval interval;

  _PendingParameters(this.interval, this.minResponseTime);
}

abstract class DataPoint {
  DateTime get getTimestamp;
}

// TODO: for now IntervalCache is too tight to time elements, but can be generalized to any comparable
class Interval {
  final DateTime start;
  final DateTime stop;

  Interval(this.start, this.stop);

  bool isSubintervalOf(Interval other) {
    return (start.isAfter(other.start) ||
            start.isAtSameMomentAs(other.start)) &&
        (stop.isBefore(other.stop) || stop.isAtSameMomentAs(other.stop));
  }

  bool containsDateTime(DateTime dateTime) {
    return dateTime.isAfter(start) && dateTime.isBefore(stop);
  }

  Duration get duration => stop.difference(start);
}

// TODO: now minResponseTime is too tight to accurate_poller, better to investigate a way to pass general parameters
class IntervalCache<T extends DataPoint> {
  final Future<List<T>> Function(List<Interval> intervals,
      {Duration minResponseTime}) source;

  Interval _cachedInterval = Interval(DateTime(2017), DateTime(2017));
  List<T> _cachedPoints = [];

  bool _runningFuture = false; // _runningFuture = false => _pending == null
  _PendingParameters? _pending;

  final _scontroller = StreamController<List<T>>.broadcast();
  final _fcontroller = StreamController<bool>.broadcast();

  IntervalCache(this.source);

  Future<void> _future(Interval interval,
      {Duration minResponseTime = const Duration(seconds: 0)}) async {
    bool noExcept = true;
    late List<T> res;
    late Object ex;

    try {
      if (!interval.isSubintervalOf(_cachedInterval)) {
        // cache +- 12h additionally
        _cachedInterval = Interval(
          interval.start.subtract(const Duration(hours: 12)),
          interval.stop.add(const Duration(hours: 12)),
        );
        _cachedPoints =
            await source([_cachedInterval], minResponseTime: minResponseTime);
      }
      res = [];
      for (var point in _cachedPoints) {
        if (interval.containsDateTime(point.getTimestamp)) {
          res.add(point);
        }
      }
    } catch (e) {
      ex = e;
      noExcept = false;
    }

    if (noExcept) {
      _scontroller.add(res);
    } else {
      _scontroller.addError(ex);
      _pending = null; // cancel pending
    }

    if (_pending != null) {
      final context = _pending!;
      _pending = null;
      _future(context.interval, minResponseTime: context.minResponseTime);
    } else {
      _runningFuture = false;
      _fcontroller.add(_runningFuture);
    }
  }

  void poll(Interval interval,
      {Duration minResponseTime = const Duration(seconds: 0)}) async {
    if (_runningFuture) {
      _pending = _PendingParameters(interval, minResponseTime);
    } else {
      _runningFuture = true;
      _fcontroller.add(_runningFuture);
      _future(interval, minResponseTime: minResponseTime);
    }
  }

  bool get isRunningFuture => _runningFuture;
  Stream<bool> get runningFutureStream => _fcontroller.stream;
  Stream<List<T>> get responsesStream => _scontroller.stream;
}
