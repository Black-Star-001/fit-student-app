import 'package:supabase_flutter/supabase_flutter.dart';
import '../dtos/study_session_dto.dart';

class StudyRemoteDataSource {
  final SupabaseClient supabase;

  StudyRemoteDataSource(this.supabase);

  // SALVAR NO SUPABASE
  Future<void> createSession(StudySessionDto session) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Usuário não logado');

    await supabase.from('sessao_estudo').insert({
      'usuario_id': user.id,
      'duracao': session.durationMinutes,
      'tipo': session.type,
      // CORREÇÃO CRUCIAL: O nome da coluna no seu banco é 'criado_em'
      'criado_em': DateTime.now().toIso8601String(),
    });
  }

  // BUSCAR DO SUPABASE
  Future<List<StudySessionDto>> getHistory() async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    final response = await supabase
        .from('sessao_estudo')
        .select()
        .eq('usuario_id', user.id)
        // CORREÇÃO: Ordenar pela coluna certa
        .order('criado_em', ascending: false);

    return (response as List)
        .map((e) => StudySessionDto.fromMap(e))
        .toList();
  }
}