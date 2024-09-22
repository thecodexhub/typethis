// ignore_for_file: deprecated_member_use_from_same_package

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
      TypeThisController? controller,
      bool showBlinkingCursor = false,
      TextAlign textAlign = TextAlign.center,
      TextStyle style = const TextStyle(),
      double? textScaleFactor,
      List<TypeThisMatcher> richTextMatchers = const [],
    }) {
      return TypeThis(
        string: string,
        speed: speed,
        controller: controller,
        showBlinkingCursor: showBlinkingCursor,
        textAlign: textAlign,
        style: style,
        textScaleFactor: textScaleFactor,
        richTextMatchers: richTextMatchers,
      );
    }

    group(': constructor', () {
      test('works perfectly', () {
        expect(
          () => const TypeThis(string: testString),
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
        final controller = TypeThisController();
        final typeThisWidget = buildSubject(controller: controller);
        expect(
          typeThisWidget.controller,
          equals(controller),
        );
      });

      testWidgets(
        'reset method resets and renders from beginning',
        (widgetTester) async {
          final controller = TypeThisController();

          await widgetTester.pumpApp(buildSubject(controller: controller));
          await widgetTester.pump(const Duration(milliseconds: 200));

          controller.reset();
          await widgetTester.pump(const Duration(milliseconds: 2 * testSpeed));

          final finder = find.byType(RichText);
          expect(finder, findsOneWidget);

          final richTextWidget = widgetTester.firstWidget<RichText>(finder);
          expect(
            richTextWidget.text.toPlainText(),
            contains(testString.substring(0, 2)),
          );
        },
      );

      testWidgets(
        'freeze method freezes the typing animation',
        (widgetTester) async {
          final controller = TypeThisController();

          await widgetTester.pumpApp(buildSubject(controller: controller));
          await widgetTester.pump(const Duration(milliseconds: 5 * testSpeed));

          controller.freeze();
          await widgetTester.pump(const Duration(milliseconds: 2 * testSpeed));

          final finder = find.byType(RichText);
          expect(finder, findsOneWidget);

          final richTextWidget = widgetTester.firstWidget<RichText>(finder);
          expect(
            richTextWidget.text.toPlainText(),
            contains(testString.substring(0, 5)),
          );
        },
      );

      testWidgets(
        'unfreeze method resumes the typing animation',
        (widgetTester) async {
          final controller = TypeThisController();

          await widgetTester.pumpApp(buildSubject(controller: controller));
          await widgetTester.pump(const Duration(milliseconds: 5 * testSpeed));

          controller.freeze();
          await widgetTester.pump(const Duration(milliseconds: 2 * testSpeed));

          controller.unfreeze();
          await widgetTester.pump(const Duration(milliseconds: 2 * testSpeed));

          final finder = find.byType(RichText);
          expect(finder, findsOneWidget);

          final richTextWidget = widgetTester.firstWidget<RichText>(finder);
          expect(
            richTextWidget.text.toPlainText(),
            contains(testString.substring(0, 7)),
          );
        },
      );
    });

    group(': text widget', () {
      group('animation', () {
        testWidgets(
          'has started rendering and string is empty',
          (widgetTester) async {
            await widgetTester.pumpApp(buildSubject());
            await widgetTester.pump();

            final finder = find.byType(RichText);
            expect(finder, findsOneWidget);

            final richTextWidget = widgetTester.firstWidget<RichText>(finder);
            expect(richTextWidget.text.toPlainText(), contains(''));
          },
        );

        testWidgets(
          'renders first 3 characters after (3 * testSpeed)ms duration',
          (widgetTester) async {
            await widgetTester.pumpApp(buildSubject());
            await widgetTester
                .pump(const Duration(milliseconds: testSpeed * 3));

            final finder = find.byType(RichText);
            expect(finder, findsOneWidget);

            final richTextWidget = widgetTester.firstWidget<RichText>(finder);
            expect(
              richTextWidget.text.toPlainText(),
              contains(testString.substring(0, 3)),
            );
          },
        );

        testWidgets(
          'has finished rendereing and whole string is present',
          (widgetTester) async {
            await widgetTester.pumpApp(buildSubject());
            await widgetTester.pump(
              const Duration(milliseconds: testSpeed * testString.length),
            );

            final finder = find.byType(RichText);
            expect(finder, findsOneWidget);

            final richTextWidget = widgetTester.firstWidget<RichText>(finder);
            expect(richTextWidget.text.toPlainText(), contains(testString));
          },
        );
      });

      group('rich text animation', () {
        TypeThis buildRichTextSubject() {
          return buildSubject(
            richTextMatchers: const [
              TypeThisMatcher(
                'test',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          );
        }

        testWidgets(
          'has started rendering and string is empty',
          (widgetTester) async {
            await widgetTester.pumpApp(buildRichTextSubject());
            await widgetTester.pump();

            final finder = find.byType(RichText);
            expect(finder, findsOneWidget);

            final richTextWidget = widgetTester.firstWidget<RichText>(finder);
            expect(richTextWidget.text.toPlainText(), contains(''));
          },
        );

        testWidgets(
          'renders first 3 characters after (3 * testSpeed)ms duration',
          (widgetTester) async {
            await widgetTester.pumpApp(buildRichTextSubject());
            await widgetTester
                .pump(const Duration(milliseconds: testSpeed * 3));

            final finder = find.byType(RichText);
            expect(finder, findsOneWidget);

            final richTextWidget = widgetTester.firstWidget<RichText>(finder);
            expect(
              richTextWidget.text.toPlainText(),
              contains(testString.substring(0, 3)),
            );

            expect(
              find.text(testString.substring(0, 3), findRichText: true),
              findsOne,
            );
          },
        );

        testWidgets(
          'has finished rendereing and whole string is present',
          (widgetTester) async {
            await widgetTester.pumpApp(buildRichTextSubject());
            await widgetTester.pump(
              const Duration(milliseconds: testSpeed * testString.length),
            );

            final finder = find.byType(RichText);
            expect(finder, findsOneWidget);

            final richTextWidget = widgetTester.firstWidget<RichText>(finder);
            expect(richTextWidget.text.toPlainText(), contains(testString));

            expect(find.text(testString, findRichText: true), findsOne);
          },
        );
      });

      testWidgets(
        'textScaleFactor works perfectly as a deprecated member',
        (widgetTester) async {
          const textScaleFactor = 2.0;

          await widgetTester.pumpApp(
            buildSubject(textScaleFactor: textScaleFactor),
          );
          await widgetTester.pumpAndSettle();

          final finder = find.byType(Text);
          expect(finder, findsOneWidget);

          final textWidget = widgetTester.firstWidget<Text>(finder);
          expect(
            textWidget.textScaler,
            equals(const TextScaler.linear(textScaleFactor)),
          );
        },
      );

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

      testWidgets('renders long text', (widgetTester) async {
        widgetTester.view.physicalSize = const Size(100, 700);

        const longString = 'A very very very very very long piece of string';
        await widgetTester.pumpApp(
          buildSubject(
            string: longString,
            showBlinkingCursor: true,
          ),
        );
        await widgetTester.pump(const Duration(seconds: 7));

        final finder = find.byType(RichText);

        final richTextWidget = widgetTester.firstWidget<RichText>(finder);
        expect(richTextWidget.text.toPlainText(), contains(longString));

        expect(find.byType(BlinkingCursor), findsOneWidget);
      });
    });

    testWidgets('works with unicode characters (emoji)', (widgetTester) async {
      const text = '🚀 string 😃 with 👨‍💻✨ emoji 👀';
      await widgetTester.pumpApp(
        buildSubject(
          string: text,
        ),
      );
      await widgetTester.pump(const Duration(milliseconds: 55));

      final finder = find.byType(RichText);
      final richTextWidget = widgetTester.firstWidget<RichText>(finder);

      expect(
        richTextWidget.text.toPlainText(),
        text.characters.take(1).toString(),
      );

      await widgetTester.pump(const Duration(milliseconds: 501));
      final updatedRichTextWidget = widgetTester.firstWidget<RichText>(finder);
      expect(
        updatedRichTextWidget.text.toPlainText(),
        text.characters.take(11).toString(),
      );

      await widgetTester.pump(const Duration(seconds: 2));
      final wholeRichTextWidget = widgetTester.firstWidget<RichText>(finder);
      expect(
        wholeRichTextWidget.text.toPlainText(),
        text,
      );
    });
  });
}
