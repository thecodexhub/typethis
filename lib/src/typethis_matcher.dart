import 'package:flutter/material.dart';

/// {@template typethis_matcher}
/// A class definition that takes `regexPattern`, and
/// an optional [TextStyle] `style`.
/// {@endtemplate}
class TypeThisMatcher {
  /// Regular Expression pattern with which the string will be matched.
  final String regexPattern;

  /// Optional [TextStyle] for the matched string.
  /// 
  /// If `null`, default text style will be used.
  final TextStyle? style;

  /// {@macro typethis_matcher}
  const TypeThisMatcher(this.regexPattern, {this.style});

  @override
  bool operator ==(covariant TypeThisMatcher other) {
    if (identical(this, other)) return true;

    return other.regexPattern == regexPattern && other.style == style;
  }

  @override
  int get hashCode => regexPattern.hashCode ^ style.hashCode;
}
