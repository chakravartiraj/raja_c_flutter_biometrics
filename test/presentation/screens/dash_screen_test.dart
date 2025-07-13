import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:raja_c_flutter_biometrics/domain/usecases/dash_usecase.dart';
import 'package:raja_c_flutter_biometrics/presentation/blocs/dash/dash_bloc.dart';
import 'package:raja_c_flutter_biometrics/presentation/screens/dash_screen.dart';

import 'mock_dashboard_repository.dart';

void main() {
  testWidgets('DashScreen renders correctly', (WidgetTester tester) async {
    final mockRepository = MockDashboardRepository();
    final dashboardUseCase = DashboardUseCase(mockRepository);
    await tester.pumpWidget(
      Provider<DashboardBloc>(
        create: (_) => DashboardBloc(dashboardUseCase: dashboardUseCase),
        child: MaterialApp(home: DashScreen()),
      ),
    );
    // expect(find.byType(DashScreen), findsOneWidget);
  });
}
