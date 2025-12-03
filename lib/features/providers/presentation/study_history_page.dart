import 'package:flutter/material.dart';
import '../domain/entities/study_session.dart';
import 'widgets/session_list_view.dart';
import 'widgets/study_fab_area.dart';
import 'dialogs/session_form_dialog.dart';

class StudyHistoryPage extends StatefulWidget {
  const StudyHistoryPage({super.key});

  @override
  State<StudyHistoryPage> createState() => _StudyHistoryPageState();
}

class _StudyHistoryPageState extends State<StudyHistoryPage> {
  // Lista temporária (mock) só para ver a tela funcionando
  final List<StudySession> _sessions = [
    StudySession(id: '1', date: DateTime.now(), durationMinutes: 25, type: 'FOCUS'),
    StudySession(id: '2', date: DateTime.now().subtract(const Duration(hours: 1)), durationMinutes: 5, type: 'BREAK'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Estudos')),
      body: SessionListView(sessions: _sessions),
      floatingActionButton: StudyFabArea(
        onPressed: () async {
          // Abre o formulário
          final result = await showDialog<int>(
            context: context,
            builder: (_) => const SessionFormDialog(),
          );
          
          if (result != null) {
            // Adiciona na lista visualmente (depois conectamos ao Supabase)
            setState(() {
              _sessions.insert(0, StudySession(
                id: DateTime.now().toString(),
                date: DateTime.now(),
                durationMinutes: result,
                type: 'FOCUS'
              ));
            });
          }
        },
      ),
    );
  }
}