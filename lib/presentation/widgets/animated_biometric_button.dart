import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:raja_c_flutter_biometrics/core/extensions/biometric_type_extension.dart';
import 'package:raja_c_flutter_biometrics/core/themes/app_theme.dart';

class AnimatedBiometricButton extends StatefulWidget {
  final BiometricType biometricType;
  final Future<void> Function()? onTapAsync;
  final bool isEnabled;

  const AnimatedBiometricButton({
    super.key,
    required this.biometricType,
    this.onTapAsync,
    this.isEnabled = true,
  });

  @override
  State<AnimatedBiometricButton> createState() =>
      _AnimatedBiometricButtonState();
}

class _AnimatedBiometricButtonState extends State<AnimatedBiometricButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  Future<void> _handleTap() async {
    if (!widget.isEnabled || _isLoading) return;
    setState(() => _isLoading = true);
    await widget.onTapAsync?.call();
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.isEnabled && !_isLoading) {
      _animationController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.isEnabled && !_isLoading) {
      _animationController.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.isEnabled && !_isLoading) {
      _animationController.reverse();
    }
  }

  Color _getButtonColor() => widget.biometricType.buttonColor;

  String _getButtonTitle() => widget.biometricType.buttonTitle;

  String _getButtonSubtitle() => widget.biometricType.buttonSubtitle;

  @override
  Widget build(BuildContext context) {
    if (!widget.isEnabled) return const SizedBox.shrink();

    final isTablet = MediaQuery.of(context).size.width > 600;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: _opacityAnimation.value,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: isTablet ? 40 : 0,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.isEnabled && !_isLoading ? _handleTap : null,
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: EdgeInsets.all(isTablet ? 24 : 20),
              child: Row(
                children: [
                  // Icon Container
                  Container(
                    height: isTablet ? 64 : 56,
                    width: isTablet ? 64 : 56,
                    decoration: BoxDecoration(
                      color: _getButtonColor().withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _isLoading
                        ? Center(
                            child: SizedBox(
                              height: isTablet ? 28 : 24,
                              width: isTablet ? 28 : 24,
                              child: const CircularProgressIndicator(),
                            ),
                          )
                        : Icon(
                            widget.biometricType.icon,
                            size: isTablet ? 32 : 28,
                            color: _getButtonColor(),
                          ),
                  ),

                  const SizedBox(width: 20),

                  // Text Content
                  Expanded(
                    child: Text(
                      _getButtonTitle(),
                      style: TextStyle(
                        fontSize: isTablet ? 22 : 18,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
