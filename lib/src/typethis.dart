import 'package:flutter/widgets.dart';

/// {@template typethis}
/// Widget that creates the "typing" animation by making characters
/// in the provided [string] appear one at a time.
///
/// Example:
/// ```dart
/// TypeThis(
///   string: 'Hi there! How are you doing?',
///   speed: 50,
///   style: TextStyle(fontSize: 18, color: Colors.black),
/// );
/// ```
/// {@endtemplate}
class TypeThis extends StatefulWidget {
  /// The text which will be animated.
  final String string;

  /// Speed in milliseconds at which the typing animation will be executed.
  ///
  /// Default value is 50. That means each character in the [string] will render
  /// at a difference of 50 milliseconds.
  final int speed;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// [TextStyle] for the [string].
  /// 
  /// If non-null, the style to use for this text. Otherwise,
  /// [DefaultTextStyle] will be used.
  final TextStyle? style;

  /// {@macro typethis}
  const TypeThis({
    super.key,
    required this.string,
    this.speed = 50,
    this.textAlign,
    this.style,
  });

  @override
  State<StatefulWidget> createState() => _TypeThisState();
}

class _TypeThisState extends State<TypeThis>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<int> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);
    _setAnimationDuration();

    _animation = IntTween(begin: 0, end: widget.string.length)
        .animate(_animationController);

    _animation.addListener(() => setState(() {}));
    _animationController.forward();
  }

  void _setAnimationDuration() {
    final charactersCount = widget.string.length;
    _animationController.duration = Duration(
      milliseconds: charactersCount * widget.speed,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stringToRender = widget.string.substring(0, _animation.value);
    return Text(
      stringToRender,
      key: const Key('typethis_string'),
      textAlign: widget.textAlign,
      style: DefaultTextStyle.of(context).style.merge(widget.style),
    );
  }
}
