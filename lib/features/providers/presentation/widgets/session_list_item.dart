import 'package:flutter/material.dart';
import '../../domain/entities/study_session.dart';

class SessionListItem extends StatelessWidget {
  final StudySession session;
  final VoidCallback onTap;

  const SessionListItem({
    super.key, 
    required this.session,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: session.type == 'FOCUS' ? Colors.blue : Colors.green,
          child: Icon(
            session.type == 'FOCUS' ? Icons.timer : Icons.accessibility_new,
            color: Colors.white,
          ),
        ),
        title: Text('${session.durationMinutes} minutos'),
        subtitle: Text(session.date.toString().split('.')[0]), // Mostra data simples
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}