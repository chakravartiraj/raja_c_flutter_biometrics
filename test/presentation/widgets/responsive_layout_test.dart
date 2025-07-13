import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:raja_c_flutter_biometrics/presentation/widgets/responsive_layout.dart';

void main() {
  testWidgets('ResponsiveLayout renders', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ResponsiveLayout(mobile: Container(), tablet: Container()),
      ),
    );
    expect(find.byType(ResponsiveLayout), findsOneWidget);
  });
}
