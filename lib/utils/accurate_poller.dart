import 'dart:async';

// polling wrapper that ensures no overload of the underlying source
class AccuratePoller<T> {
  final Duration minInterval;
  final Future<T> Function() source;

  bool _pending = false;
  bool _runningFuture = false; // _runningFuture = false => _pending = false
  final StreamController<T> _scontroller = StreamController<T>.broadcast();
  final StreamController<bool> _fcontroller =
      StreamController<bool>.broadcast();
  DateTime? _lastInvocationTime;

  Future<void> _callbackWrapper() async {
    late T res;
    try {
      res = await source();
    } catch (e) {
      _scontroller.addError(e);
      return;
    }
    if (_pending) {
      _pending = false;
      _scontroller.add(res);
      _runFuture();
    } else {
      _runningFuture = false;
      _fcontroller.add(_runningFuture);
      _scontroller.add(res);
    }
  }

  AccuratePoller(this.minInterval, this.source);

  void poll() {
    if (_runningFuture) {
      _pending = true;
      return;
    }
    assert(_pending == false);
    _runningFuture = true;
    _fcontroller.add(_runningFuture);
    _runFuture();
  }

  // run future ensuring no min interval is violated
  void _runFuture() {
    final delay = _lastInvocationTime != null
        ? minInterval - DateTime.now().difference(_lastInvocationTime!)
        : const Duration(seconds: -1);
    if (delay.isNegative) {
      _runFutureNow();
    } else {
      Future.delayed(delay).then(
        (_) => _runFutureNow(),
      );
    }
  }

  void _runFutureNow() {
    _lastInvocationTime = DateTime.now();
    _callbackWrapper();
  }

  Stream<bool> get runningFutureStream => _fcontroller.stream;
  Stream<T> get responsesStream => _scontroller.stream;
}
