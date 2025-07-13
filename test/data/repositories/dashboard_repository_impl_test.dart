import 'package:flutter_test/flutter_test.dart';
import 'package:raja_c_flutter_biometrics/data/repositories/dashboard_repository_impl.dart';

void main() {
  test('DashboardRepositoryImpl instantiation', () {
    final repo = DashboardRepositoryImpl();
    expect(repo, isA<DashboardRepositoryImpl>());
  });
}
