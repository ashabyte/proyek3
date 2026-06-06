import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

// ─── Denio Logo Widget ─────────────────────────────────────────────────────
class DenioLogo extends StatelessWidget {
  final double size;
  const DenioLogo({super.key, this.size = 60});

  @override
  Widget build(BuildContext context) {
    final sq = size / 2 - 2;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _FilledSquare(
                  size: sq,
                  child: Text('D',
                      style: GoogleFonts.dmSans(
                          fontSize: sq * 0.45,
                          fontWeight: FontWeight.w700,
                          color: Colors.white))),
              _OutlineSquare(
                  size: sq,
                  child: const Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Text('┐',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600))))),
              _OutlineSquare(
                  size: sq,
                  child: const Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Text('└',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600))))),
              _FilledSquare(
                  size: sq,
                  child: Text('i',
                      style: GoogleFonts.dmSans(
                          fontSize: sq * 0.4,
                          fontWeight: FontWeight.w600,
                          color: Colors.white))),
            ],
          ),
        ),
      ],
    );
  }
}

class _FilledSquare extends StatelessWidget {
  final double size;
  final Widget? child;
  const _FilledSquare({required this.size, this.child});

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: child),
      );
}

class _OutlineSquare extends StatelessWidget {
  final double size;
  final Widget? child;
  const _OutlineSquare({required this.size, this.child});

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: child,
      );
}

// ─── Primary Button ─────────────────────────────────────────────────────────
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;
  final Widget? prefixWidget;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.height = 52,
    this.prefixWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixWidget != null) ...[
                    prefixWidget!,
                    const SizedBox(width: 10),
                  ],
                  Text(label),
                ],
              ),
      ),
    );
  }
}

// ─── Custom Text Field ───────────────────────────────────────────────────────
class AppTextField extends StatefulWidget {
  final String hint;
  final String? label;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.hint,
    this.label,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword && _obscure,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: widget.hint,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textHint,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

// ─── Section Header ──────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary)),
        if (actionLabel != null)
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionLabel!,
              style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500),
            ),
          ),
      ],
    );
  }
}

// ─── App Back Button ─────────────────────────────────────────────────────────
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new, size: 20),
      color: AppColors.primary,
      onPressed: () {
        if (context.canPop()) {
          context.pop();
        }
      },
    );
  }
}

// ─── Template Page (halaman kosong siap dikembangkan) ────────────────────────
class TemplatePage extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? headerColor;

  const TemplatePage({
    super.key,
    required this.title,
    required this.icon,
    this.headerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: context.canPop() ? const AppBackButton() : null,
        title: Text(
          title,
          style: GoogleFonts.dmSans(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, size: 36, color: AppColors.primary),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: GoogleFonts.dmSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),
            Text(
              'Halaman ini siap dikembangkan\nRouting & struktur sudah tersedia.',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                  fontSize: 13, color: AppColors.textHint, height: 1.6),
            ),
            const SizedBox(height: 32),
            Container(
              width: 240,
              height: 8,
              decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(99)),
            ),
            const SizedBox(height: 12),
            Container(
              width: 180,
              height: 8,
              decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(99)),
            ),
          ],
        ),
      ),
    );
  }
}