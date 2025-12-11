import 'package:flutter/foundation.dart'; // Para debugPrint
import 'package:supabase_flutter/supabase_flutter.dart';
import '../dtos/achievement_dto.dart';

class AchievementRemoteDataSource {
  final SupabaseClient supabase;
  AchievementRemoteDataSource(this.supabase);

  // 1. Busca conquistas do usuário
  Future<List<AchievementDto>> getAchievements() async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    final response = await supabase
        .from('conquista') // Nome da tabela em Português
        .select()
        .eq('usuario_id', user.id);

    return (response as List).map((e) => AchievementDto.fromMap(e)).toList();
  }
  
  // 2. Cria conquistas iniciais (Seed) se o aluno for novo
  Future<void> seedAchievements() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;
    
    // Verifica se já tem alguma coisa
    final exists = await getAchievements();
    if (exists.isNotEmpty) return;

    debugPrint('🏆 Criando conquistas padrão para o usuário...');

    // Cria as medalhas bloqueadas (Padrão)
    await supabase.from('conquista').insert([
      {
        'usuario_id': user.id, 
        'titulo': 'Primeiro Passo', 
        'descricao': 'Complete sua primeira sessão de estudo.', 
        'nome_icone': 'star', 
        'desbloqueada': false
      },
      {
        'usuario_id': user.id, 
        'titulo': 'Hidratado', 
        'descricao': 'Beba 2L de água em um dia.', 
        'nome_icone': 'water_drop', 
        'desbloqueada': false
      },
      {
        'usuario_id': user.id, 
        'titulo': 'Focado', 
        'descricao': 'Acumule 100 minutos de estudo.', 
        'nome_icone': 'timer', 
        'desbloqueada': false
      },
    ]);
  }
}