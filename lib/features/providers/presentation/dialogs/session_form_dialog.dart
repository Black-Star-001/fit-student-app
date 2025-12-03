import 'package:flutter/material.dart';

class SessionFormDialog extends StatefulWidget {
  const SessionFormDialog({super.key});

  @override
  State<SessionFormDialog> createState() => _SessionFormDialogState();
}

class _SessionFormDialogState extends State<SessionFormDialog> {
  final _minutesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Registrar Estudo'),
      content: TextField(
        controller: _minutesController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Minutos estudados'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            // Retorna o valor para quem chamou
            Navigator.pop(context, int.tryParse(_minutesController.text));
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}