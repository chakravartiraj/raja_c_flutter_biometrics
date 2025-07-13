import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raja_c_flutter_biometrics/core/errors/failures.dart';
import 'package:flutter/foundation.dart';
import 'package:raja_c_flutter_biometrics/domain/usecases/dash_usecase.dart';
import 'dash_event.dart';
import 'dash_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardUseCase _dashboardUseCase;

  DashboardBloc({required DashboardUseCase dashboardUseCase})
    : _dashboardUseCase = dashboardUseCase,
      super(const DashboardInitialState()) {
    on<LoadDashboardEvent>(_onLoadDashboard);
    on<ChangeTabEvent>(_onChangeTab);
    on<RefreshDashboardEvent>(_onRefreshDashboard);
  }

  Future<void> _onLoadDashboard(LoadDashboardEvent event, Emitter<DashboardState> emit) async {
    try {
      emit(const DashboardLoadingState());
      final result = await _dashboardUseCase.getDashboardData();
      result.fold(
        (failure) => emit(DashboardErrorState(_mapFailureToMessage(failure))),
        (dashboardData) => emit(DashboardLoadedState(dashboardData)),
      );
    } catch (e, stack) {
      debugPrint('Exception in _onLoadDashboard: $e\n$stack');
      emit(DashboardErrorState('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onChangeTab(ChangeTabEvent event, Emitter<DashboardState> emit) async {
    if (state is DashboardLoadedState) {
      final currentState = state as DashboardLoadedState;
      final updatedData = currentState.dashboardData.copyWith(selectedTab: event.tab);
      emit(DashboardLoadedState(updatedData));
    }
  }

  Future<void> _onRefreshDashboard(RefreshDashboardEvent event, Emitter<DashboardState> emit) async {
    // Keep current state visible while refreshing
    if (state is DashboardLoadedState) {
      try {
        final result = await _dashboardUseCase.getDashboardData();
        result.fold(
          (failure) => emit(DashboardErrorState(_mapFailureToMessage(failure))),
          (dashboardData) => emit(DashboardLoadedState(dashboardData)),
        );
      } catch (e, stack) {
        debugPrint('Exception in _onRefreshDashboard: $e\n$stack');
        emit(const DashboardErrorState('Failed to refresh dashboard'));
      }
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return 'Server error occurred. Please try again.';
      case const (NetworkFailure):
        return 'Network error. Please check your connection.';
      case const (CacheFailure):
        return 'Cache error occurred.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
