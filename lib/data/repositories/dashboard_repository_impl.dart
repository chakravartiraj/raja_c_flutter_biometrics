import 'package:dartz/dartz.dart';
import 'package:raja_c_flutter_biometrics/core/errors/failures.dart';
import 'package:raja_c_flutter_biometrics/domain/entities/dash_entity.dart';
import 'package:raja_c_flutter_biometrics/domain/repositories/dash_repository.dart';

import '../../domain/entities/progress_entity.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/entities/user_entity.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  @override
  Future<Either<Failure, DashboardEntity>> getDashboardData() async {
    // Mock user
    final user = const UserEntity(
      id: '1',
      name: 'Jane Doe',
      email: 'jane.doe@example.com',
      avatarUrl: null,
    );

    // Mock projects
    final projects = [
      const ProjectEntity(
        id: 'p1',
        title: 'Project #1',
        description: 'Back End Development',
        date: '2025-07-10',
        status: 'Active',
        progress: 0.7,
      ),
      //TODO: Another user-case came to mind, will work on it later
      /*const ProjectEntity(
        id: 'p1',
        title: 'Project #1',
        description: 'Back End Development',
        date: '2025-07-11',
        status: 'Completed',
        progress: 1.0,
      ),*/
      const ProjectEntity(
        id: 'p2',
        title: 'Project #2',
        description: 'API Development',
        date: '2025-07-11',
        status: 'Active',
        progress: 0.7,
      ),
      const ProjectEntity(
        id: 'p3',
        title: 'Project #3',
        description: 'Mobile App Development',
        date: '2025-07-12',
        status: 'Active',
        progress: 0.7,
      ),
    ];

    // Mock progress items
    final progressItems = [
      const ProgressEntity(
        id: 'pr1',
        title: 'Milestone 1',
        subtitle: 'Completed milestone',
        timestamp: '2025-07-09T10:00:00Z',
        type: 'milestone',
      ),
      const ProgressEntity(
        id: 'pr2',
        title: 'Task 1',
        subtitle: 'Ongoing task',
        timestamp: '2025-07-11T14:30:00Z',
        type: 'task',
      ),
    ];

    // Mock dashboard entity
    final dashboard = DashboardEntity(
      userData: user,
      selectedTab: 'My tasks', // Always select the first tab
      projects: projects,
      progressItems: progressItems,
    );

    // Return mock data
    return Right(dashboard);
  }
}
