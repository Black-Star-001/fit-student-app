import 'package:flutter/material.dart';
import '../../domain/entities/study_session.dart';

class SessionDetailsDialog extends StatelessWidget {
  final StudySession session;

  const SessionDetailsDialog({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(session.type == 'FOCUS' ? 'Sessão de Foco' : 'Pausa Ativa'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Data: ${session.date}'),
          const SizedBox(height: 8),
          Text('Duração: ${session.durationMinutes} minutos'),
          const SizedBox(height: 8),
          Text('ID: ${session.id}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}