import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/routes/app_router.dart';
import '../../shared/widgets/app_widgets.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _rememberMe = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isLoading = false);
        context.go(AppRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/logo-denio-2.png',
                            height: 160,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Center(
                          child: Text(
                            'Momen spesial nggak datang dua kali!\nAyo abadikan sekarang di fotobooth kita yang super estetik!',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSans(
                                fontSize: 16,
                                color: AppColors.textSecondary,
                                height: 1.6),
                          ),
                        ),
                        const SizedBox(height: 32),
                        AppTextField(
                          hint: 'your@email.com',
                          label: 'Email',
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) => (v == null || !v.contains('@'))
                              ? 'Email tidak valid'
                              : null,
                        ),
                        const SizedBox(height: 14),
                        AppTextField(
                          hint: '••••••••',
                          label: 'Password',
                          controller: _passCtrl,
                          isPassword: true,
                          validator: (v) => (v == null || v.isEmpty)
                              ? 'Password wajib diisi'
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
                            label: 'Login',
                            onPressed: _login,
                            isLoading: _isLoading),
                        const SizedBox(height: 20),
                        Center(
                          child: GestureDetector(
                            onTap: () => context.push(AppRoutes.forgotPassword),
                            child: Text('Lupa password?',
                                style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'Belum punya akun? ',
                              style: GoogleFonts.dmSans(
                                  fontSize: 14, color: AppColors.textHint),
                              children: [
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () => context.push(AppRoutes.signUp),
                                    child: Text('Daftar sekarang',
                                        style: GoogleFonts.dmSans(
                                            fontSize: 14,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                              ],
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
        },
      ),
    );
  }
}
