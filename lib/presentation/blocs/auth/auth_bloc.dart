import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raja_c_flutter_biometrics/core/repositories/biometric_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final BiometricRepository _biometricRepository;

  AuthBloc({
    required BiometricRepository biometricRepository,
  })  : _biometricRepository = biometricRepository,
        super(AuthInitialState()) {
    on<AuthInitializeEvent>(_onInitialize);
    on<AuthenticateWithBiometricEvent>(_onAuthenticateWithBiometric);
    on<AuthResetEvent>(_onReset);
  }

  Future<void> _onInitialize(
    AuthInitializeEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoadingState());

      final isDeviceSupported = await _biometricRepository.isDeviceSupported();
      final canCheckBiometrics = await _biometricRepository.canCheckBiometrics();

      if (!isDeviceSupported || !canCheckBiometrics) {
        emit(AuthUnsupportedState());
        return;
      }

      final availableBiometrics = await _biometricRepository.getAvailableBiometrics();

      emit(AuthBiometricsAvailableState(
        availableBiometrics: availableBiometrics,
        canCheckBiometrics: canCheckBiometrics,
        isDeviceSupported: isDeviceSupported,
      ));
    } catch (e) {
      emit(const AuthErrorState(errorMessage: 'Failed to initialize biometric authentication'));
    }
  }

  Future<void> _onAuthenticateWithBiometric(
    AuthenticateWithBiometricEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthAuthenticatingState(biometricType: event.biometricType));

      final result = await _biometricRepository.authenticateWithBiometric(event.biometricType);

      if (result.isSuccess && result.authenticatedWith != null) {
        emit(AuthSuccessState(authenticatedWith: result.authenticatedWith!));
      } else {
        emit(AuthErrorState(errorMessage: result.errorMessage ?? 'Authentication failed'));
      }
    } catch (e) {
      emit(const AuthErrorState(errorMessage: 'An unexpected error occurred'));
    }
  }

  Future<void> _onReset(
    AuthResetEvent event,
    Emitter<AuthState> emit,
  ) async {
    add(AuthInitializeEvent());
  }
}