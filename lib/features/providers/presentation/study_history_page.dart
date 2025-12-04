import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/entities/study_session.dart';
import '../domain/repositories/study_repository.dart';
import 'widgets/session_list_view.dart';
import 'widgets/study_fab_area.dart';
import 'dialogs/session_form_dialog.dart';

class StudyHistoryPage extends StatefulWidget {
  const StudyHistoryPage({super.key});

  @override
  State<StudyHistoryPage> createState() => _StudyHistoryPageState();
}

class _StudyHistoryPageState extends State<StudyHistoryPage> {
  late List<StudySession> _sessions = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    setState(() => _isLoading = true);
    try {
      final repository = context.read<StudyRepository>();
      final sessions = await repository.getSessionHistory();
      setState(() {
        _sessions = sessions;
      });
    } catch (e) {
      debugPrint('Erro ao carregar sessões: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar histórico: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Estudos')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SessionListView(sessions: _sessions),
      floatingActionButton: StudyFabArea(
        onPressed: () async {
          // Abre o formulário
          final result = await showDialog<int>(
            context: context,
            builder: (_) => const SessionFormDialog(),
          );
          
          if (result != null && result > 0) {
            // Salva no repositório (que sincroniza com Supabase e cache)
            try {
              final repository = context.read<StudyRepository>();
              final newSession = StudySession(
                id: DateTime.now().toString(),
                date: DateTime.now(),
                durationMinutes: result,
                type: 'FOCUS'
              );
              
              await repository.saveSession(newSession);
              
              // Recarrega o histórico para garantir sincronização
              await _loadSessions();
              
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sessão salva com sucesso!')),
                );
              }
            } catch (e) {
              debugPrint('Erro ao salvar sessão: $e');
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Erro ao salvar: $e')),
                );
              }
            }
          }
        },
      ),
    );
  }
}