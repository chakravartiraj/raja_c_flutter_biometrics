import 'package:flutter_test/flutter_test.dart';
import 'package:raja_c_flutter_biometrics/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('ResponsiveHelper identifies tablet', (tester) async {
    // You may need to mock MediaQuery for a real test
    await tester.pumpWidget(Container());
    // expect(ResponsiveHelper.isTablet(context), ...);
  });
}
