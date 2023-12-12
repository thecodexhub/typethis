import 'package:flutter/material.dart';

class TypeThisMatcher {
  final String regexPattern;
  final TextStyle? style;

  const TypeThisMatcher(this.regexPattern, {this.style});

  @override
  bool operator ==(covariant TypeThisMatcher other) {
    if (identical(this, other)) return true;

    return other.regexPattern == regexPattern && other.style == style;
  }

  @override
  int get hashCode => regexPattern.hashCode ^ style.hashCode;
}
