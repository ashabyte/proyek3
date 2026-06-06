import 'package:denio_imagine/shared/models/tema_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/routes/app_router.dart';
import '../../shared/widgets/app_widgets.dart';
import '../../services/favorite_service.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteService = Provider.of<FavoriteService>(context);
    final favorites = favoriteService.favorites;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppBackButton(),
        title: Text(
          'Favorit Saya',
          style: GoogleFonts.dmSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: favorites.isEmpty
          ? _buildEmptyState(context)
          : _buildFavoriteList(context, favorites),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.favorite_border, size: 48, color: AppColors.primary),
          ),
          const SizedBox(height: 24),
          Text(
            'Belum ada favorit',
            style: GoogleFonts.dmSans(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Klik ikon hati pada tema yang Anda sukai\nuntuk menyimpannya di sini.',
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: 200,
            child: PrimaryButton(
              label: 'Cari Tema',
              onPressed: () => context.go(AppRoutes.tema),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteList(BuildContext context, List favorites) {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final item = favorites[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 60,
                height: 60,
                color: AppColors.surface,
                child: const Icon(Icons.image_outlined, color: AppColors.textHint),
              ),
            ),
            title: Text(
              item.name,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),
            subtitle: Text(
              'Klik untuk melihat detail',
              style: GoogleFonts.dmSans(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textHint),
            onTap: () {
              // Navigasi ke detail tema
              // Kita kirimkan objek TemaItem dummy karena detail screen mengharapkan TemaItem
              context.push(AppRoutes.details, extra: TemaItem(
                name: item.name,
                lokasiSlots: [], // Dummy data sesuai struktur
              ));
            },
          ),
        );
      },
    );
  }
}
