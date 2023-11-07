import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:typethis/typethis.dart';

import 'helpers/helpers.dart';

void main() {
  group('BlinkingCursor', () {
    Widget buildSubject({
      String? cursorText = '_',
    }) {
      return BlinkingCursor(
        cursorText: cursorText,
      );
    }

    group(': constructor', () {
      test('works perfectly', () {
        expect(buildSubject, returnsNormally);
      });
    });

    group(': cursor', () {
      testWidgets(
        'shows up after widget initialization',
        (widgetTester) async {
          await widgetTester.pumpApp(buildSubject());

          final visibilityFinder = find.byType(Visibility);
          expect(visibilityFinder, findsOneWidget);

          final visibilityWidget = widgetTester.firstWidget<Visibility>(
            visibilityFinder,
          );
          expect(visibilityWidget.visible, equals(true));
        },
      );

      testWidgets(
        'blinks after 500ms',
        (widgetTester) async {
          await widgetTester.pumpApp(buildSubject());
          await widgetTester.pump(const Duration(milliseconds: 500));

          final visibilityFinder = find.byType(Visibility);
          expect(visibilityFinder, findsOneWidget);

          final visibilityWidget = widgetTester.firstWidget<Visibility>(
            visibilityFinder,
          );
          expect(visibilityWidget.visible, equals(false));
        },
      );
    });

    testWidgets(
      ': shows _ (underscore) when cursorText is null',
      (widgetTester) async {
        await widgetTester.pumpApp(
          buildSubject(cursorText: null),
        );

        final textFinder = find.byType(Text);
        expect(textFinder, findsOneWidget);

        final textWidget = widgetTester.firstWidget<Text>(
          textFinder,
        );
        expect(textWidget.data, equals('_'));
      },
    );

    testWidgets(
      ': shows specified text when cursorText is not null',
      (widgetTester) async {
        await widgetTester.pumpApp(
          buildSubject(cursorText: '|'),
        );

        final textFinder = find.byType(Text);
        expect(textFinder, findsOneWidget);

        final textWidget = widgetTester.firstWidget<Text>(
          textFinder,
        );
        expect(textWidget.data, equals('|'));
      },
    );
  });
}
