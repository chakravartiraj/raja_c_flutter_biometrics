import 'package:local_auth/local_auth.dart';
import 'package:raja_c_flutter_biometrics/core/models/auth_result.dart';
import 'package:raja_c_flutter_biometrics/core/repositories/biometric_repository.dart';
import 'package:raja_c_flutter_biometrics/services/biometric_service.dart';

class BiometricRepositoryImpl implements BiometricRepository {
  final BiometricService _biometricService;

  BiometricRepositoryImpl({required BiometricService biometricService}) : _biometricService = biometricService;

  @override
  Future<bool> isDeviceSupported() async {
    return await _biometricService.isDeviceSupported();
  }

  @override
  Future<bool> canCheckBiometrics() async {
    return await _biometricService.canCheckBiometrics();
  }

  @override
  Future<List<BiometricType>> getAvailableBiometrics() async {
    return await _biometricService.getAvailableBiometrics();
  }

  @override
  Future<AuthResult> authenticateWithBiometric(BiometricType type) async {
    return await _biometricService.authenticateWithBiometric(type);
  }
}
