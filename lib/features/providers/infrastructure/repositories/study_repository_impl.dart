import 'package:flutter/foundation.dart'; // <--- CORREÇÃO: Import necessário para debugPrint
import '../../domain/entities/study_session.dart';
import '../../domain/repositories/study_repository.dart';
import '../mappers/study_session_mapper.dart';
import '../local/study_local_datasource.dart';
import '../remote/study_remote_datasource.dart';

class StudyRepositoryImpl implements StudyRepository {
  final StudyRemoteDataSource remoteDataSource;
  final StudyLocalDataSource localDataSource;

  StudyRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<void> saveSession(StudySession session) async {
    final dto = StudySessionMapper.toDto(session);
    
    await remoteDataSource.createSession(dto);
    
    final updatedList = await remoteDataSource.getHistory();
    await localDataSource.cacheHistory(updatedList);
  }

  @override
  Future<List<StudySession>> getSessionHistory() async {
    try {
      final remoteDtos = await remoteDataSource.getHistory();
      
      await localDataSource.cacheHistory(remoteDtos);
      
      return remoteDtos.map((dto) => StudySessionMapper.toEntity(dto)).toList();
    } catch (e) {
      // CORREÇÃO: debugPrint em vez de print
      debugPrint("Sem internet? Carregando do cache local...");
      final localDtos = await localDataSource.getLastHistory();
      return localDtos.map((dto) => StudySessionMapper.toEntity(dto)).toList();
    }
  }
  
  @override
  Future<int> getTodayStudyMinutes() async {
    final history = await getSessionHistory();
    final now = DateTime.now();
    
    final todaySessions = history.where((s) {
      return s.date.year == now.year &&
             s.date.month == now.month &&
             s.date.day == now.day &&
             s.type == 'FOCUS';
    });

    return todaySessions.fold<int>(0, (int sum, StudySession item) {
      return sum + item.durationMinutes;
    });
  }
}