import 'package:flutter_test/flutter_test.dart';
import 'package:typethis/typethis.dart';

void main() {
  group('TypeThisController', () {
    late TypeThisController controller;

    setUpAll(() {
      controller = TypeThisController();
    });

    test('initial state is start', () {
      expect(controller.state, TypeThisControllerState.start);
    });

    test('reset changes the state to start', () {
      controller.reset();
      expect(controller.state, TypeThisControllerState.start);
    });

    test('freeze changes the state to frozen', () {
      controller.freeze();
      expect(controller.state, TypeThisControllerState.frozen);
    });

    test('unfreeze changes the state to resumed', () {
      controller.unfreeze();
      expect(controller.state, TypeThisControllerState.resumed);
    });

    test('unfreeze after freeze changes the state to resumed', () {
      controller.freeze();
      controller.unfreeze();
      expect(controller.state, TypeThisControllerState.resumed);
    });

    test('adding listener triggers notifyListeners', () {
      bool listenerCalled = false;
      controller.addListener(() {
        listenerCalled = true;
      });
      controller.notifyListeners();
      expect(listenerCalled, true);
    });
  });
}
