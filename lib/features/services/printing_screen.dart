import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/app_widgets.dart';

// ── Shared Model ──────────────────────────────────────────────────────────────
class ServiceStep {
  final String title;
  final String description;
  const ServiceStep({required this.title, required this.description});
}

// ── Shared Screen Widget ──────────────────────────────────────────────────────
class ServiceScreen extends StatelessWidget {
  final String title;
  final String description;
  final List<ServiceStep> steps;

  const ServiceScreen({
    super.key,
    required this.title,
    required this.description,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppBackButton(),
        title: Text(
          title,
          style: GoogleFonts.dmSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header Card ──────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Color(0x99000000),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: Colors.white,
                  height: 1.7,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ── Steps ────────────────────────────────────────────
            ...steps.map((step) => _StepTile(step: step)),
          ],
        ),
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  final ServiceStep step;
  const _StepTile({required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.shield_outlined,
              color: AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  step.description,
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Printing Screen ───────────────────────────────────────────────────────────
class PrintingScreen extends StatelessWidget {
  const PrintingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceScreen(
      title: 'Printing',
      description:
          'Denio Imagine menyediakan jasa cetak dan finishing menggunakan mesin cetak terbaik dan tenaga terampil, Anda hanya perlu menyiapkan desain yearbook anda',
      steps: const [
        ServiceStep(
          title: 'Pastikan Spesifikasi dan Harga',
          description:
              'Anda bisa memastikan harga dengan melihat pricelist untuk spec standard atau hubungi kami melalui form konsultasi harga di bawah.',
        ),
        ServiceStep(
          title: 'Transaksi Pembayaran',
          description:
              'Apabila harga sudah cocok anda bisa bertransaksi lewat website ini atau hubungi marketing kami untuk manual invoice.',
        ),
        ServiceStep(
          title: 'Produksi dan Delivery',
          description:
              'Setelah transaksi dan data telah siap, produksi dilakukan sesuai waktu standard. Barang jadi siap diambil atau dikirim melalui kurir.',
        ),
      ],
    );
  }
}

// ── Design Graphic Screen ─────────────────────────────────────────────────────
class DesignGraphicScreen extends StatelessWidget {
  const DesignGraphicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceScreen(
      title: 'Design Graphic',
      description:
          'Denio Imagine menyediakan jasa desain grafis profesional untuk yearbook Anda dengan hasil berkualitas tinggi dan estetik.',
      steps: const [
        ServiceStep(
          title: 'Pastikan Spesifikasi dan Harga',
          description:
              'Anda bisa memastikan harga dengan melihat pricelist untuk spec standard atau hubungi kami melalui form konsultasi harga di bawah.',
        ),
        ServiceStep(
          title: 'Transaksi Pembayaran',
          description:
              'Apabila harga sudah cocok anda bisa bertransaksi lewat website ini atau hubungi marketing kami untuk manual invoice.',
        ),
        ServiceStep(
          title: 'Produksi dan Delivery',
          description:
              'Setelah transaksi dan data telah siap, produksi dilakukan sesuai waktu standard. Barang jadi siap diambil atau dikirim melalui kurir.',
        ),
      ],
    );
  }
}

// ── Photography Screen ────────────────────────────────────────────────────────
class PhotographyScreen extends StatelessWidget {
  const PhotographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceScreen(
      title: 'Photography',
      description:
          'Denio Imagine menyediakan jasa fotografi profesional untuk mengabadikan momen terbaik yearbook Anda dengan hasil berkualitas tinggi.',
      steps: const [
        ServiceStep(
          title: 'Pastikan Spesifikasi dan Harga',
          description:
              'Anda bisa memastikan harga dengan melihat pricelist untuk spec standard atau hubungi kami melalui form konsultasi harga di bawah.',
        ),
        ServiceStep(
          title: 'Transaksi Pembayaran',
          description:
              'Apabila harga sudah cocok anda bisa bertransaksi lewat website ini atau hubungi marketing kami untuk manual invoice.',
        ),
        ServiceStep(
          title: 'Sesi Foto dan Delivery',
          description:
              'Setelah transaksi dan jadwal telah siap, sesi foto dilakukan sesuai waktu yang disepakati. Hasil foto siap diambil atau dikirim secara digital.',
        ),
      ],
    );
  }
}