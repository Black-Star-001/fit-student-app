import '../../domain/entities/hydration.dart';
import '../mappers/hydration_mapper.dart';
import '../remote/hydration_remote_datasource.dart';

class HydrationRepositoryImpl {
  final HydrationRemoteDataSource remoteDataSource;

  HydrationRepositoryImpl(this.remoteDataSource);

  Future<void> saveHydration(Hydration hydration) async {
    final dto = HydrationMapper.toDto(hydration);
    await remoteDataSource.saveHydration(dto);
  }

  Future<Hydration?> getTodayHydration() async {
    final dtos = await remoteDataSource.getHydrationHistory();
    if (dtos.isEmpty) return null;
    // Pega o mais recente (primeiro da lista)
    return HydrationMapper.toEntity(dtos.first);
  }
}