import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadDashboardEvent extends DashboardEvent {
  const LoadDashboardEvent();
}

class ChangeTabEvent extends DashboardEvent {
  final String tab;

  const ChangeTabEvent(this.tab);

  @override
  List<Object?> get props => [tab];
}

class RefreshDashboardEvent extends DashboardEvent {
  const RefreshDashboardEvent();
}