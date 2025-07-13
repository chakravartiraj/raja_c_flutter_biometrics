import 'package:flutter_test/flutter_test.dart';
import 'package:raja_c_flutter_biometrics/data/repositories/biometric_repository_impl.dart';
import 'package:raja_c_flutter_biometrics/services/biometric_service.dart';

void main() {
  test('BiometricRepositoryImpl instantiation', () {
    final repo = BiometricRepositoryImpl(biometricService: BiometricService());
    expect(repo, isA<BiometricRepositoryImpl>());
  });
}
