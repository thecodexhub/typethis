import 'dart:async';

import 'package:flutter/widgets.dart';

class BlinkingCursor extends StatefulWidget {
  const BlinkingCursor({super.key, this.cursorText});
  final String? cursorText;

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
