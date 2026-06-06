import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class AuthPhotoCollage extends StatelessWidget {
  const AuthPhotoCollage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const _PhotoCard(
            left: -10,
            top: 20,
            width: 140,
            height: 135,
            angle: -0.14,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2C3E4A), AppColors.primary],
            ),
            icon: Icons.photo_camera,
          ),
          const _PhotoCard(
            right: -5,
            top: 10,
            width: 150,
            height: 135,
            angle: 0.1,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4C6977), Color(0xFF8FBCCC)],
            ),
            icon: Icons.palette,
          ),
          const _PhotoCard(
            left: 20,
            bottom: 40,
            width: 160,
            height: 130,
            angle: 0.07,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF3A5566), Color(0xFF6B8FA3)],
            ),
            icon: Icons.print,
          ),
          const _PhotoCard(
            right: 10,
            bottom: 35,
            width: 125,
            height: 120,
            angle: -0.08,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, Color(0xFFB8D4DF)],
            ),
            icon: Icons.auto_awesome,
          ),
          // fade bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.white],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoCard extends StatelessWidget {
  final double? left, right, top, bottom;
  final double width, height, angle;
  final Gradient gradient;
  final IconData icon;

  const _PhotoCard({
    this.left,
    this.right,
    this.top,
    this.bottom,
    required this.width,
    required this.height,
    required this.angle,
    required this.gradient,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Icon(icon, color: Colors.white.withValues(alpha: 0.4), size: 40),
          ),
        ),
      ),
    );
  }
}
