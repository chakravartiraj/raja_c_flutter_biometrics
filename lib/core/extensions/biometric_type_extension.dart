import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:raja_c_flutter_biometrics/core/themes/app_theme.dart';

/// Extension to add display properties to BiometricType from local_auth package
extension BiometricTypeExtension on BiometricType {
  
  /// Human-readable button title for the biometric type
  String get buttonTitle {
    switch (this) {
      case BiometricType.face:
        return 'Unlock with Face ID';
      case BiometricType.fingerprint:
        return 'Unlock with Fingerprint';
      case BiometricType.iris:
        return 'Unlock with Iris';
      case BiometricType.strong:
      case BiometricType.weak:
        return 'Unlock with $displayName';
    }
  }

  /// Human-readable button subtitle for the biometric type
  String get buttonSubtitle {
    switch (this) {
      case BiometricType.face:
        return 'Use facial recognition to authenticate';
      case BiometricType.fingerprint:
        return 'Use your fingerprint to authenticate';
      case BiometricType.iris:
        return 'Use iris scan to authenticate';
      case BiometricType.strong:
      case BiometricType.weak:
        return 'Use biometric authentication';
    }
  }

  /// buttonColor representation for the biometric type
  Color get buttonColor {
    switch (this) {
      case BiometricType.face:
        return AppTheme.successColor;
      case BiometricType.fingerprint:
        return AppTheme.primaryColor;
      case BiometricType.iris:
        return AppTheme.primaryColor;
      case BiometricType.strong:
      case BiometricType.weak:
        return AppTheme.primaryColor;
    }
  }

  /// Human-readable display name for the biometric type
  String get displayName {
    switch (this) {
      case BiometricType.face:
        return 'Face ID';
      case BiometricType.fingerprint:
        return 'Fingerprint';
      case BiometricType.iris:
        return 'Iris';
      case BiometricType.strong:
      case BiometricType.weak:
        return 'Biometric';
    }
  }

  /// Icon representation for the biometric type
  IconData get icon {
    switch (this) {
      case BiometricType.face:
        return Icons.face;
      case BiometricType.fingerprint:
        return Icons.fingerprint;
      case BiometricType.iris:
        return Icons.visibility;
      case BiometricType.strong:
      case BiometricType.weak:
        return Icons.security;
    }
  }

  /// Whether this biometric type requires hardware support
  bool get requiresHardware {
    switch (this) {
      case BiometricType.face:
      case BiometricType.fingerprint:
      case BiometricType.iris:
        return true;
      case BiometricType.strong:
      case BiometricType.weak:
        return false;
    }
  }
}
