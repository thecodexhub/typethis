import 'dart:async';

import 'package:flutter/widgets.dart';

/// {@template blinking_cursor}
/// Widget that creates a blinking cursor. The blinking effect
/// occurs every 500 milliseconds.
///
/// By default, _ (underscore) is used as the cursor.
/// {@endtemplate}
class BlinkingCursor extends StatefulWidget {
  /// The character which will be displayed as cursor.
  ///
  /// Default `cursorText` is _ (underscore).
  final String? cursorText;

  /// {@macro blinking_cursor}
  const BlinkingCursor({super.key, this.cursorText});

  @override
  State<BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<BlinkingCursor> {
  late final Timer _timer;
  bool _showCursor = true;

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  void _initializeTimer() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 500),
      (_) => setState(() {
        _showCursor = !_showCursor;
      }),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility.maintain(
      visible: _showCursor,
      child: Text(widget.cursorText ?? '_'),
    );
  }
}
