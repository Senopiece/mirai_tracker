import 'dart:async';
import 'dart:collection';

import 'accurate_poller.dart';
import 'interval_cache.dart';

class _QueuedRequest<T> {
  final List<Interval> intervals;
  final Completer<T> completer;
  final Duration minResponseTime;

  _QueuedRequest(this.intervals, this.completer, this.minResponseTime);
}

class APintervalAdapter<T> {
  late final AccuratePoller<T> poller;
  final Future<T> Function(List<Interval> intervals) source;

  late List<Interval> _intervals;
  final Queue<_QueuedRequest<T>> _queue = Queue();

  Completer<T>? _completer;

  APintervalAdapter(Duration minInterval, this.source) {
    poller = AccuratePoller<T>(minInterval, () => source(_intervals));
    poller.responsesStream.listen(
      (data) {
        _completer!.complete(data);
        _completer = null;
        _promoteQueue();
      },
      onError: (err) {
        _completer!.completeError(err);
        _completer = null;
        _promoteQueue();
      },
    );
  }

  Future<T> get(List<Interval> intervals,
      {Duration minResponseTime = const Duration(seconds: 0)}) {
    Completer<T> completer = Completer<T>();
    _queue.add(_QueuedRequest<T>(intervals, completer, minResponseTime));
    _promoteQueue();
    return completer.future;
  }

  void _promoteQueue() {
    if (!poller.isRunningFuture && _queue.isNotEmpty) {
      assert(_completer == null);
      final top = _queue.removeFirst();
      _intervals = top.intervals;
      poller.poll(top.minResponseTime);
      _completer = top.completer;
    }
  }
}
