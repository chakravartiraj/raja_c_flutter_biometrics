import 'package:local_auth/local_auth.dart';
import 'package:raja_c_flutter_biometrics/core/models/auth_result.dart';

abstract class BiometricRepository {
  Future<bool> isDeviceSupported();
  Future<bool> canCheckBiometrics();
  Future<List<BiometricType>> getAvailableBiometrics();
  Future<AuthResult> authenticateWithBiometric(BiometricType type);
}
