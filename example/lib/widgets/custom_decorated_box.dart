import 'package:flutter/material.dart';

class CustomDecoratedBox extends StatelessWidget {
  const CustomDecoratedBox({
    super.key,
    required this.typeThisWidget,
    required this.onResetPressed,
    required this.onFreezePressed,
    required this.onUnfreezePressed,
  });
  final Widget typeThisWidget;
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
          const SizedBox(height: 24),
          const _BuildDocumentation(),
          const SizedBox(height: 24),
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
            child: typeThisWidget,
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

class _BuildDocumentation extends StatelessWidget {
  const _BuildDocumentation();

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      TextSpan(
        style: TextStyle(fontSize: 16),
        children: [
          TextSpan(
            text: '• reset() : ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'Resets the typing animation.',
          ),
          TextSpan(
            text: '\n• freeze() : ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'Freezes / pauses the typing animation.',
          ),
          TextSpan(
            text: '\n• unfreeze() : ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'Resumes the typing animation.',
          ),
        ],
      ),
    );
  }
}
