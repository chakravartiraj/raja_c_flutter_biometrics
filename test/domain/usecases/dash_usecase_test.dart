import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:raja_c_flutter_biometrics/core/errors/failures.dart';
import 'package:raja_c_flutter_biometrics/domain/entities/dash_entity.dart';
import 'package:raja_c_flutter_biometrics/domain/repositories/dash_repository.dart';
import 'package:raja_c_flutter_biometrics/domain/usecases/dash_usecase.dart';

class MockDashboardRepository implements DashboardRepository {
  @override
  Future<Either<Failure, DashboardEntity>> getDashboardData() async {
    // Return a valid Either<Failure, DashboardEntity>
    return Left(ServerFailure('error'));
  }
}

void main() {
  test('DashboardUseCase calls repository', () async {
    final usecase = DashboardUseCase(MockDashboardRepository());
    final result = await usecase.getDashboardData();
    expect(result, isA<Either<Failure, DashboardEntity>>());
  });
}
