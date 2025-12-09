import '../../domain/entities/exercise.dart';
import '../dtos/exercise_dto.dart';

class ExerciseMapper {
  // Transforma DTO (Infra) -> Entity (Domínio)
  static Exercise toEntity(ExerciseDto dto) {
    return Exercise(
      id: dto.id,
      title: dto.titulo,
      description: dto.descricao,
      videoUrl: dto.url_video,
      durationSeconds: dto.duracao_seg,
    );
  }

  // Transforma Entity (Domínio) -> DTO (Infra)
  static ExerciseDto toDto(Exercise entity) {
    return ExerciseDto(
      id: entity.id,
      titulo: entity.title,
      descricao: entity.description,
      url_video: entity.videoUrl,
      duracao_seg: entity.durationSeconds,
    );
  }
}