import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/app_widgets.dart';

class SelectDatetimeScreen extends StatefulWidget {
  const SelectDatetimeScreen({super.key});

  @override
  State<SelectDatetimeScreen> createState() => _SelectDatetimeScreenState();
}

class _SelectDatetimeScreenState extends State<SelectDatetimeScreen> {
  // ── State ──────────────────────────────────────────────────────────────────
  final _placeCtrl = TextEditingController(text: 'Kuningan');
  DateTime _focusedMonth = DateTime(2026, 11);
  DateTime? _selectedDate = DateTime(2026, 11, 25);
  String? _selectedTime = '15:00';

  // ── Time Slots ─────────────────────────────────────────────────────────────
  final _morningSlots = ['09:00', '09:30', '10:00', '11:00'];
  final _afternoonSlots = ['13:00', '14:30', '15:00', '15:30', '16:00'];
  final _eveningSlots = ['17:00', '17:30', '18:30'];

  // disabled slots (greyed out)
  final _disabledSlots = {'11:00'};

  @override
  void dispose() {
    _placeCtrl.dispose();
    super.dispose();
  }

  void _prevMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
    });
  }

  void _onDayTap(DateTime day) {
    if (day.month != _focusedMonth.month) return;
    setState(() => _selectedDate = day);
  }

  void _onTimeTap(String slot) {
    if (_disabledSlots.contains(slot)) return;
    setState(() => _selectedTime = slot);
  }

  void _confirm() {
    if (_selectedDate == null || _selectedTime == null) return;
    // TODO: kirim data ke screen berikutnya
    context.pop();
  }

  // ── Build calendar grid ────────────────────────────────────────────────────
  List<DateTime?> _buildCalendarDays() {
    final firstDay = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    // Monday = 1, so offset = weekday - 1
    final startOffset = (firstDay.weekday - 1) % 7;
    final daysInMonth =
        DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0).day;

    final days = <DateTime?>[];

    // prev month filler
    for (int i = 0; i < startOffset; i++) {
      days.add(firstDay.subtract(Duration(days: startOffset - i)));
    }

    // current month
    for (int d = 1; d <= daysInMonth; d++) {
      days.add(DateTime(_focusedMonth.year, _focusedMonth.month, d));
    }

    // next month filler to complete last row
    while (days.length % 7 != 0) {
      days.add(DateTime(
          _focusedMonth.year, _focusedMonth.month + 1, days.length - daysInMonth - startOffset + 1));
    }

    return days;
  }

  // ── Helpers ────────────────────────────────────────────────────────────────
  String _monthName(int m) => const [
        '', 'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ][m];

  @override
  Widget build(BuildContext context) {
    final calDays = _buildCalendarDays();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppBackButton(),
        title: Text(
          'Select Date & Time',
          style: GoogleFonts.dmSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // ── Places Field ─────────────────────────────────────────
                  Text('Places',
                      style: GoogleFonts.dmSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary)),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _placeCtrl,
                      style: GoogleFonts.dmSans(
                          fontSize: 15, color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        hintText: 'Cari lokasi...',
                        prefixIcon: const Icon(Icons.search,
                            color: AppColors.textHint, size: 20),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Month Header ─────────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_monthName(_focusedMonth.month)} ${_focusedMonth.year}',
                        style: GoogleFonts.dmSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Row(
                        children: [
                          _NavButton(
                              icon: Icons.chevron_left, onTap: _prevMonth),
                          const SizedBox(width: 8),
                          _NavButton(
                              icon: Icons.chevron_right, onTap: _nextMonth),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ── Day Labels ───────────────────────────────────────────
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _DayLabel('Mon'), _DayLabel('Tue'), _DayLabel('Wed'),
                      _DayLabel('Thu'), _DayLabel('Fri'), _DayLabel('Sat'),
                      _DayLabel('Sun'),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // ── Calendar Grid ────────────────────────────────────────
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: calDays.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final day = calDays[index];
                      if (day == null) return const SizedBox();
                      final isCurrentMonth =
                          day.month == _focusedMonth.month;
                      final isSelected = _selectedDate != null &&
                          day.year == _selectedDate!.year &&
                          day.month == _selectedDate!.month &&
                          day.day == _selectedDate!.day;

                      return GestureDetector(
                        onTap: () => _onDayTap(day),
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                                color: isSelected
                                    ? Colors.white
                                    : isCurrentMonth
                                        ? AppColors.textPrimary
                                        : AppColors.textHint,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  // ── Time Slots ───────────────────────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _TimeColumn(
                          label: 'Morning',
                          slots: _morningSlots,
                          selected: _selectedTime,
                          disabled: _disabledSlots,
                          onTap: _onTimeTap,
                        ),
                      ),
                      Expanded(
                        child: _TimeColumn(
                          label: 'Afternoon',
                          slots: _afternoonSlots,
                          selected: _selectedTime,
                          disabled: _disabledSlots,
                          onTap: _onTimeTap,
                        ),
                      ),
                      Expanded(
                        child: _TimeColumn(
                          label: 'Evening',
                          slots: _eveningSlots,
                          selected: _selectedTime,
                          disabled: _disabledSlots,
                          onTap: _onTimeTap,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),

          // ── Confirm Button ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: (_selectedDate != null && _selectedTime != null)
                    ? _confirm
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: AppColors.accentLight,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: Text(
                  'Confirm',
                  style: GoogleFonts.dmSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Nav Button ────────────────────────────────────────────────────────────────
class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _NavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: AppColors.textPrimary),
      ),
    );
  }
}

// ── Day Label ─────────────────────────────────────────────────────────────────
class _DayLabel extends StatelessWidget {
  final String text;
  const _DayLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      child: Center(
        child: Text(text,
            style: GoogleFonts.dmSans(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary)),
      ),
    );
  }
}

// ── Time Column ───────────────────────────────────────────────────────────────
class _TimeColumn extends StatelessWidget {
  final String label;
  final List<String> slots;
  final String? selected;
  final Set<String> disabled;
  final ValueChanged<String> onTap;

  const _TimeColumn({
    required this.label,
    required this.slots,
    required this.selected,
    required this.disabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
            style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary)),
        const SizedBox(height: 12),
        ...slots.map((slot) {
          final isSelected = slot == selected;
          final isDisabled = disabled.contains(slot);
          return GestureDetector(
            onTap: () => onTap(slot),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : isDisabled
                          ? AppColors.border.withOpacity(0.4)
                          : AppColors.border,
                ),
                boxShadow: isSelected
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
              ),
              child: Column(
                children: [
                  Text(
                    slot.replaceAll(':', ' : '),
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : isDisabled
                              ? AppColors.textHint.withOpacity(0.5)
                              : AppColors.textPrimary,
                    ),
                  ),
                  if (isSelected) ...[
                    const SizedBox(height: 2),
                    const Icon(Icons.check, size: 14, color: Colors.white),
                  ],
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}