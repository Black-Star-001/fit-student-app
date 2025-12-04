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
    debugPrint('🔵 [SaveSession] Iniciando salvamento da sessão: ${session.durationMinutes} min');
    final dto = StudySessionMapper.toDto(session);
    
    try {
      debugPrint('📤 [SaveSession] Enviando para Supabase...');
      await remoteDataSource.createSession(dto);
      debugPrint('✅ [SaveSession] Salvo no Supabase com sucesso');
      
      debugPrint('🔄 [SaveSession] Buscando histórico atualizado...');
      final updatedList = await remoteDataSource.getHistory();
      debugPrint('💾 [SaveSession] Cacheando ${updatedList.length} sessões localmente');
      await localDataSource.cacheHistory(updatedList);
      debugPrint('✅ [SaveSession] Histórico cacheado com sucesso');
    } catch (e) {
      debugPrint('❌ [SaveSession] Erro: $e');
      rethrow;
    }
  }

  @override
  Future<List<StudySession>> getSessionHistory() async {
    debugPrint('🔵 [GetHistory] Buscando histórico de sessões...');
    try {
      debugPrint('📥 [GetHistory] Tentando buscar do Supabase...');
      final remoteDtos = await remoteDataSource.getHistory();
      debugPrint('✅ [GetHistory] Obtidas ${remoteDtos.length} sessões do Supabase');
      
      debugPrint('💾 [GetHistory] Cacheando dados localmente...');
      await localDataSource.cacheHistory(remoteDtos);
      debugPrint('✅ [GetHistory] Cache atualizado');
      
      return remoteDtos.map((dto) => StudySessionMapper.toEntity(dto)).toList();
    } catch (e) {
      debugPrint('⚠️ [GetHistory] Erro ao buscar do Supabase: $e');
      debugPrint('🔄 [GetHistory] Carregando do cache local...');
      final localDtos = await localDataSource.getLastHistory();
      debugPrint('✅ [GetHistory] Obtidas ${localDtos.length} sessões do cache local');
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