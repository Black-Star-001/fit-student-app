import '../../domain/entities/hydration.dart';
import '../dtos/hydration_dto.dart';

class HydrationMapper {
  static Hydration toEntity(HydrationDto dto) {
    return Hydration(
      id: dto.id,
      date: DateTime.tryParse(dto.data_registro) ?? DateTime.now(),
      waterIntakeMl: dto.ml_consumidos,
      dailyGoalMl: dto.meta_diaria_ml,
    );
  }

  static HydrationDto toDto(Hydration entity) {
    return HydrationDto(
      id: entity.id,
      data_registro: entity.date.toIso8601String(),
      ml_consumidos: entity.waterIntakeMl,
      meta_diaria_ml: entity.dailyGoalMl,
    );
  }
}