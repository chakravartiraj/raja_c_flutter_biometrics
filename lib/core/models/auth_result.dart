import 'package:local_auth/local_auth.dart';

/// Represents the result of a biometric authentication attempt
class AuthResult {
  final bool isSuccess;
  final String? errorMessage;
  final BiometricType? authenticatedWith;

  const AuthResult._({
    required this.isSuccess,
    this.errorMessage,
    this.authenticatedWith,
  });

  /// Creates a successful authentication result
  factory AuthResult.success(BiometricType type) {
    return AuthResult._(
      isSuccess: true,
      authenticatedWith: type,
    );
  }

  /// Creates a failed authentication result
  factory AuthResult.failure(String error) {
    return AuthResult._(
      isSuccess: false,
      errorMessage: error,
    );
  }

  @override
  String toString() {
    if (isSuccess) {
      return 'AuthResult.success(authenticatedWith: $authenticatedWith)';
    } else {
      return 'AuthResult.failure(errorMessage: $errorMessage)';
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthResult &&
        other.isSuccess == isSuccess &&
        other.errorMessage == errorMessage &&
        other.authenticatedWith == authenticatedWith;
  }

  @override
  int get hashCode {
    return Object.hash(isSuccess, errorMessage, authenticatedWith);
  }
}
