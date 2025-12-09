import '../../domain/entities/daily_goal.dart';
import '../dtos/daily_goal_dto.dart';

class DailyGoalMapper {
  // DTO (Infra) -> Entity (Domínio)
  static DailyGoal toEntity(DailyGoalDto dto) {
    return DailyGoal(
      id: dto.id,
      // Converte String do banco para Data do Dart
      date: DateTime.tryParse(dto.data) ?? DateTime.now(),
      targetMinutes: dto.meta_minutos,
      currentMinutes: dto.minutos_atuais,
      isCompleted: dto.concluido,
    );
  }

  // Entity (Domínio) -> DTO (Infra)
  static DailyGoalDto toDto(DailyGoal entity) {
    return DailyGoalDto(
      id: entity.id,
      // Converte Data do Dart para String do banco
      data: entity.date.toIso8601String(),
      meta_minutos: entity.targetMinutes,
      minutos_atuais: entity.currentMinutes,
      concluido: entity.isCompleted,
    );
  }
}