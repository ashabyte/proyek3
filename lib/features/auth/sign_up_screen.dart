import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/routes/app_router.dart';
import '../../shared/widgets/app_widgets.dart';
import '../../services/auth_service.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();
  bool _rememberMe = true;

  @override
  void dispose() {
    _namaCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  void _signUp() async {
    if (!_formKey.currentState!.validate()) return;
    
    final authService = Provider.of<AuthService>(context, listen: false);
    final result = await authService.register(
      _namaCtrl.text,
      _emailCtrl.text,
      _passCtrl.text,
    );

    if (mounted) {
      if (result['success']) {
        context.go(AppRoutes.home);
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo
                        Image.asset(
                          'assets/images/logo-denio-2.png',
                          height: 160,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          'Momen spesial nggak datang dua kali!\nAyo abadikan sekarang di fotobooth kita yang super estetik!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                              fontSize: 16,
                              color: AppColors.textSecondary,
                              height: 1.6),
                        ),
                        const SizedBox(height: 32),
                        AppTextField(
                          hint: 'Nama Lengkap',
                          controller: _namaCtrl,
                          validator: (v) => (v == null || v.isEmpty)
                              ? 'Nama wajib diisi'
                              : null,
                        ),
                        const SizedBox(height: 14),
                        AppTextField(
                          hint: 'Email',
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) => (v == null || !v.contains('@'))
                              ? 'Email tidak valid'
                              : null,
                        ),
                        const SizedBox(height: 14),
                        AppTextField(
                          hint: 'Buat password',
                          controller: _passCtrl,
                          isPassword: true,
                          validator: (v) => (v == null || v.length < 6)
                              ? 'Password minimal 6 karakter'
                              : null,
                        ),
                        const SizedBox(height: 14),
                        AppTextField(
                          hint: 'Konfirmasi password',
                          controller: _confirmPassCtrl,
                          isPassword: true,
                          validator: (v) => (v != _passCtrl.text)
                              ? 'Password tidak cocok'
                              : null,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (v) =>
                                  setState(() => _rememberMe = v ?? false),
                            ),
                            Text('Simpan login saya',
                                style: GoogleFonts.dmSans(
                                    fontSize: 14, color: AppColors.textSecondary)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        PrimaryButton(
                          label: 'Daftar',
                          onPressed: _signUp,
                          isLoading: isLoading,
                        ),
                        const SizedBox(height: 24),
                        RichText(
                          text: TextSpan(
                            text: 'Sudah punya akun? ',
                            style: GoogleFonts.dmSans(
                                fontSize: 14, color: AppColors.textHint),
                            children: [
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () => context.push(AppRoutes.login),
                                  child: Text('Login sekarang',
                                      style: GoogleFonts.dmSans(
                                          fontSize: 14,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
