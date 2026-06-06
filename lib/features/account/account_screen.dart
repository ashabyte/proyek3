import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/routes/app_router.dart';
import '../../services/auth_service.dart';
import '../../services/favorite_service.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;
    final favCount = Provider.of<FavoriteService>(context).favorites.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    // Profile Photo using Container with decoration.image
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: const Color(0xFFB8A9E0),
                        shape: BoxShape.circle,
                        image: (user?.fotoProfil != null && user!.fotoProfil!.startsWith('http'))
                          ? DecorationImage(
                              image: NetworkImage(user.fotoProfil!),
                              fit: BoxFit.cover,
                            )
                          : null,
                      ),
                      child: (user?.fotoProfil == null || !user!.fotoProfil!.startsWith('http'))
                          ? const Icon(Icons.person, size: 40, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name ?? 'Nama Pengguna',
                            style: GoogleFonts.dmSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            user?.email ?? 'email@example.com',
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 200,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () => context.push(AppRoutes.editAccount),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Edit Profil',
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              _MenuItem(
                label: 'Favorit Saya ($favCount)',
                onTap: () => context.push(AppRoutes.favorite),
              ),
              _MenuItem(label: 'Ganti Kata Sandi', onTap: () => context.push(AppRoutes.changePassword)),        
              _MenuItem(label: 'Pengaturan Akun', onTap: () => context.push(AppRoutes.editAccount)),
              _MenuItem(label: 'Riwayat Booking', onTap: () => context.push(AppRoutes.bookingUpcoming)),        
              _MenuItem(label: 'ChatBot AI', onTap: () => context.push(AppRoutes.chatbotAi)),
              _MenuItem(
                label: 'Logout',
                labelColor: Colors.red,
                onTap: () => _showLogoutDialog(context, authService)
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthService authService) {
    showDialog(context: context, builder: (_) => _LogoutDialog(authService: authService));
  }
}

class _MenuItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color? labelColor;

  const _MenuItem({required this.label, required this.onTap, this.labelColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: GoogleFonts.dmSans(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: labelColor ?? AppColors.textPrimary,
                  ),
                ),
                const Icon(Icons.chevron_right, size: 20, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
        const Divider(height: 1, thickness: 1, color: AppColors.border, indent: 24, endIndent: 24),
      ],
    );
  }
}

class _LogoutDialog extends StatelessWidget {
  final AuthService authService;
  const _LogoutDialog({required this.authService});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Konfirmasi Keluar',
                style: GoogleFonts.dmSans(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 10),
            Text('Apakah Anda yakin ingin keluar dari akun ini?',
                style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textSecondary, height: 1.5)),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text('Batal',
                        style: GoogleFonts.dmSans(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),  
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await authService.logout();
                      if (context.mounted) {
                        context.go(AppRoutes.login);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                    ),
                    child: Text('Keluar',
                        style: GoogleFonts.dmSans(fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
