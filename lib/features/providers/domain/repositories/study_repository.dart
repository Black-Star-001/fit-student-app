import '../entities/study_session.dart';

abstract class StudyRepository {
  // Salvar uma nova sessão de estudo ou pausa
  Future<void> saveSession(StudySession session);

  // Buscar o histórico de sessões do aluno
  Future<List<StudySession>> getSessionHistory();
  
  // Buscar estatísticas (ex: total de minutos estudados hoje)
  Future<int> getTodayStudyMinutes();
}