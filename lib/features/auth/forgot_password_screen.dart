import 'package:flutter/material.dart';
import '../../shared/widgets/app_widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemplatePage(
      title: 'Forgot Password',
      icon: Icons.lock_reset_outlined,
    );
  }
}
