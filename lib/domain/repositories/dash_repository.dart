import 'package:dartz/dartz.dart';
import 'package:raja_c_flutter_biometrics/core/errors/failures.dart';
import '../entities/dash_entity.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardEntity>> getDashboardData();
}
