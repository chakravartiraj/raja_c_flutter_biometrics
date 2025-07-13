import 'package:flutter_test/flutter_test.dart';
import 'package:raja_c_flutter_biometrics/services/biometric_service.dart';

void main() {
  test('BiometricService instantiation', () {
    final service = BiometricService();
    expect(service, isA<BiometricService>());
  });
}
