import 'package:flutter/widgets.dart';

/// Controller for managing or controlling the state of the typing animation.
class TypeThisController extends ChangeNotifier {
  bool _isDisposed = false;

  TypeThisControllerState _state = TypeThisControllerState.start;

  /// The current state of the typing animation.
  TypeThisControllerState get state => _state;

  /// Resets the typing animation and restarts it from beginning.
  void reset() {
    if (_isDisposed) {
      return;
    }

    _state = TypeThisControllerState.start;
    notifyListeners();
  }

  /// Freezes the typing animation.
  void freeze() {
    if (_isDisposed) {
      return;
    }

    _state = TypeThisControllerState.frozen;
    notifyListeners();
  }

  /// Unfreezes or resumes the typing animation, means the animation resumes
  /// from where it was frozen last time.
  void unfreeze() {
    if (_isDisposed) {
      return;
    }

    _state = TypeThisControllerState.resumed;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }
}

/// Enum representing the possible states of the typing animation.
enum TypeThisControllerState {
  /// The initial state, where the typing animation begins.
  /// Also, when the animation restarts.
  start,

  /// State when the typing animation has paused.
  frozen,

  /// State when the typing animation has resumed.
  resumed
}
