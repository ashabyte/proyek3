import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/routes/app_router.dart';
import '../../shared/widgets/app_widgets.dart';

// ── Data Model ────────────────────────────────────────────────────────────────
class _OrderItem {
  final String title;
  final String location;
  final String datetime;
  final String price;
  final String imagePlaceholder;

  const _OrderItem({
    required this.title,
    required this.location,
    required this.datetime,
    required this.price,
    required this.imagePlaceholder,
  });
}

// ── Dummy Data ────────────────────────────────────────────────────────────────
const _orderItems = [
  _OrderItem(
    title: 'Vintage',
    location: 'Villa Kuningan',
    datetime: '25 November 2026 - 15:00',
    price: 'Rp500.0000',
    imagePlaceholder: 'V',
  ),
  _OrderItem(
    title: 'Coboy',
    location: 'Tamansari Equestrian Park',
    datetime: '11 November 2026 - 10:00',
    price: 'Rp500.0000',
    imagePlaceholder: 'C',
  ),
  _OrderItem(
    title: 'Harry Potter',
    location: 'Istana Stable Equestrian Sport',
    datetime: '12 November 2026 - 09:00',
    price: 'Rp500.0000',
    imagePlaceholder: 'H',
  ),
];

enum _PaymentMethod { qris, dana, bank, gopay }

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  _PaymentMethod? _selectedPayment;

  void _onPay() {
    if (_selectedPayment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pilih metode pembayaran dulu!',
              style: GoogleFonts.dmSans(color: Colors.white)),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }
    context.push(AppRoutes.successPayment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F3F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F3F7),
        elevation: 0,
        leading: const AppBackButton(),
        title: Text(
          'Checkout',
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Order Items ────────────────────────────────────────
                  ..._orderItems.map((item) => _OrderCard(item: item)),

                  const SizedBox(height: 20),

                  // ── Payment Method ─────────────────────────────────────
                  Text(
                    'Payment Method',
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2.8,
                    children: [
                      _PaymentTile(
                        label: 'QRIS',
                        icon: Icons.qr_code_2_rounded,
                        method: _PaymentMethod.qris,
                        selected: _selectedPayment,
                        onTap: (m) => setState(() => _selectedPayment = m),
                      ),
                      _PaymentTile(
                        label: 'Dana',
                        icon: Icons.account_balance_wallet_outlined,
                        method: _PaymentMethod.dana,
                        selected: _selectedPayment,
                        onTap: (m) => setState(() => _selectedPayment = m),
                      ),
                      _PaymentTile(
                        label: 'Bank',
                        icon: Icons.account_balance_outlined,
                        method: _PaymentMethod.bank,
                        selected: _selectedPayment,
                        onTap: (m) => setState(() => _selectedPayment = m),
                      ),
                      _PaymentTile(
                        label: 'GoPay',
                        icon: Icons.savings_outlined,
                        method: _PaymentMethod.gopay,
                        selected: _selectedPayment,
                        onTap: (m) => setState(() => _selectedPayment = m),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ── Bottom Total + Pay ─────────────────────────────────────────
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            decoration: BoxDecoration(
              color: const Color(0xFFD6DDE6),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Total',
                        style: GoogleFonts.dmSans(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500)),
                    Text('Rp1.500.000',
                        style: GoogleFonts.dmSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary)),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  height: 48,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: _onPay,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A6480),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                    child: Text('Pay',
                        style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
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

// ── Order Card ────────────────────────────────────────────────────────────────
class _OrderCard extends StatelessWidget {
  final _OrderItem item;
  const _OrderCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFDDE3EA),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image placeholder
          Container(
            width: 90,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.accentLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.camera_alt_outlined,
                color: AppColors.primary, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title,
                    style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.location_on_outlined,
                      size: 13, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(item.location,
                        style: GoogleFonts.dmSans(
                            fontSize: 12, color: AppColors.textSecondary)),
                  ),
                ]),
                const SizedBox(height: 2),
                Row(children: [
                  const Icon(Icons.access_time_outlined,
                      size: 13, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text(item.datetime,
                      style: GoogleFonts.dmSans(
                          fontSize: 12, color: AppColors.textSecondary)),
                ]),
                const SizedBox(height: 4),
                Text(item.price,
                    style: GoogleFonts.dmSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Payment Tile ──────────────────────────────────────────────────────────────
class _PaymentTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final _PaymentMethod method;
  final _PaymentMethod? selected;
  final ValueChanged<_PaymentMethod> onTap;

  const _PaymentTile({
    required this.label,
    required this.icon,
    required this.method,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == method;
    return GestureDetector(
      onTap: () => onTap(method),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.12) : const Color(0xFFDDE3EA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 22,
                color: isSelected ? AppColors.primary : AppColors.textSecondary),
            const SizedBox(width: 8),
            Text(label,
                style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? AppColors.primary : AppColors.textPrimary)),
          ],
        ),
      ),
    );
  }
}