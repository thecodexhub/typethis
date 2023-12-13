import 'package:example/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:typethis/typethis.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final typeThisWidget = TypeThis(
      string: 'Hi there! How are you doing?',
      speed: 100,
      style: const TextStyle(fontSize: 18),
    );

    final richTypeThisWidget = TypeThis(
      string: 'Welcome to the typethis package.',
      speed: 100,
      style: const TextStyle(fontSize: 18),
      softWrap: true,
      richTextMatchers: const [
        TypeThisMatcher(
          'typethis',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            decoration: TextDecoration.underline,
            decorationColor: Colors.indigo,
            color: Colors.indigo,
          ),
        ),
      ],
    );

    return MaterialApp(
      title: 'Flutter TypeThis Demo',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TypeThis Example'),
          backgroundColor: Colors.grey[200],
        ),
        body: Column(
          children: [
            SimpleDecoratedBox(
              typeThisWidget: typeThisWidget,
              onResetPressed: () => typeThisWidget.controller.reset(),
              onFreezePressed: () => typeThisWidget.controller.freeze(),
              onUnfreezePressed: () => typeThisWidget.controller.unfreeze(),
            ),
            const SizedBox(height: 16),
            RichDecoratedBox(
              typeThisWidget: richTypeThisWidget,
              onResetPressed: () => richTypeThisWidget.controller.reset(),
              onFreezePressed: () => richTypeThisWidget.controller.freeze(),
              onUnfreezePressed: () => richTypeThisWidget.controller.unfreeze(),
            ),
          ],
        ),
      ),
    );
  }
}
