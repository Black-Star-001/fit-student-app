import '../../domain/entities/daily_goal.dart';
import '../dtos/daily_goal_dto.dart';
import '../mappers/daily_goal_mapper.dart';
import '../remote/daily_goal_remote_datasource.dart';

class DailyGoalRepositoryImpl {
  final DailyGoalRemoteDataSource remoteDataSource;

  DailyGoalRepositoryImpl(this.remoteDataSource);

  Future<DailyGoal?> getTodayGoal() async {
    final dto = await remoteDataSource.getTodayGoal();
    if (dto == null) return null;
    return DailyGoalMapper.toEntity(dto);
  }

  Future<void> saveGoal(DailyGoal goal) async {
    final dto = DailyGoalMapper.toDto(goal);
    await remoteDataSource.saveGoal(dto);
  }
}