import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';

import '../core/models/auth_result.dart';

class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> isDeviceSupported() async {
    try {
      return await _localAuth.isDeviceSupported();
    } on Exception catch (e, s) {
      debugPrint('Exception in isDeviceSupported: $e\n$s');
      return false;
    }
  }

  Future<bool> canCheckBiometrics() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } on Exception catch (e, s) {
      debugPrint('Exception in canCheckBiometrics: $e\n$s');
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      final biometricTypes = <BiometricType>[];

      for (final biometric in availableBiometrics) {
        switch (biometric) {
          case BiometricType.face:
            biometricTypes.add(BiometricType.face);
            break;
          case BiometricType.fingerprint:
            biometricTypes.add(BiometricType.fingerprint);
            break;
          case BiometricType.iris:
            biometricTypes.add(BiometricType.iris);
            break;
          default:
            break;
        }
      }

      return biometricTypes;
    } on Exception catch (e, s) {
      debugPrint('Exception in getAvailableBiometrics: $e\n$s');
      return [];
    }
  }

  Future<AuthResult> authenticateWithBiometric(BiometricType type) async {
    try {
      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: _getLocalizedReason(type),
        options: const AuthenticationOptions(
          biometricOnly: true, // Only allow biometric authentication
          stickyAuth: true, // Resume authentication if the app is paused
          useErrorDialogs: true, // Display system error dialogs
          sensitiveTransaction:
              true, // Enable platform-specific precautions (like confirmation dialogs on Android Face Unlock)
        ),
      );

      if (didAuthenticate) {
        return AuthResult.success(type);
      } else {
        return AuthResult.failure('Authentication was cancelled or failed');
      }
    } on Exception catch (e, s) {
      debugPrint('Exception in authenticateWithBiometric: $e\n$s');
      return AuthResult.failure(_handleAuthError(e));
    }
  }

  /// Authenticate with the most preferred available biometric type
  Future<AuthResult> authenticateWithPreferredBiometric({
    String? reason,
  }) async {
    try {
      final availableTypes = await getAvailableBiometrics();

      if (availableTypes.isEmpty) {
        return AuthResult.failure(
          'No biometric authentication methods available',
        );
      }

      // Priority order: Face ID > Fingerprint > Iris > Others
      BiometricType preferredType;
      if (availableTypes.contains(BiometricType.face)) {
        preferredType = BiometricType.face;
      } else if (availableTypes.contains(BiometricType.fingerprint)) {
        preferredType = BiometricType.fingerprint;
      } else if (availableTypes.contains(BiometricType.iris)) {
        preferredType = BiometricType.iris;
      } else {
        preferredType = availableTypes.first;
      }

      return await authenticateWithBiometric(preferredType);
    } on Exception catch (e, s) {
      debugPrint('Exception in authenticateWithPreferredBiometric: $e\n$s');
      return AuthResult.failure(_handleAuthError(e));
    }
  }

  /// Get user-friendly description of available biometric types
  Future<String> getAvailableBiometricsDescription() async {
    try {
      final types = await getAvailableBiometrics();

      if (types.isEmpty) {
        return 'No biometric authentication available';
      }

      final descriptions = types.map((type) {
        switch (type) {
          case BiometricType.face:
            return 'Face ID';
          case BiometricType.fingerprint:
            return 'Fingerprint';
          case BiometricType.iris:
            return 'Iris scan';
          default:
            return 'Biometric';
        }
      }).toList();

      if (descriptions.length == 1) {
        return descriptions.first;
      } else if (descriptions.length == 2) {
        return '${descriptions[0]} and ${descriptions[1]}';
      } else {
        final lastItem = descriptions.removeLast();
        return '${descriptions.join(', ')}, and $lastItem';
      }
    } on Exception catch (e, s) {
      debugPrint('Exception in getAvailableBiometricsDescription: $e\n$s');
      return 'Biometric authentication';
    }
  }

  String _getLocalizedReason(BiometricType type) {
    switch (type) {
      case BiometricType.face:
        return 'Use Face ID to authenticate';
      case BiometricType.fingerprint:
        return 'Use your fingerprint to authenticate';
      case BiometricType.iris:
        return 'Use Iris scan to authenticate';
      default:
        return 'Use biometric authentication';
    }
  }

  String _handleAuthError(dynamic error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('usercancel') ||
        errorString.contains('user_cancel')) {
      return 'Authentication was cancelled';
    } else if (errorString.contains('notavailable') ||
        errorString.contains('not_available')) {
      return 'Biometric authentication is not available on this device';
    } else if (errorString.contains('notenrolled') ||
        errorString.contains('not_enrolled')) {
      return 'No biometric credentials are enrolled. Please set up biometrics in device settings';
    } else if (errorString.contains('lockedout') ||
        errorString.contains('locked_out')) {
      return 'Too many failed attempts. Biometric authentication is temporarily disabled';
    } else if (errorString.contains('permanentlylockedout') ||
        errorString.contains('permanently_locked_out')) {
      return 'Biometric authentication is permanently disabled. Please use device passcode';
    } else if (errorString.contains('biometriconly') ||
        errorString.contains('biometric_only')) {
      return 'Device passcode authentication is not allowed';
    } else if (errorString.contains('invalidcontext') ||
        errorString.contains('invalid_context')) {
      return 'Authentication context is invalid';
    } else {
      return 'Authentication failed: ${error.toString()}';
    }
  }

  /// Comprehensive check for biometric authentication availability
  Future<Map<String, dynamic>> getBiometricStatus() async {
    try {
      final deviceSupported = await isDeviceSupported();
      final canCheckBiometric = await canCheckBiometrics();
      final availableTypes = await getAvailableBiometrics();

      return {
        'isDeviceSupported': deviceSupported,
        'canCheckBiometrics': canCheckBiometric,
        'availableTypes': availableTypes,
        'hasEnrolledBiometrics': availableTypes.isNotEmpty,
        'canAuthenticate':
            deviceSupported && canCheckBiometric && availableTypes.isNotEmpty,
      };
    } on Exception catch (e, s) {
      debugPrint('Exception in getBiometricStatus: $e\n$s');
      return {
        'isDeviceSupported': false,
        'canCheckBiometrics': false,
        'availableTypes': <BiometricType>[],
        'hasEnrolledBiometrics': false,
        'canAuthenticate': false,
        'error': e.toString(),
      };
    }
  }

  Future<Map<BiometricType, bool>> getBiometricAvailability() async {
    final Map<BiometricType, bool> availability = {
      BiometricType.face: false,
      BiometricType.fingerprint: false,
      BiometricType.iris: false,
      BiometricType.weak: false,
      BiometricType.strong: false,
    };

    try {
      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      for (final biometric in availableBiometrics) {
        // Map weak/strong to fingerprint for Android compatibility
        if (Platform.isAndroid &&
            (biometric == BiometricType.weak ||
                biometric == BiometricType.strong)) {
          availability[BiometricType.fingerprint] = true;
        }
        availability[biometric] = true;
      }
    } on Exception catch (e, s) {
      debugPrint('Exception in getBiometricAvailability: $e\n$s');
    }
    return availability;
  }
}
