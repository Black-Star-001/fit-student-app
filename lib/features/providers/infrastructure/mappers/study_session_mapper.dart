import '../../domain/entities/study_session.dart';
import '../dtos/study_session_dto.dart';

class StudySessionMapper {
  static StudySession toEntity(StudySessionDto dto) {
    return StudySession(
      id: dto.id,
      date: DateTime.tryParse(dto.date) ?? DateTime.now(),
      durationMinutes: dto.durationMinutes,
      type: dto.type,
    );
  }

  static StudySessionDto toDto(StudySession entity) {
    return StudySessionDto(
      id: entity.id,
      date: entity.date.toIso8601String(),
      durationMinutes: entity.durationMinutes,
      type: entity.type,
    );
  }
}