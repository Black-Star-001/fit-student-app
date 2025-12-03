import 'package:flutter/material.dart';
import '../../domain/entities/study_session.dart';
import 'session_list_item.dart';

class SessionListView extends StatelessWidget {
  final List<StudySession> sessions;

  const SessionListView({super.key, required this.sessions});

  @override
  Widget build(BuildContext context) {
    if (sessions.isEmpty) {
      return const Center(child: Text('Nenhuma sessão registrada.'));
    }

    return ListView.builder(
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        return SessionListItem(
          session: session,
          onTap: () {
            // Aqui abriremos os detalhes futuramente
          },
        );
      },
    );
  }
}