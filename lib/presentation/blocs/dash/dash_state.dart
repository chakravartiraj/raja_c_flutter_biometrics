import 'package:equatable/equatable.dart';
import 'package:raja_c_flutter_biometrics/domain/entities/dash_entity.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitialState extends DashboardState {
  const DashboardInitialState();
}

class DashboardLoadingState extends DashboardState {
  const DashboardLoadingState();
}

class DashboardLoadedState extends DashboardState {
  final DashboardEntity dashboardData;

  const DashboardLoadedState(this.dashboardData);

  @override
  List<Object?> get props => [dashboardData];
}

class DashboardErrorState extends DashboardState {
  final String message;

  const DashboardErrorState(this.message);

  @override
  List<Object?> get props => [message];
}