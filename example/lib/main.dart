import 'package:flutter/material.dart';
import 'package:typethis/typethis.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TypeThis Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: TypeThis(
            string: 'Hello how are you doing?',
            speed: 100,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
