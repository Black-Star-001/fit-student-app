import 'dart:convert'; 
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dtos/study_session_dto.dart';

// CORREÇÃO: Nome da variável em camelCase
const cachedStudyHistory = 'CACHED_STUDY_HISTORY';

class StudyLocalDataSource {
  Future<void> cacheHistory(List<StudySessionDto> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    
    debugPrint('🔵 [LocalDS] Cacheando ${sessions.length} sessões localmente');
    
    try {
      final jsonList = sessions.map((session) => session.toMap()).toList();
      
      // CORREÇÃO: Usando a variável renomeada
      await prefs.setString(cachedStudyHistory, json.encode(jsonList));
      
      debugPrint('✅ [LocalDS] ${sessions.length} sessões cacheadas com sucesso');
    } catch (e) {
      debugPrint('❌ [LocalDS] Erro ao cachear: $e');
      rethrow;
    }
  }

  Future<List<StudySessionDto>> getLastHistory() async {
    final prefs = await SharedPreferences.getInstance();
    
    debugPrint('🔵 [LocalDS] Carregando histórico do cache local');
    
    try {
      // CORREÇÃO: Usando a variável renomeada
      final jsonString = prefs.getString(cachedStudyHistory);

      if (jsonString != null) {
        final List decodedList = json.decode(jsonString);
        final sessions = decodedList.map((jsonItem) => StudySessionDto.fromMap(jsonItem)).toList();
        
        debugPrint('✅ [LocalDS] ${sessions.length} sessões carregadas do cache');
        
        return sessions;
      } else {
        debugPrint('⚠️ [LocalDS] Nenhum cache encontrado');
        return [];
      }
    } catch (e) {
      debugPrint('❌ [LocalDS] Erro ao carregar do cache: $e');
      return [];
    }
  }
}