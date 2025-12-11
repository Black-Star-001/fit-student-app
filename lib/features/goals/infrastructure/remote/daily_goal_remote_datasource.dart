import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../dtos/daily_goal_dto.dart';

class DailyGoalRemoteDataSource {
  final SupabaseClient supabase;
  DailyGoalRemoteDataSource(this.supabase);

  // Busca a meta de HOJE
  Future<DailyGoalDto?> getTodayGoal() async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;

    final today = DateTime.now().toIso8601String().split('T')[0];

    final response = await supabase
        .from('meta_diaria')
        .select()
        .eq('usuario_id', user.id)
        .ilike('data', '$today%')
        .limit(1) // <--- ADICIONE ESSA LINHA (O Segredo!)
        .maybeSingle();

    if (response == null) return null;
    return DailyGoalDto.fromMap(response);
  }

  // Cria ou Atualiza a meta
  Future<void> saveGoal(DailyGoalDto dto) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    debugPrint("🎯 Salvando meta: ${dto.minutos_atuais}/${dto.meta_minutos}");

    await supabase.from('meta_diaria').upsert({
      if (dto.id.isNotEmpty) 'id': int.parse(dto.id),
      'usuario_id': user.id,
      'data': dto.data,
      'meta_minutos': dto.meta_minutos,
      'minutos_atuais': dto.minutos_atuais,
      'concluido': dto.concluido,
    });
  }
}