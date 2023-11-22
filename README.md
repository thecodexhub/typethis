# TypeThis

[![build](https://github.com/thecodexhub/typethis/actions/workflows/main.yml/badge.svg)](https://github.com/thecodexhub/typethis/actions)
[![codecov](https://codecov.io/gh/thecodexhub/typethis/graph/badge.svg?token=7FY2DF2DS1)](https://codecov.io/gh/thecodexhub/typethis)
[![License: MIT](https://img.shields.io/badge/License-MIT-purple.svg)](https://opensource.org/licenses/MIT)
[![Package Version](https://img.shields.io/pub/v/typethis.svg)](https://pub.dev/packages/typethis)

A flutter package that aims to simplify versatile typing animation with reset functionality.

## Create a TypeThis widget

```dart
final typeThisWidget = TypeThis(
  // The text which will be animated.
  string: 'Hi there! How are you doing?',
  // Speed in milliseconds at which the typing animation will be executed.
  speed: 100,
  // Text style for the string.
  style: const TextStyle(fontSize: 20),
);
```

## Reset the animation

```dart
// Call the `reset()` method on controller to reset the typing animation.
typeThisWidget.controller.reset();
```

## Freeze (pause) the animation

```dart
// Call the `freeze()` method on controller to freeze/pause the typing animation.
typeThisWidget.controller.freeze();
```

## Unfreeze (resume) the animation

```dart
// Call the `unfreeze()` method on controller to unfreeze/resume the typing animation.
typeThisWidget.controller.unfreeze();
```

## Demo

[![Demo](demo/typethis.gif)](https://github.com/thecodexhub/typethis)

## License

The project is released under the [MIT License](LICENSE). Learn more about it, [here](https://opensource.org/license/mit/).

---

<p align="center">
  <p align="center">
    Developed and Maintained with 💜 by <a href="https://github.com/thecodexhub">thecodexhub</a>
  </p>
  <p align="center">
    <a href="https://github.com/thecodexhub/typethis">
      <img src="https://img.shields.io/github/stars/thecodexhub/typethis?label=%E2%AD%90%20Star%20this%20repository&color=%23FFBF00" alt="Star this repository">
    </a>
  </p>
</p>
