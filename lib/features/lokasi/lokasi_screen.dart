import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/routes/app_router.dart';
import '../../shared/widgets/app_widgets.dart';
import '../../shared/models/tema_model.dart';

final lokasiList = [
  TemaItem(name: 'Q Garden', lokasiSlots: [
    LokasiSlot(name: 'Q Garden', duration: '30 Mins'),
  ]),
  TemaItem(name: 'Loemento', lokasiSlots: [
    LokasiSlot(name: 'Loemento', duration: '30 Mins'),
  ]),
  TemaItem(name: "D'brework", lokasiSlots: [
    LokasiSlot(name: "D'brework", duration: '30 Mins'),
  ]),
  TemaItem(name: 'Hafa Colonial', lokasiSlots: [
    LokasiSlot(name: 'Hafa Colonial', duration: '30 Mins'),
  ]),
  TemaItem(name: 'Keraton Kasepuhan Cirebon', lokasiSlots: [
    LokasiSlot(name: 'Keraton Kasepuhan Cirebon', duration: '30 Mins'),
  ]),
  TemaItem(name: 'Pondok Cai Pinus', lokasiSlots: [
    LokasiSlot(name: 'Pondok Cai Pinus', duration: '30 Mins'),
  ]),
];

class LokasiScreen extends StatelessWidget {
  const LokasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppBackButton(),
        title: Text(
          'Lokasi',
          style: GoogleFonts.dmSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        itemCount: lokasiList.length,
        itemBuilder: (context, index) {
          final lokasi = lokasiList[index];
          return _LokasiCard(
            item: lokasi,
            onTap: () => context.push(AppRoutes.details, extra: lokasi),
          );
        },
      ),
    );
  }
}

class _LokasiCard extends StatelessWidget {
  final TemaItem item;
  final VoidCallback onTap;

  const _LokasiCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 180,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: AppColors.accentLight,
                child: const Icon(
                  Icons.camera_alt_outlined,
                  size: 48,
                  color: AppColors.primary,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.55),
                    ],
                    stops: const [0.5, 1.0],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(18),
                  ),
                ),
                child: Center(
                  child: Text(
                    item.name,
                    style: GoogleFonts.dmSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}