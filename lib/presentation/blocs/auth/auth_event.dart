import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthInitializeEvent extends AuthEvent {}

// Refrained from using separate events named FaceIdRequested and FingerprintRequested,
// Because your existing AuthenticateWithBiometricEvent already supports both by using the BiometricType parameter.
// This approach is flexible and avoids code duplication.
class AuthenticateWithBiometricEvent extends AuthEvent {
  final BiometricType biometricType;

  const AuthenticateWithBiometricEvent({required this.biometricType});

  @override
  List<Object?> get props => [biometricType];
}

class AuthResetEvent extends AuthEvent {}
