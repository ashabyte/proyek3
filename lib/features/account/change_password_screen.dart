import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/app_widgets.dart';
import '../../services/auth_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPassCtrl = TextEditingController();
  final _newPassCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  @override
  void dispose() {
    _currentPassCtrl.dispose();
    _newPassCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  void _changePassword() async {
    if (!_formKey.currentState!.validate()) return;
    
    final authService = Provider.of<AuthService>(context, listen: false);
    final result = await authService.changePassword(
      currentPassword: _currentPassCtrl.text,
      newPassword: _newPassCtrl.text,
      confirmPassword: _confirmPassCtrl.text,
    );

    if (mounted) {
      if (result['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password berhasil diubah!',
                style: GoogleFonts.dmSans(color: Colors.white)),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'])),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthService>(context).isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppBackButton(),
        title: Text(
          'Ganti Kata Sandi',
          style: GoogleFonts.dmSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pastikan kata sandi baru Anda kuat dan mudah diingat.',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              AppTextField(
                label: 'Kata Sandi Saat Ini',
                hint: 'Masukkan kata sandi lama',
                controller: _currentPassCtrl,
                isPassword: true,
                validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 20),
              AppTextField(
                label: 'Kata Sandi Baru',
                hint: 'Minimal 6 karakter',
                controller: _newPassCtrl,
                isPassword: true,
                validator: (v) => (v == null || v.length < 6) ? 'Minimal 6 karakter' : null,
              ),
              const SizedBox(height: 20),
              AppTextField(
                label: 'Konfirmasi Kata Sandi Baru',
                hint: 'Ulangi kata sandi baru',
                controller: _confirmPassCtrl,
                isPassword: true,
                validator: (v) => (v != _newPassCtrl.text) ? 'Password tidak cocok' : null,
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                label: 'Simpan Kata Sandi',
                onPressed: _changePassword,
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
