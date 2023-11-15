import 'dart:async';

import 'package:flutter/foundation.dart';

/// {@template typethis_controller}
/// A controller for the [TypeThis] widget.
///
/// It facilitates different operations on the typing animation.
/// For example, the `reset()` method resets the typing animation,
/// and restarts it from the beginning.
///
/// Remember to [dispose] of the [TypeThisController] when it is no longer
/// needed. This will ensure we discard any resources used by the object.
/// {@endtemplate}
class TypeThisController with ChangeNotifier {
  // Track the steps
  int _steps = 0;

  // Getter to track the step. Each step means adding a character
  // to the typing animation.
  int get steps => _steps;

  // Duration on which [Timer.periodic] will run.
  final Duration _periodicDuration;

  // Length of the string
  final int _maxBoundLength;

  // Tracks the timer to reset and cancel when dispose.
  @visibleForTesting
  Timer? timer;

  /// {@macro typethis_controller}
  TypeThisController(Duration duration, int maxBoundLength)
      : _periodicDuration = duration,
        _maxBoundLength = maxBoundLength {
    _startTimerAndNotify();
  }

  // Starts the timer and notifies the listener as a callback.
  void _startTimerAndNotify() {
    timer = Timer.periodic(_periodicDuration, (_) {
      _steps++;
      notifyListeners();

      if (_steps == _maxBoundLength) {
        timer?.cancel();
      }
    });
  }

  /// Resets the typing animation and restarts it from beginning.
  ///
  /// ```dart
  /// // Extract the [TypeThis] widget into a separate variable.
  /// final typeThisWidget = TypeThis(
  ///   string: 'Hi there! How are you doing?',
  ///   speed: 50,
  ///   style: TextStyle(fontSize: 18, color: Colors.black),
  /// );
  ///
  /// // Resets the animation
  /// typeThisWidget.controller.reset();
  /// ```
  void reset() {
    timer?.cancel();
    _steps = 0;
    _startTimerAndNotify();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
