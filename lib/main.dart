import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raja_c_flutter_biometrics/core/repositories/biometric_repository.dart';
import 'package:raja_c_flutter_biometrics/core/themes/app_theme.dart';
import 'package:raja_c_flutter_biometrics/data/repositories/biometric_repository_impl.dart';
import 'package:raja_c_flutter_biometrics/data/repositories/dashboard_repository_impl.dart';
import 'package:raja_c_flutter_biometrics/domain/repositories/dash_repository.dart';
import 'package:raja_c_flutter_biometrics/domain/usecases/dash_usecase.dart';
import 'package:raja_c_flutter_biometrics/presentation/blocs/auth/auth_bloc.dart';
import 'package:raja_c_flutter_biometrics/presentation/routes/app_routes.dart';
import 'package:raja_c_flutter_biometrics/presentation/routes/navigation_service.dart';
import 'package:raja_c_flutter_biometrics/presentation/screens/auth_screen.dart';
import 'package:raja_c_flutter_biometrics/services/biometric_service.dart';

import 'presentation/blocs/dash/dash_bloc.dart';

void main() {
  runApp(const RootWidget());
}

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BiometricRepository>(
          create: (context) =>
              BiometricRepositoryImpl(biometricService: BiometricService()),
        ),
        RepositoryProvider<DashboardRepository>(
          create: (context) => DashboardRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              biometricRepository: context.read<BiometricRepository>(),
            ),
          ),
          BlocProvider<DashboardBloc>(
            create: (context) => DashboardBloc(
              dashboardUseCase: DashboardUseCase(
                context.read<DashboardRepository>(),
              ),
            ),
          ),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Secure Biometric Auth',
          theme: AppTheme.light, // Light theme
          darkTheme: AppTheme.dark, // Dark theme
          themeMode: ThemeMode.system, // Follows system setting
          home: const AuthScreen(),
          onGenerateRoute: AppRoutes.generateRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
