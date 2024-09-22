import 'package:flutter/material.dart';
import 'package:typethis/typethis.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TypeThisController controller = TypeThisController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TypeThis Demo',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TypeThis Example'),
          backgroundColor: Colors.grey[200],
        ),
        body: SimpleDecoratedBox(
          onResetPressed: () => controller.reset(),
          onFreezePressed: () => controller.freeze(),
          onUnfreezePressed: () => controller.unfreeze(),
          child: TypeThis(
            string: 'An example string 💥 with typing 😎 animation. 🚀',
            controller: controller,
            speed: 100,
            style: const TextStyle(fontSize: 16),
            richTextMatchers: const [
              TypeThisMatcher(
                'typing',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SimpleDecoratedBox extends StatelessWidget {
  const SimpleDecoratedBox({
    super.key,
    required this.child,
    required this.onResetPressed,
    required this.onFreezePressed,
    required this.onUnfreezePressed,
  });
  final Widget child;
  final VoidCallback onResetPressed;
  final VoidCallback onFreezePressed;
  final VoidCallback onUnfreezePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 550),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 48),
          Container(
            height: 60,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[200],
            ),
            child: child,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton.icon(
                onPressed: onResetPressed,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: onFreezePressed,
                icon: const Icon(Icons.pause),
                label: const Text('Freeze'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: onUnfreezePressed,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Unfreeze'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
