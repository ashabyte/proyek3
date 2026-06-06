import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/app_widgets.dart';
import '../../services/auth_service.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;
  File? _imageFile;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthService>(context, listen: false).user;
    _nameCtrl = TextEditingController(text: user?.name);
    _emailCtrl = TextEditingController(text: user?.email);
    _phoneCtrl = TextEditingController(text: user?.noTelp);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;
    
    final authService = Provider.of<AuthService>(context, listen: false);
    
    // In a real app, you would upload the image to a server first
    // For now, we'll just send the name and phone
    final result = await authService.updateProfile(
      nama: _nameCtrl.text,
      noTelp: _phoneCtrl.text,
      // fotoProfil: _imageFile?.path, // Logic for uploading would go here
    );

    if (mounted) {
      if (result['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profil berhasil diperbarui!',
                style: GoogleFonts.dmSans(color: Colors.white)),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        context.pop();
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
    final user = Provider.of<AuthService>(context).user;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppBackButton(),
        title: Text(
          'Edit Akun',
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
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xFFB8A9E0),
                        borderRadius: BorderRadius.circular(45),
                        image: _imageFile != null
                            ? DecorationImage(image: FileImage(_imageFile!), fit: BoxFit.cover)
                            : (user?.fotoProfil != null
                                ? DecorationImage(image: NetworkImage(user!.fotoProfil!), fit: BoxFit.cover)
                                : null),
                      ),
                      child: (_imageFile == null && user?.fotoProfil == null)
                          ? const Icon(Icons.person, size: 52, color: Colors.white)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.edit, size: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              _EditField(
                label: 'Nama Lengkap',
                hint: 'Masukkan nama lengkap',
                controller: _nameCtrl,
                icon: Icons.person_outline,
                validator: (v) => (v == null || v.isEmpty) ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              _EditField(
                label: 'Email',
                hint: 'your@email.com',
                controller: _emailCtrl,
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                readOnly: true, // Email usually cannot be changed easily
              ),
              const SizedBox(height: 16),
              _EditField(
                label: 'No. Telepon',
                hint: '+62 xxx xxxx xxxx',
                controller: _phoneCtrl,
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                      : Text('Simpan Perubahan',
                          style: GoogleFonts.dmSans(
                              fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EditField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool readOnly;

  const _EditField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.dmSans(
                fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          readOnly: readOnly,
          style: GoogleFonts.dmSans(
            fontSize: 14, 
            color: readOnly ? AppColors.textHint : AppColors.textPrimary
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20, color: AppColors.textHint),
            filled: true,
            fillColor: readOnly ? Colors.grey[100] : AppColors.surface,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
