import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:raja_c_flutter_biometrics/presentation/blocs/auth/auth_state.dart';
import 'package:raja_c_flutter_biometrics/presentation/routes/navigation_service.dart';
import 'package:raja_c_flutter_biometrics/presentation/widgets/animated_biometric_button.dart';
import 'package:raja_c_flutter_biometrics/presentation/widgets/responsive_layout.dart';
import 'package:raja_c_flutter_biometrics/services/biometric_service.dart';

import '../../core/themes/app_theme.dart';
import '../blocs/auth/auth_bloc.dart';
import '../routes/app_route_enum.dart';
import '../widgets/common/liquid_glass_card.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _highlightController;
  late final Animation<double> _highlightAnimation;

  @override
  void initState() {
    super.initState();
    _highlightController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _highlightAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _highlightController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _highlightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: AppTheme.errorColor,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // Visually appealing multi-stop gradient background with radial overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryColor,
                      AppTheme.primaryColor.withValues(alpha: 0.85),
                      AppTheme.primaryColor.withValues(alpha: 0.7),
                      AppTheme.backgroundColor,
                    ],
                    stops: const [0.0, 0.4, 0.7, 1.0],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
                child: CustomPaint(
                  painter: _RadialBackgroundPainter(),
                  child: Container(),
                ),
              ),
              Center(
                child: SafeArea(
                  child: ResponsiveLayout(
                    mobile: _buildContent(context, false),
                    tablet: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: _buildContent(context, true),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isTablet) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 40 : 24,
        vertical: isTablet ? 60 : 40,
      ),
      child: LiquidGlassCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(isTablet),
            SizedBox(height: isTablet ? 60 : 40),
            FutureBuilder<Map<BiometricType, bool>>(
              future: BiometricService().getBiometricAvailability(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final availability = snapshot.data ?? {};
                // Used just to make sure the availability of biometrics as per local_auth package for Android
                // debugPrint('Biometric availability: $availability');

                return Column(
                  children: [
                    AnimatedBiometricButton(
                      biometricType: BiometricType.face,
                      onTapAsync: () => _onFaceIdTap(context),
                      isEnabled: (availability[BiometricType.face] == true),
                    ),
                    AnimatedBiometricButton(
                      biometricType: BiometricType.fingerprint,
                      onTapAsync: () => _onFingerprintTap(context),
                      isEnabled:
                          (availability[BiometricType.fingerprint] == true),
                    ),
                    if ((availability[BiometricType.face] != true) &&
                        (availability[BiometricType.fingerprint] != true))
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Text(
                          'Biometric authentication is not available on this device.',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onFaceIdTap(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    Future<Object?>? navigateToDash() =>
        NavigationService.pushReplacementNamed(AppRoute.dash.name);
    try {
      final result = await BiometricService().authenticateWithBiometric(
        BiometricType.face,
      );
      if (!mounted) return;
      if (result.isSuccess) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Face ID authentication successful!')),
        );
        navigateToDash();
      } else {
        debugPrint('Face ID error: ${result.errorMessage ?? 'Unknown error'}');
        messenger.showSnackBar(
          SnackBar(
            content: Text(
              result.errorMessage ?? 'Face ID authentication failed.',
            ),
          ),
        );
      }
    } catch (e, stack) {
      debugPrint('Exception during Face ID authentication: $e\n$stack');
      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(content: Text('Face ID authentication error.')),
      );
    }
  }

  Future<void> _onFingerprintTap(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    Future<Object?>? navigateToDash() =>
        NavigationService.pushReplacementNamed(AppRoute.dash.name);
    try {
      final result = await BiometricService().authenticateWithBiometric(
        BiometricType.fingerprint,
      );
      if (!mounted) return;
      if (result.isSuccess) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Fingerprint authentication successful!'),
          ),
        );
        navigateToDash();
      } else {
        debugPrint(
          'Fingerprint error: ${result.errorMessage ?? 'Unknown error'}',
        );
        messenger.showSnackBar(
          SnackBar(
            content: Text(
              result.errorMessage ?? 'Fingerprint authentication failed.',
            ),
          ),
        );
      }
    } catch (e, stack) {
      debugPrint('Exception during Fingerprint authentication: $e\n$stack');
      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(content: Text('Fingerprint authentication error.')),
      );
    }
  }

  Widget _buildHeader(bool isTablet) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOut,
          height: isTablet ? 120 : 100,
          width: isTablet ? 120 : 100,
          margin: EdgeInsets.only(bottom: isTablet ? 32 : 24),
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withValues(alpha: 0.12),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Icon(
            Icons.lock_outline,
            size: isTablet ? 60 : 48,
            color: AppTheme.primaryColor,
          ),
        ),
        Text(
          'Secure Login',
          style: TextStyle(
            fontSize: isTablet ? 32 : 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.cardColor,
            letterSpacing: -0.5,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Authenticate using biometrics for enhanced security.',
          style: TextStyle(
            fontSize: isTablet ? 18 : 15,
            color: AppTheme.cardColor.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _RadialBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.6;
    final gradient = RadialGradient(
      colors: [Colors.white.withValues(alpha: 0.18), Colors.transparent],
      stops: const [0.0, 1.0],
    );
    final rect = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
