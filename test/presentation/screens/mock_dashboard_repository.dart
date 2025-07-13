import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:raja_c_flutter_biometrics/core/errors/failures.dart';
import 'package:raja_c_flutter_biometrics/domain/entities/dash_entity.dart';
import 'package:raja_c_flutter_biometrics/domain/entities/progress_entity.dart';
import 'package:raja_c_flutter_biometrics/domain/entities/project_entity.dart';
import 'package:raja_c_flutter_biometrics/domain/entities/user_entity.dart';
import 'package:raja_c_flutter_biometrics/domain/repositories/dash_repository.dart';

class MockDashboardRepository extends Mock implements DashboardRepository {
  @override
  Future<Either<Failure, DashboardEntity>> getDashboardData() async {
    // Provide dummy data for all required fields
    return Right(
      DashboardEntity(
        userData: const UserEntity(
          id: '1',
          name: 'Test User',
          email: 'test@example.com',
        ),
        selectedTab: 'home',
        projects: const [
          ProjectEntity(
            id: 'p1',
            title: 'Project 1',
            description: 'Description',
            date: '2025-07-13',
            status: 'active',
            progress: 0.5,
          ),
        ],
        progressItems: const [
          ProgressEntity(
            id: 'pr1',
            title: 'Progress 1',
            subtitle: 'Started',
            timestamp: '2025-07-13T12:00:00Z',
            type: 'info',
          ),
        ],
      ),
    );
  }
}
