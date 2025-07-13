import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:raja_c_flutter_biometrics/presentation/widgets/common/error_widget.dart';

void main() {
  testWidgets('CustomErrorWidget displays error message', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CustomErrorWidget(message: 'Error!', onRetry: () {}),
      ),
    );
    expect(find.text('Error!'), findsOneWidget);
  });
}
