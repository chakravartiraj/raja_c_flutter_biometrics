import 'package:dartz/dartz.dart';
import 'package:raja_c_flutter_biometrics/core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/dash_entity.dart';
import '../repositories/dash_repository.dart';

class DashboardUseCase implements UseCase<DashboardEntity, NoParams> {
  final DashboardRepository repository;

  DashboardUseCase(this.repository);

  @override
  Future<Either<Failure, DashboardEntity>> call(NoParams params) async {
    return await repository.getDashboardData();
  }

  Future<Either<Failure, DashboardEntity>> getDashboardData() async {
    return await repository.getDashboardData();
  }
}
