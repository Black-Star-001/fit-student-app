import 'package:flutter/material.dart';

class StudyFabArea extends StatelessWidget {
  final VoidCallback onPressed;

  const StudyFabArea({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      icon: const Icon(Icons.add),
      label: const Text('Nova Sessão'),
    );
  }
}