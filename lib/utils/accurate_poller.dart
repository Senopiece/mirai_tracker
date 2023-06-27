import 'dart:async';

// polling wrapper that ensures no overload of the underlying source
class AccuratePoller<T> {
  final Duration minInterval;
  final Future<T> Function() source;

  bool _pending = false;
  late Duration _pendingMinResponseTime;

  bool _runningFuture = false; // _runningFuture = false => _pending = false
  DateTime? _lastInvocationTime;

  final StreamController<T> _scontroller = StreamController<T>.broadcast();
  final StreamController<bool> _fcontroller =
      StreamController<bool>.broadcast();

  AccuratePoller(this.minInterval, this.source);

  void poll([Duration minResponseTime = const Duration(seconds: 0)]) {
    print('$_runningFuture $_pending');
    if (_runningFuture) {
      _pending = true;
      _pendingMinResponseTime = minResponseTime;
      return;
    }
    assert(_pending == false);
    _runningFuture = true;
    _fcontroller.add(_runningFuture);
    _runFuture(minResponseTime);
  }

  // run future ensuring no min interval is violated
  void _runFuture(Duration minResponseTime) {
    final delay = _lastInvocationTime != null
        ? minInterval - DateTime.now().difference(_lastInvocationTime!)
        : const Duration(seconds: -1);
    if (delay.isNegative) {
      _runFutureNow(minResponseTime);
    } else {
      Future.delayed(delay).then(
        (_) => _runFutureNow(minResponseTime),
      );
    }
  }

  void _runFutureNow(Duration minResponseTime) {
    _lastInvocationTime = DateTime.now();
    _future(minResponseTime);
  }

  Future<void> _future(Duration minResponseTime) async {
    late T res;
    bool noExcept = true;

    late Object ex;
    final t1 = DateTime.now();
    try {
      res = await source();
    } catch (e) {
      ex = e;
      noExcept = false;
    }

    final remains = minResponseTime - DateTime.now().difference(t1);
    if (!remains.isNegative) {
      await Future.delayed(remains);
    }

    if (noExcept) {
      _scontroller.add(res);
    } else {
      _scontroller.addError(ex);
      _pending = false; // cancel pending
    }

    if (_pending) {
      _pending = false;
      _runFuture(_pendingMinResponseTime);
    } else {
      _runningFuture = false;
      _fcontroller.add(_runningFuture);
    }
  }

  bool get isRunningFuture => _runningFuture;
  Stream<bool> get runningFutureStream => _fcontroller.stream;
  Stream<T> get responsesStream => _scontroller.stream;
}
