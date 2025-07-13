import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:raja_c_flutter_biometrics/presentation/widgets/common/loading_widget.dart';

void main() {
  testWidgets('LoadingWidget shows progress indicator', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoadingWidget()));
    expect(find.byIcon(Icons.hourglass_empty), findsOneWidget);
  });
}
