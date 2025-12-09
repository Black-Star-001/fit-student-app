import '../../domain/entities/exercise.dart';
import '../mappers/exercise_mapper.dart';
import '../remote/exercise_remote_datasource.dart';

class ExerciseRepositoryImpl {
  final ExerciseRemoteDataSource remoteDataSource;

  ExerciseRepositoryImpl(this.remoteDataSource);

  Future<List<Exercise>> getAllExercises() async {
    final dtos = await remoteDataSource.getExercises();
    return dtos.map((dto) => ExerciseMapper.toEntity(dto)).toList();
  }
}