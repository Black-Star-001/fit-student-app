import '../../domain/entities/achievement.dart';
import '../dtos/achievement_dto.dart';

class AchievementMapper {
  static Achievement toEntity(AchievementDto dto) {
    return Achievement(
      id: dto.id,
      title: dto.titulo,
      description: dto.descricao,
      iconName: dto.nome_icone,
      isUnlocked: dto.desbloqueada,
      // Converte String ISO para DateTime se não for nulo
      unlockedAt: dto.desbloqueada_em != null 
          ? DateTime.tryParse(dto.desbloqueada_em!) 
          : null,
    );
  }

  static AchievementDto toDto(Achievement entity) {
    return AchievementDto(
      id: entity.id,
      titulo: entity.title,
      descricao: entity.description,
      nome_icone: entity.iconName,
      desbloqueada: entity.isUnlocked,
      // Converte DateTime para String ISO se não for nulo
      desbloqueada_em: entity.unlockedAt?.toIso8601String(),
    );
  }
}