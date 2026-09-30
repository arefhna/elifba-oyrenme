import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BeautifulCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? gradientStart;
  final Color? gradientEnd;
  final IconData? icon;
  final bool hasGlow;

  const BeautifulCard({
    super.key,
    required this.child,
    this.onTap,
    this.gradientStart,
    this.gradientEnd,
    this.icon,
    this.hasGlow = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientStart != null && gradientEnd != null
              ? [gradientStart!, gradientEnd!]
              : isDark
                  ? [AppTheme.darkCard, AppTheme.darkSurface]
                  : [Colors.white, Colors.white],
        ),
        boxShadow: [
          BoxShadow(
            color: hasGlow
                ? AppTheme.primaryGreen.withOpacity(0.3)
                : Colors.black.withOpacity(isDark ? 0.3 : 0.06),
            blurRadius: hasGlow ? 20 : 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: child,
          ),
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final LinearGradient? gradient;

  const GradientButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: gradient ?? AppTheme.greenGradient,
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 22),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
