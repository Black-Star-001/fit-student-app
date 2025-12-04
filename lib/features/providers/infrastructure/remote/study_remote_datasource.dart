import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../dtos/study_session_dto.dart';

class StudyRemoteDataSource {
  final SupabaseClient supabase;

  StudyRemoteDataSource(this.supabase);

  // SALVAR NO SUPABASE
  Future<void> createSession(StudySessionDto session) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Usuário não logado');

    debugPrint('🔵 [RemoteDS] Salvando sessão para usuário: ${user.id}');
    
    try {
      await supabase.from('sessao_estudo').insert({
        'usuario_id': user.id,
        'duracao': session.durationMinutes,
        'tipo': session.type,
        'criado_em': DateTime.now().toIso8601String(),
      });
      
      debugPrint('✅ [RemoteDS] Sessão inserida com sucesso');
    } catch (e) {
      debugPrint('❌ [RemoteDS] Erro ao inserir: $e');
      rethrow;
    }
  }

  // BUSCAR DO SUPABASE
  Future<List<StudySessionDto>> getHistory() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      debugPrint('⚠️ [RemoteDS] Usuário não logado, retornando lista vazia');
      return [];
    }

    debugPrint('🔵 [RemoteDS] Buscando histórico para usuário: ${user.id}');
    
    try {
      final response = await supabase
          .from('sessao_estudo')
          .select()
          .eq('usuario_id', user.id)
          .order('criado_em', ascending: false);

      debugPrint('✅ [RemoteDS] ${response.length} sessões encontradas');
      
      return (response as List)
          .map((e) => StudySessionDto.fromMap(e))
          .toList();
    } catch (e) {
      debugPrint('❌ [RemoteDS] Erro ao buscar histórico: $e');
      rethrow;
    }
  }
}