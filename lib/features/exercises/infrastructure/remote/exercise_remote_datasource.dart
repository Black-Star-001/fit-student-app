import 'package:supabase_flutter/supabase_flutter.dart';
import '../dtos/exercise_dto.dart';

class ExerciseRemoteDataSource {
  final SupabaseClient supabase;
  ExerciseRemoteDataSource(this.supabase);

  Future<List<ExerciseDto>> getExercises() async {
    // Busca todos os exercícios cadastrados
    final response = await supabase.from('exercicio').select();
    return (response as List).map((e) => ExerciseDto.fromMap(e)).toList();
  }
}