import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/app_widgets.dart';

// ── Data Model ───────────────────────────────────────────────────────────────
class _BookingItem {
  final String title;
  final String location;
  final String date;
  final String headerDate;
  final String imagePlaceholder;

  const _BookingItem({
    required this.title,
    required this.location,
    required this.date,
    required this.headerDate,
    required this.imagePlaceholder,
  });
}

// ── Dummy Data ────────────────────────────────────────────────────────────────
const _upcomingList = [
  _BookingItem(
    title: 'Vintage',
    location: 'Villa Kuningan',
    date: '25 November 2026 - 15:00',
    headerDate: 'Nov 25, 2026 - 15:00',
    imagePlaceholder: 'V',
  ),
  _BookingItem(
    title: 'Coboy',
    location: 'Tamansari Equestrian Park',
    date: '11 November 2026 - 10:00',
    headerDate: 'Sep 28, 2024 - 9:30 AM',
    imagePlaceholder: 'C',
  ),
];

const _completedList = [
  _BookingItem(
    title: 'Cartoon',
    location: 'Villa Majalengka',
    date: '23 April 2024 - 11:30',
    headerDate: 'April 23, 2024 - 11:30',
    imagePlaceholder: 'C',
  ),
  _BookingItem(
    title: 'Mafia',
    location: 'Jakarta',
    date: '15 Agustus 2024 - 09:30',
    headerDate: 'Aug 15, 2024 - 09:30',
    imagePlaceholder: 'M',
  ),
];

const _cancelledList = [
  _BookingItem(
    title: 'Retro',
    location: 'Bekasi',
    date: '27 September 2024 - 11:30',
    headerDate: 'Sep 27, 2024 - 11:30',
    imagePlaceholder: 'R',
  ),
  _BookingItem(
    title: 'Film',
    location: 'Bandung',
    date: '14 Agustus 2024 - 09:00',
    headerDate: 'Aug 14, 2024 - 09:00',
    imagePlaceholder: 'F',
  ),
];

// ── Main Screen ───────────────────────────────────────────────────────────────
class BookingUpcomingScreen extends StatefulWidget {
  final int initialTab;
  const BookingUpcomingScreen({super.key, this.initialTab = 0});

  @override
  State<BookingUpcomingScreen> createState() => _BookingUpcomingScreenState();
}

class _BookingUpcomingScreenState extends State<BookingUpcomingScreen> {
  late int _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
  }

  List<_BookingItem> get _currentList {
    switch (_selectedTab) {
      case 1:
        return _completedList;
      case 2:
        return _cancelledList;
      default:
        return _upcomingList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppBackButton(),
        title: Text(
          'Bookings',
          style: GoogleFonts.dmSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Column(
        children: [
          // ── Tab Bar ────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _TabItem(label: 'Upcoming', index: 0, selected: _selectedTab, onTap: (i) => setState(() => _selectedTab = i)),
                const SizedBox(width: 20),
                _TabItem(label: 'Completed', index: 1, selected: _selectedTab, onTap: (i) => setState(() => _selectedTab = i)),
                const SizedBox(width: 20),
                _TabItem(label: 'Cancelled', index: 2, selected: _selectedTab, onTap: (i) => setState(() => _selectedTab = i)),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── List ───────────────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _currentList.length,
              itemBuilder: (context, index) {
                final item = _currentList[index];
                return _BookingCard(
                  item: item,
                  type: _selectedTab == 0
                      ? _CardType.upcoming
                      : _selectedTab == 1
                          ? _CardType.completed
                          : _CardType.cancelled,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tab Item ──────────────────────────────────────────────────────────────────
class _TabItem extends StatelessWidget {
  final String label;
  final int index;
  final int selected;
  final ValueChanged<int> onTap;

  const _TabItem({
    required this.label,
    required this.index,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == selected;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.dmSans(
              fontSize: 15,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive ? const Color(0xFF3A6BC4) : AppColors.textHint,
            ),
          ),
          const SizedBox(height: 6),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 2,
            width: isActive ? label.length * 8.5 : 0,
            decoration: BoxDecoration(
              color: const Color(0xFF3A6BC4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Card Type ─────────────────────────────────────────────────────────────────
enum _CardType { upcoming, completed, cancelled }

// ── Booking Card ──────────────────────────────────────────────────────────────
class _BookingCard extends StatelessWidget {
  final _BookingItem item;
  final _CardType type;

  const _BookingCard({required this.item, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EDF2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header date row ──────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.headerDate,
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (type == _CardType.cancelled)
                  Text(
                    'Cancelled',
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.error,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // ── Image + Info ─────────────────────────────────────
            Row(
              children: [
                // Image placeholder
                Container(
                  width: 90,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.accentLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.dmSans(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.location,
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          color: AppColors.textHint,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.date,
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // ── Buttons ──────────────────────────────────────────
            if (type == _CardType.upcoming) ...[
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _showCancelDialog(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Cancel Booking',
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: Text(
                        'View Receipt',
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ] else if (type == _CardType.completed) ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                  ),
                  child: Text(
                    'View Receipt',
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
            // Cancelled: no buttons
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Batalkan Booking?',
                  style: GoogleFonts.dmSans(
                      fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const SizedBox(height: 10),
              Text('Yakin ingin membatalkan booking ini? Tindakan tidak dapat diurungkan.',
                  style: GoogleFonts.dmSans(
                      fontSize: 14, color: AppColors.textSecondary, height: 1.5)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                      ),
                      child: Text('Tidak',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        elevation: 0,
                      ),
                      child: Text('Batalkan',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w600, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}