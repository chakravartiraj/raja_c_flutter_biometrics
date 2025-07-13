import 'package:equatable/equatable.dart';
import 'user_entity.dart';
import 'project_entity.dart';
import 'progress_entity.dart';

class DashboardEntity extends Equatable {
  final UserEntity userData;
  final String selectedTab;
  final List<ProjectEntity> projects;
  final List<ProgressEntity> progressItems;

  const DashboardEntity({
    required this.userData,
    required this.selectedTab,
    required this.projects,
    required this.progressItems,
  });

  DashboardEntity copyWith({
    UserEntity? userData,
    String? selectedTab,
    List<ProjectEntity>? projects,
    List<ProgressEntity>? progressItems,
  }) {
    return DashboardEntity(
      userData: userData ?? this.userData,
      selectedTab: selectedTab ?? this.selectedTab,
      projects: projects ?? this.projects,
      progressItems: progressItems ?? this.progressItems,
    );
  }

  @override
  List<Object?> get props => [userData, selectedTab, projects, progressItems];
}
