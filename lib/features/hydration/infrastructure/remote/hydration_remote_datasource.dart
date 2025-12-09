import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../dtos/hydration_dto.dart';

class HydrationRemoteDataSource {
  final SupabaseClient supabase;

  HydrationRemoteDataSource(this.supabase);

  // SALVAR HIDRATAÇÃO
  Future<void> saveHydration(HydrationDto hydration) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Usuário não logado');

    debugPrint('💧 [Hydration] Salvando registro: ${hydration.ml_consumidos}ml');

    await supabase.from('hidratacao').insert({
      'usuario_id': user.id, // Vincula ao usuário logado
      'data_registro': hydration.data_registro,
      'ml_consumidos': hydration.ml_consumidos,
      'meta_diaria_ml': hydration.meta_diaria_ml,
    });
    
    debugPrint('✅ [Hydration] Salvo com sucesso!');
  }

  // BUSCAR DO BANCO
  Future<List<HydrationDto>> getHydrationHistory() async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    final response = await supabase
        .from('hidratacao')
        .select()
        .eq('usuario_id', user.id)
        .order('data_registro', ascending: false);

    return (response as List)
        .map((e) => HydrationDto.fromMap(e))
        .toList();
  }
}