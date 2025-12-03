import '../../domain/entities/study_session.dart';
import '../../domain/repositories/study_repository.dart';
import '../mappers/study_session_mapper.dart';
import '../remote/study_remote_datasource.dart';

class StudyRepositoryImpl implements StudyRepository {
  final StudyRemoteDataSource remoteDataSource;

  StudyRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> saveSession(StudySession session) async {
    final dto = StudySessionMapper.toDto(session);
    await remoteDataSource.createSession(dto);
  }

  @override
  Future<List<StudySession>> getSessionHistory() async {
    final dtos = await remoteDataSource.getHistory();
    return dtos.map((dto) => StudySessionMapper.toEntity(dto)).toList();
  }
  
  @override
  Future<int> getTodayStudyMinutes() async {
    // 1. Busca todo o histórico
    final history = await getSessionHistory();
    final now = DateTime.now();
    
    // 2. Filtra apenas sessões de HOJE e do tipo FOCUS
    final todaySessions = history.where((s) {
      return s.date.year == now.year &&
             s.date.month == now.month &&
             s.date.day == now.day &&
             s.type == 'FOCUS';
    });

    // 3. Soma os minutos (CORREÇÃO AQUI: adicionamos <int> e tipamos o sum)
    // O erro acontecia porque o Dart se perdia no tipo da variável 'sum'
    return todaySessions.fold<int>(0, (int sum, StudySession item) {
      return sum + item.durationMinutes;
    });
  }
}