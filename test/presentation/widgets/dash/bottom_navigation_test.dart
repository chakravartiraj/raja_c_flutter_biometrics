import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:raja_c_flutter_biometrics/presentation/widgets/dash/bottom_navigation.dart';

void main() {
  testWidgets('CustomBottomNavigation renders', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CustomBottomNavigation()));
    expect(find.byType(CustomBottomNavigation), findsOneWidget);
  });
}
