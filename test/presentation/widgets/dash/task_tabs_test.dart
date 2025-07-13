import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:raja_c_flutter_biometrics/presentation/widgets/dash/task_tabs.dart';

void main() {
  testWidgets('TaskTabs renders', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TaskTabs(selectedTab: 'tab1', onTabChanged: (_) {}),
      ),
    );
    expect(find.byType(TaskTabs), findsOneWidget);
  });
}
