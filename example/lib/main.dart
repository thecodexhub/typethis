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
      style: const TextStyle(fontSize: 20),
    );

    return MaterialApp(
      title: 'Flutter TypeThis Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TypeThis Example'),
        ),
        body: Center(
          child: typeThisWidget,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => typeThisWidget.controller.reset(),
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
