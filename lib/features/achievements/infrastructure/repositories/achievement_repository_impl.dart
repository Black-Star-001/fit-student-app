import '../../domain/entities/achievement.dart';
import '../mappers/achievement_mapper.dart';
import '../remote/achievement_remote_datasource.dart';

class AchievementRepositoryImpl {
  final AchievementRemoteDataSource remoteDataSource;

  AchievementRepositoryImpl(this.remoteDataSource);

  Future<List<Achievement>> getMyAchievements() async {
    // Garante que as conquistas existam (Seed)
    await remoteDataSource.seedAchievements();
    
    final dtos = await remoteDataSource.getAchievements();
    return dtos.map((dto) => AchievementMapper.toEntity(dto)).toList();
  }
}