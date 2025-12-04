import 'dart:convert'; 
import 'package:shared_preferences/shared_preferences.dart';
import '../dtos/study_session_dto.dart';

// CORREÇÃO: Nome da variável em camelCase
const cachedStudyHistory = 'CACHED_STUDY_HISTORY';

class StudyLocalDataSource {
  Future<void> cacheHistory(List<StudySessionDto> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    
    final jsonList = sessions.map((session) => session.toMap()).toList();
    
    // CORREÇÃO: Usando a variável renomeada
    await prefs.setString(cachedStudyHistory, json.encode(jsonList));
  }

  Future<List<StudySessionDto>> getLastHistory() async {
    final prefs = await SharedPreferences.getInstance();
    // CORREÇÃO: Usando a variável renomeada
    final jsonString = prefs.getString(cachedStudyHistory);

    if (jsonString != null) {
      final List decodedList = json.decode(jsonString);
      return decodedList.map((jsonItem) => StudySessionDto.fromMap(jsonItem)).toList();
    } else {
      return [];
    }
  }
}