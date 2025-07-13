import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// Corresponds to AuthInitial
class AuthInitialState extends AuthState {}

// Corresponds to AuthLoading
class AuthLoadingState extends AuthState {}

// Corresponds to AuthSuccess
class AuthSuccessState extends AuthState {
  final BiometricType authenticatedWith;

  const AuthSuccessState({required this.authenticatedWith});

  @override
  List<Object?> get props => [authenticatedWith];
}

// Corresponds to AuthFailure
class AuthErrorState extends AuthState {
  final String errorMessage;

  const AuthErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

// Other States

// Corresponds to AuthBiometricsAvailable
class AuthBiometricsAvailableState extends AuthState {
  final List<BiometricType> availableBiometrics;
  final bool canCheckBiometrics;
  final bool isDeviceSupported;

  const AuthBiometricsAvailableState({
    required this.availableBiometrics,
    required this.canCheckBiometrics,
    required this.isDeviceSupported,
  });

  @override
  List<Object?> get props => [
    availableBiometrics,
    canCheckBiometrics,
    isDeviceSupported,
  ];
}

// Corresponds to AuthBiometricsNotAvailable
class AuthAuthenticatingState extends AuthState {
  final BiometricType biometricType;

  const AuthAuthenticatingState({required this.biometricType});

  @override
  List<Object?> get props => [biometricType];
}

// Corresponds to AuthBiometricsNotAvailable
class AuthUnsupportedState extends AuthState {}
