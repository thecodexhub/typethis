## 1.0.2

- fix: use characters api to render unicode ([#15](https://github.com/thecodexhub/typethis/pull/15))
- chore: create CODE_OF_CONDUCT.md
- chore: update issue templates

## 1.0.1

- fix: text overflow on long string ([#10](https://github.com/thecodexhub/typethis/pull/10))

## 1.0.0

- BREAKING: revamp controller structure for `TypeThisController`
- docs(README): update documentation to incorporate the controller design change
- docs(example): update example app with new controller structure

### Changes

This is how the controller looks and works now. More details in [README](./README.md#control-the-animation). 

```dart
final controller = TypeThisController();

TypeThis(
  string: 'Example String',
  controller: controller,
);

controller.reset();
```

## 0.3.0

- feat: add rich text effects using `TypeThisMatcher` that works with regex pattern
- docs(README): update documentation on `TypeThisMatcher` example
- docs(example): update example app with rich text effect typing animation

## 0.2.0

- feat: add freeze and unfreeze methods on controller to pause and resume animation
- docs(README): update documentation on freeze and unfreeze method
- docs(example): update example app with the freeze and unfreeze method showcases

## 0.1.1

- chore(deps): bump to flutter version 3.16.0
- feat: deprecate `textScaleFactor` in favor of `textScaler`

## 0.1.0

- feat(controller): add `TypeThisController` for reset functionality
- test(controller): add unit tests and widget tests for controller
- docs(controller): update example app with reset functionality, update README
- chore: update package description, add properties (repository, issue_tracker, documentation)
- chore: add codecov workflow and status badge

## 0.0.1

Initial release of the `typethis` package.
