import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/theme/app_colors.dart';
import '../../core/routes/app_router.dart';
import '../../shared/widgets/app_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: CustomScrollView(
        slivers: [
          // ── Header ──────────────────────────────────────────────────────
          SliverToBoxAdapter(child: _HomeHeader()),

          // ── Our Services ────────────────────────────────────────────────
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: 'Layanan Kami'),
                  const SizedBox(height: 14),
                  _ServiceCard(
                    title: 'Percetakan',
                    subtitle: 'Cetak & Finishing Yearbook',
                    icon: Icons.print_outlined,
                    gradient: AppColors.service1Gradient,
                    backgroundImage: 'assets/images/printing-bg.png',
                    onTap: () => context.push(AppRoutes.printing),
                  ),
                  const SizedBox(height: 6),
                  _ServiceCard(
                    title: 'Desain Grafis',
                    subtitle: 'Jasa Layout, Desain, sampai Cetak Yearbook',
                    icon: Icons.palette_outlined,
                    gradient: AppColors.service2Gradient,
                    backgroundImage: 'assets/images/dg-bg.png',
                    onTap: () => context.push(AppRoutes.designGraphic),
                  ),
                  const SizedBox(height: 6),
                  _ServiceCard(
                    title: 'Fotografi',
                    subtitle:
                        'Jasa Foto, Layout, Desain, sampai Cetak Yearbook',
                    icon: Icons.camera_alt_outlined,
                    gradient: AppColors.service3Gradient,
                    backgroundImage: 'assets/images/photography-bg.png',
                    onTap: () => context.push(AppRoutes.photography),
                  ),
                ],
              ),
            ),
          ),

          // ── Information Dropdown ──────────────────────────────────────────
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(title: 'Informasi Layanan'),
                  SizedBox(height: 12),
                  _InfoDropdown(
                    title: 'Cetak dan Desain sesuai permintaan',
                    content:
                        'Kami mengerjakan jasa cetak dan design sesuai keinginan dan hasil yang anda inginkan dengan menitikberatkan pada efisiensi biaya dan waktu.',
                    icon: Icons.handshake_outlined,
                  ),
                  _InfoDropdown(
                    title: 'Layanan pelanggan 24/7',
                    content:
                        'Customer Service kami siap membantu memberikan solusi untuk setiap permintaan dan pertanyaan Anda. Anda tetap bisa menghubungi kami diluar jam kerja.',
                    icon: Icons.headset_mic_outlined,
                  ),
                  _InfoDropdown(
                    title: 'Kemudahan Bertransaksi',
                    content:
                        'Kami memberikan kemudahan dalam bertransaksi jika anda tidak memiliki waktu untuk datang, anda bisa bertransaksi lewat website atau marketplace.',
                    icon: Icons.credit_card_outlined,
                  ),
                  _InfoDropdown(
                    title: 'Jangkauan luas',
                    content:
                        'Menjangkau seluruh pelosok tanah air dengan bekerjasama dengan kurir dan ekspedisi yang mampu menjangkau seluruh pelosok serta kemudahan dalam bertransaksi.',
                    icon: Icons.public_outlined,
                  ),
                ],
              ),
            ),
          ),

          // ── Gallery ───────────────────────────────────────────────────────
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SectionHeader(
                title: 'Galeri',
                actionLabel: 'Lihat Semua',
                onAction: () {},
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 14)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) => _GalleryItem(index: i),
                childCount: 9,
              ),
            ),
          ),

          // ── Number of Projects ───────────────────────────────────────────
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(title: 'Jumlah Proyek'),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(child: _StatCard(value: '70', label: 'Proyek')),
                      SizedBox(width: 10),
                      Expanded(child: _StatCard(value: '18', label: 'Klien')),
                      SizedBox(width: 10),
                      Expanded(child: _StatCard(value: '9.414', label: 'Buku')),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ── Clients ────────────────────────────────────────────────────────
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: 'Beberapa Klien Kami'),
                  const SizedBox(height: 14),
                  GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, i) => _ClientLogo(index: i),
                    itemCount: 15,
                  ),
                ],
              ),
            ),
          ),

          // ── Reviews ──────────────────────────────────────────────────────
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: SectionHeader(title: 'Customers Reviews'),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: _ReviewsSlider(),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Home Header ──────────────────────────────────────────────────────────────
class _HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return SizedBox(
      height: 130 + topPadding,
      child: Stack(
        children: [
          // ── Background Image ─────────────────────────────
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.primary,
                child: const Center(
                  child: Icon(Icons.image_not_supported,
                      color: Colors.white, size: 40),
                ),
              ),
            ),
          ),

          // ── Dark Overlay biar teks kebaca ────────────────
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.35),
            ),
          ),

          // ── Content ──────────────────────────────────────
          Positioned(
            top: topPadding + 16,
            left: 24,
            right: 24,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Profile Image ──────────────────────
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/profile.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.white.withValues(alpha: 0.2),
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // ── Text ───────────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, Nathan!',
                        style: GoogleFonts.dmSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.4,
                        ),
                      ),
                      Text(
                        'Abadikan dan kenang cerita indah bersama teman seangkatan.',
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
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

// ── Reviews Slider ─────────────────────────────────────────────────────────
class _ReviewsSlider extends StatefulWidget {
  const _ReviewsSlider();

  @override
  State<_ReviewsSlider> createState() => _ReviewsSliderState();
}

class _ReviewsSliderState extends State<_ReviewsSlider> {
  late PageController _pageController;
  final int _virtualItemCount = 10000;

  final List<Map<String, String>> _reviews = [
    {
      'name': 'Alfath',
      'subLabel': 'Ketua Panitia SD 1 Lohbener',
      'review':
          'Thank You Denio dan team sudah membantu membuat Yearbook yang keren.',
    },
    {
      'name': 'Iman',
      'subLabel': 'Panitia Yearbook POLINDRA',
      'review':
          'Terimakasih Denio atas kerjasamanya dalam pembuatan Yearbook yang berkualitas dan out of the box.',
    },
    {
      'name': 'Maya',
      'subLabel': 'Orangtua Murid SMK 1 Losarang',
      'review':
          'Hasil cetakan, finishing dan service sangat bagus dan memuaskan, overall amat puas, next pesan lagi.',
    },
    {
      'name': 'Slamet',
      'subLabel': 'Ketua Osis SMA 1 Indramayu',
      'review':
          'Hasil cetakan, finishing dan service sangat bagus dan memuaskan, overall amat puas, next pesan lagi.',
    },
    {
      'name': 'Nathan',
      'subLabel': 'Siswa SMA 2 Indramayu',
      'review':
          'Yearbook paling rapi yang pernah saya lihat. Pelayanan ramah dan tepat waktu!',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Start at middle virtual index mapping to index 2 (the 3rd review)
    final initialPage = (_virtualItemCount ~/ 2) + 2;
    _pageController =
        PageController(initialPage: initialPage, viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _virtualItemCount,
            itemBuilder: (context, index) {
              final reviewIndex = index % _reviews.length;
              final item = _reviews[reviewIndex];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _ReviewCard(
                  name: item['name']!,
                  subLabel: item['subLabel']!,
                  review: item['review']!,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        SmoothPageIndicator(
          controller: _pageController,
          count: _reviews.length,
          effect: ExpandingDotsEffect(
            dotWidth: 8,
            dotHeight: 8,
            activeDotColor: AppColors.primary,
            dotColor: AppColors.primary.withValues(alpha: 0.2),
            expansionFactor: 3,
            spacing: 6,
          ),
        ),
      ],
    );
  }
}

// ── Service Card ─────────────────────────────────────────────────────────────
class _ServiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final LinearGradient gradient;
  final String? backgroundImage;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    this.backgroundImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Padding removed from here to allow image to fill entire card
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Background Image - Now fills the entire card
              if (backgroundImage != null)
                Positioned.fill(
                  child: Image.asset(
                    backgroundImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.primary,
                    ),
                  ),
                ),

              // Content with padding
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: GoogleFonts.dmSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                          Text(subtitle,
                              style: GoogleFonts.dmSans(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(
                            height: 8,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: Colors.white, size: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Gallery Item ─────────────────────────────────────────────────────────────
class _GalleryItem extends StatelessWidget {
  final int index;
  const _GalleryItem({required this.index});

  static final _gradients = [
    const LinearGradient(
        colors: [Color(0xFF1A2530), AppColors.primary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight),
    const LinearGradient(
        colors: [Color(0xFF2D3E4A), AppColors.primaryLight],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight),
    const LinearGradient(
        colors: [Color(0xFF3A5566), AppColors.accent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight),
    const LinearGradient(
        colors: [AppColors.primary, Color(0xFF9FC5D5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight),
    const LinearGradient(
        colors: [Color(0xFF5A7A8E), Color(0xFFB0D0E0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight),
    const LinearGradient(
        colors: [Color(0xFF3A4A58), Color(0xFF5A7A90)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight),
  ];

  static final _icons = [
    Icons.school,
    Icons.groups,
    Icons.photo_camera,
    Icons.celebration,
    Icons.auto_awesome,
    Icons.star_outline
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: _gradients[index % _gradients.length],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Icon(_icons[index % _icons.length],
            color: Colors.white.withValues(alpha: 0.4), size: 28),
      ),
    );
  }
}

// ── Stat Card ────────────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3E9ED),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(value,
              style: GoogleFonts.dmSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary)),
          const SizedBox(height: 2),
          Text(label,
              style: GoogleFonts.dmSans(
                  fontSize: 11, color: AppColors.primary.withValues(alpha: 0.6))),
        ],
      ),
    );
  }
}

// ── Client Logo ───────────────────────────────────────────────────────────────
class _ClientLogo extends StatelessWidget {
  final int index;
  const _ClientLogo({required this.index});

  static const _icons = [
    Icons.school,
    Icons.celebration,
    Icons.account_balance,
    Icons.business,
    Icons.menu_book
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE3E9ED),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(_icons[index % _icons.length],
          color: AppColors.primary.withValues(alpha: 0.6), size: 24),
    );
  }
}

// ── Review Card ───────────────────────────────────────────────────────────────
class _ReviewCard extends StatelessWidget {
  final String name;
  final String subLabel;
  final String review;

  const _ReviewCard({
    required this.name,
    required this.subLabel,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
            const Color(0xFFE3E9ED), // Sesuai design Figma (light bluish grey)
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              review,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                height: 1.4,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 1.5),
                ),
                child: const Icon(Icons.person_outline,
                    color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      subLabel,
                      style: GoogleFonts.dmSans(
                        fontSize: 11,
                        color: AppColors.primary.withValues(alpha: 0.6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Info Dropdown Widget ───────────────────────────────────────────────────
class _InfoDropdown extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;

  const _InfoDropdown({
    required this.title,
    required this.content,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE3E9ED),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Icon(icon, color: AppColors.primary, size: 22),
          title: Text(
            title,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          childrenPadding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          children: [
            Text(
              content,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: AppColors.primary.withValues(alpha: 0.8),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
