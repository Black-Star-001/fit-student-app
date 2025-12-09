// 1. EXERCISE
import 'features/exercises/infrastructure/dtos/exercise_dto.dart';
import 'features/exercises/infrastructure/mappers/exercise_mapper.dart';

// 2. DAILY GOAL
import 'features/goals/infrastructure/dtos/daily_goal_dto.dart';
import 'features/goals/infrastructure/mappers/daily_goal_mapper.dart';

// 3. ACHIEVEMENT
import 'features/achievements/infrastructure/dtos/achievement_dto.dart';
import 'features/achievements/infrastructure/mappers/achievement_mapper.dart';

// 4. HYDRATION
import 'features/hydration/infrastructure/dtos/hydration_dto.dart';
import 'features/hydration/infrastructure/mappers/hydration_mapper.dart';

void main() {
  print('=== 🚀 INICIANDO BATERIA DE TESTES DAS 4 ENTIDADES ===\n');

  // --- TESTE 1: EXERCISE ---
  print('--- 1. EXERCISE (Exercício) ---');
  final exerciseDto = ExerciseDto.fromMap({
    'id': '101', 'titulo': 'Alongamento', 'descricao': 'Pescoço', 
    'url_video': '...', 'duracao_seg': 30
  });
  final exEntity = ExerciseMapper.toEntity(exerciseDto);
  print('✅ Mapeado: ${exEntity.title} (${exEntity.durationSeconds}s)');
  
  
  // --- TESTE 2: DAILY GOAL (Meta) ---
  print('\n--- 2. DAILY GOAL (Meta Diária) ---');
  final goalDto = DailyGoalDto.fromMap({
    'id': '500', 'data': '2025-12-05T00:00:00.000', 
    'meta_minutos': 120, 'minutos_atuais': 60, 'concluido': false
  });
  final goalEntity = DailyGoalMapper.toEntity(goalDto);
  print('✅ Mapeado: Meta de ${goalEntity.targetMinutes}min (Progresso: ${goalEntity.currentMinutes}min)');


  // --- TESTE 3: ACHIEVEMENT (Conquista) ---
  print('\n--- 3. ACHIEVEMENT (Conquista) ---');
  final achDto = AchievementDto.fromMap({
    'id': 'trophy_01', 'titulo': 'Primeira Sessão', 'descricao': '...', 
    'nome_icone': 'star', 'desbloqueada': true, 'desbloqueada_em': '2025-12-01T10:00:00.000'
  });
  final achEntity = AchievementMapper.toEntity(achDto);
  print('✅ Mapeado: ${achEntity.title} (Desbloqueado? ${achEntity.isUnlocked})');


  // --- TESTE 4: HYDRATION (Hidratação) ---
  print('\n--- 4. HYDRATION (Hidratação) ---');
  // Simulando dados vindos do Banco de Dados (em Português)
  final hydroDto = HydrationDto.fromMap({
    'id': 'h1', 
    'data_registro': '2025-12-08T14:30:00.000', 
    'ml_consumidos': 250, 
    'meta_diaria_ml': 2000
  });
  
  // 1. DTO -> Entity
  final hydroEntity = HydrationMapper.toEntity(hydroDto);
  print('✅ Entity Criada: Bebeu ${hydroEntity.waterIntakeMl}ml / Meta ${hydroEntity.dailyGoalMl}ml');
  
  // 2. Entity -> DTO (Volta)
  final backToHydroDto = HydrationMapper.toDto(hydroEntity);
  print('✅ Volta DTO: ${backToHydroDto.ml_consumidos}ml na data ${backToHydroDto.data_registro}');
  
  print('\n🎉 SUCESSO ABSOLUTO! TODAS AS 4 ENTIDADES ESTÃO FUNCIONAIS.');
}