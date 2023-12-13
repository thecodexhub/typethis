import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:typethis/typethis.dart';

void main() {
  group('TypeThisMatcher -', () {
    test('two instances with the same values are equal', () {
      const matcher1 = TypeThisMatcher('abc');
      const matcher2 = TypeThisMatcher('abc');

      expect(matcher1, equals(matcher2));
    });

    test('two instances with different regexPattern are not equal', () {
      const matcher1 = TypeThisMatcher('abc');
      const matcher2 = TypeThisMatcher('xyz');

      expect(matcher1, isNot(equals(matcher2)));
    });

    test('two instances with different styles are not equal', () {
      const matcher1 = TypeThisMatcher(
        'abc',
        style: TextStyle(fontSize: 16),
      );
      const matcher2 = TypeThisMatcher(
        'abc',
        style: TextStyle(fontSize: 18),
      );

      expect(matcher1, isNot(equals(matcher2)));
    });

    test('hashCode returns the same value for equal instances', () {
      const matcher1 = TypeThisMatcher('abc');
      const matcher2 = TypeThisMatcher('abc');

      expect(matcher1.hashCode, equals(matcher2.hashCode));
    });

    test('hashCode is different for instances with different regexPattern', () {
      const matcher1 = TypeThisMatcher('abc');
      const matcher2 = TypeThisMatcher('xyz');

      expect(matcher1.hashCode, isNot(equals(matcher2.hashCode)));
    });

    test('hashCode is different for instances with different styles', () {
      const matcher1 = TypeThisMatcher(
        'abc',
        style: TextStyle(fontSize: 16),
      );
      const matcher2 = TypeThisMatcher(
        'abc',
        style: TextStyle(fontSize: 18),
      );

      expect(matcher1.hashCode, isNot(equals(matcher2.hashCode)));
    });
  });
}
