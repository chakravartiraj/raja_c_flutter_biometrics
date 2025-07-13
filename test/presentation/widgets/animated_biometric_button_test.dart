import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:raja_c_flutter_biometrics/presentation/widgets/animated_biometric_button.dart';

void main() {
  testWidgets('AnimatedBiometricButton renders', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedBiometricButton(
          biometricType: BiometricType.face,
          onTapAsync: () async {},
        ),
      ),
    );
    expect(find.byType(AnimatedBiometricButton), findsOneWidget);
  });
}
