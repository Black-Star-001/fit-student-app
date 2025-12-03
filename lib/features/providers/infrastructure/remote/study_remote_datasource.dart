import 'package:supabase_flutter/supabase_flutter.dart';
import '../dtos/study_session_dto.dart';

class StudyRemoteDataSource {
  final SupabaseClient supabase;

  StudyRemoteDataSource(this.supabase);

  Future<void> createSession(StudySessionDto session) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Usuário não logado');

    await supabase.from('study_sessions').insert({
      ...session.toMap(),
      'user_id': user.id, // Vincula ao aluno logado
    });
  }

  Future<List<StudySessionDto>> getHistory() async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    final response = await supabase
        .from('study_sessions')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    return (response as List)
        .map((e) => StudySessionDto.fromMap(e))
        .toList();
  }
}