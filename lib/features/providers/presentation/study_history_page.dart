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
  List<StudySession> _sessions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  // Essa função busca os dados (Local + Remoto)
  Future<void> _loadSessions() async {
    try {
      final repository = context.read<StudyRepository>();
      final sessions = await repository.getSessionHistory();
      
      if (mounted) {
        setState(() {
          _sessions = sessions;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar: $e')),
        );
      }
    }
  }

  Future<void> _addNewSession(int minutes) async {
    setState(() => _isLoading = true);
    
    final newSession = StudySession(
      id: '', 
      date: DateTime.now(),
      durationMinutes: minutes,
      type: 'FOCUS',
    );

    final repository = context.read<StudyRepository>();
    await repository.saveSession(newSession);

    await _loadSessions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Estudos')),
      
      // AQUI ESTÁ A MÁGICA DO REFRESH
      // O RefreshIndicator envolve o conteúdo da tela
      body: RefreshIndicator(
        // Quando arrastar, ele chama _loadSessions de novo
        onRefresh: _loadSessions, 
        color: Colors.white,
        backgroundColor: Colors.blue,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _sessions.isEmpty
                // Dica: ListView vazio precisa disso para o scroll funcionar e o refresh ativar
                ? ListView(
                    children: const [
                      SizedBox(height: 200),
                      Center(child: Text("Nenhum estudo registrado ainda."))
                    ],
                  )
                : SessionListView(sessions: _sessions),
      ),
      
      floatingActionButton: StudyFabArea(
        onPressed: () async {
          final result = await showDialog<int>(
            context: context,
            builder: (_) => const SessionFormDialog(),
          );
          
          if (result != null && result > 0) {
            await _addNewSession(result);
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sessão salva com sucesso!')),
              );
            }
          }
        },
      ),
    );
  }
}