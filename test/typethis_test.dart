import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:typethis/typethis.dart';

import 'helpers/helpers.dart';

void main() {
  group('TypeThis', () {
    const testString = 'This is a test string';
    const testSpeed = 50;

    TypeThis buildSubject({
      String string = testString,
      int speed = testSpeed,
      bool showBlinkingCursor = false,
      TextAlign textAlign = TextAlign.center,
      TextStyle style = const TextStyle(),
    }) {
      return TypeThis(
        string: string,
        speed: speed,
        showBlinkingCursor: showBlinkingCursor,
        textAlign: textAlign,
        style: style,
      );
    }

    group(': constructor', () {
      test('works perfectly', () {
        expect(
          () => TypeThis(string: testString),
          returnsNormally,
        );
      });

      test('throws when speed is less than 0', () {
        expect(
          () => buildSubject(speed: -10),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group(': controller', () {
      test('works perfectly', () {
        final typeThisWidget = buildSubject();
        expect(
          typeThisWidget.typeThisController,
          equals(typeThisWidget.controller),
        );
      });
    });

    group(': text widget', () {
      group('animation', () {
        testWidgets(
          'has started rendering and string is empty',
          (widgetTester) async {
            await widgetTester.pumpApp(buildSubject());
            await widgetTester.pump();

            final finder = find.byType(Text);
            expect(finder, findsOneWidget);

            final textWidget = widgetTester.firstWidget<Text>(finder);
            expect(textWidget.data, equals(''));
          },
        );

        testWidgets(
          'renders first 3 characters after (3 * testSpeed)ms duration',
          (widgetTester) async {
            await widgetTester.pumpApp(buildSubject());
            await widgetTester
                .pump(const Duration(milliseconds: testSpeed * 3));

            final finder = find.byType(Text);
            expect(finder, findsOneWidget);

            final textWidget = widgetTester.firstWidget<Text>(finder);
            expect(textWidget.data, equals(testString.substring(0, 3)));
          },
        );

        testWidgets(
          'has finished rendereing and whole string is present',
          (widgetTester) async {
            await widgetTester.pumpApp(buildSubject());
            await widgetTester.pump(
              const Duration(milliseconds: testSpeed * testString.length),
            );

            final finder = find.byType(Text);
            expect(finder, findsOneWidget);

            final textWidget = widgetTester.firstWidget<Text>(finder);
            expect(textWidget.data, equals(testString));
          },
        );
      });

      testWidgets(
        'textAlign property is same as provided',
        (widgetTester) async {
          const testTextAlign = TextAlign.start;

          await widgetTester.pumpApp(
            buildSubject(textAlign: testTextAlign),
          );
          await widgetTester.pumpAndSettle();

          final finder = find.byType(Text);
          expect(finder, findsOneWidget);

          final textWidget = widgetTester.firstWidget<Text>(finder);
          expect(textWidget.textAlign, equals(testTextAlign));
        },
      );

      testWidgets(
        'style property is same as provided',
        (widgetTester) async {
          const testStyle = TextStyle(fontSize: 28, color: Colors.black87);

          await widgetTester.pumpApp(
            buildSubject(style: testStyle),
          );
          await widgetTester.pumpAndSettle();

          final finder = find.byType(Text);
          expect(finder, findsOneWidget);

          final textWidget = widgetTester.firstWidget<Text>(finder);
          expect(textWidget.style?.fontSize, equals(testStyle.fontSize));
          expect(textWidget.style?.color, equals(testStyle.color));
        },
      );

      testWidgets(
        'doesnot show blinking cursor when showBlinkingCursor is false',
        (widgetTester) async {
          await widgetTester.pumpApp(buildSubject());
          await widgetTester.pump();

          final blinkingCursorFinder = find.byType(BlinkingCursor);
          expect(blinkingCursorFinder, findsNothing);

          final sizedBoxFinder = find.byType(SizedBox);
          expect(sizedBoxFinder, findsOneWidget);
        },
      );

      testWidgets(
        'shows blinking cursor when showBlinkingCursor is true',
        (widgetTester) async {
          await widgetTester.pumpApp(
            buildSubject(showBlinkingCursor: true),
          );
          await widgetTester.pump();

          final blinkingCursorFinder = find.byType(BlinkingCursor);
          expect(blinkingCursorFinder, findsOneWidget);

          final sizedBoxFinder = find.byType(SizedBox);
          expect(sizedBoxFinder, findsNothing);
        },
      );
    });
  });
}
