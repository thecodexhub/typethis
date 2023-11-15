import 'package:flutter_test/flutter_test.dart';
import 'package:typethis/typethis.dart';

void main() {
  group('TypeThisController', () {
    test('initial values are set correctly', () {
      final controller = TypeThisController(const Duration(seconds: 1), 10);
      expect(controller.steps, 0);
    });

    test('timer increments steps and notifies listeners', () async {
      final controller = TypeThisController(
        const Duration(milliseconds: 100),
        5,
      );
      expect(controller.steps, 0);

      await Future.delayed(const Duration(milliseconds: 350));
      expect(controller.steps, 3);
    });

    test('timer stops when steps reach maxBoundLength', () async {
      final controller = TypeThisController(
        const Duration(milliseconds: 100),
        3,
      );

      await Future.delayed(const Duration(milliseconds: 400));
      expect(controller.steps, 3);

      expect(controller.timer?.isActive, false);
    });

    test('reset method resets the controller', () async {
      final controller = TypeThisController(
        const Duration(milliseconds: 100),
        5,
      );
      final previousTimer = controller.timer;

      await Future.delayed(const Duration(milliseconds: 300));
      controller.reset();

      expect(controller.steps, 0);
      expect(previousTimer?.isActive, false);
      expect(controller.timer?.isActive, true);
    });

    test('multiple resets work correctly', () async {
      final controller = TypeThisController(
        const Duration(milliseconds: 100),
        5,
      );
      final firstTimer = controller.timer;

      await Future.delayed(const Duration(milliseconds: 300));
      controller.reset();
      final secondTimer = controller.timer;

      await Future.delayed(const Duration(milliseconds: 200));
      controller.reset();

      expect(controller.steps, 0);

      expect(firstTimer?.isActive, false);
      expect(secondTimer?.isActive, false);
      expect(controller.timer?.isActive, true);
    });
  });
}
