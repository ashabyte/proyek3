import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/app_widgets.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppBackButton(),
        title: Text(
          'Denio Imagine',
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  // ── QR Code ──────────────────────────────────────────
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: CustomPaint(
                      painter: _QrPlaceholderPainter(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Scan this QR code for quick\nyearbook photo booking.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Booking Info Card ─────────────────────────────────
                  _InfoCard(
                    rows: const [
                      _InfoRow(label: 'Customer Name', value: 'Nathan'),
                      _InfoRow(label: 'Phone', value: '+62 8954 1484 9044'),
                      _InfoRow(label: 'Booking Date', value: 'November 25, 2026'),
                      _InfoRow(label: 'Booking Time', value: '15:00'),
                      _InfoRow(label: 'Booking Place', value: 'Villa Kuningan'),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ── Theme & Price Card ────────────────────────────────
                  _InfoCard(
                    rows: const [
                      _InfoRow(label: 'Theme', value: 'Vintage'),
                      _InfoRow(label: 'Total Price', value: 'Rp500.000'),
                    ],
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // ── Download Button ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: implement download/share receipt
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Receipt didownload!',
                          style: GoogleFonts.dmSans(color: Colors.white)),
                      backgroundColor: const Color(0xFF2DCB73),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A6480),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: Text('Download Receipt',
                    style: GoogleFonts.dmSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Info Card ─────────────────────────────────────────────────────────────────
class _InfoCard extends StatelessWidget {
  final List<_InfoRow> rows;
  const _InfoCard({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: rows.map((row) {
          final isLast = rows.last == row;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(row.label,
                        style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary)),
                    Text(row.value,
                        style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: AppColors.textSecondary)),
                  ],
                ),
              ),
              if (!isLast)
                const Divider(height: 1, thickness: 1, color: AppColors.border),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _InfoRow {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});
}

// ── QR Placeholder Painter ────────────────────────────────────────────────────
class _QrPlaceholderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final cellSize = size.width / 21;

    // Simple QR-like pattern (corners + random dots)
    void drawCell(int col, int row) {
      canvas.drawRect(
        Rect.fromLTWH(col * cellSize, row * cellSize, cellSize - 1, cellSize - 1),
        paint,
      );
    }

    // Top-left corner square
    for (int r = 0; r < 7; r++) {
      for (int c = 0; c < 7; c++) {
        if (r == 0 || r == 6 || c == 0 || c == 6 || (r >= 2 && r <= 4 && c >= 2 && c <= 4)) {
          drawCell(c, r);
        }
      }
    }
    // Top-right corner square
    for (int r = 0; r < 7; r++) {
      for (int c = 14; c < 21; c++) {
        if (r == 0 || r == 6 || c == 14 || c == 20 || (r >= 2 && r <= 4 && c >= 16 && c <= 18)) {
          drawCell(c, r);
        }
      }
    }
    // Bottom-left corner square
    for (int r = 14; r < 21; r++) {
      for (int c = 0; c < 7; c++) {
        if (r == 14 || r == 20 || c == 0 || c == 6 || (r >= 16 && r <= 18 && c >= 2 && c <= 4)) {
          drawCell(c, r);
        }
      }
    }
    // Random data dots
    final dots = [
      [8,0],[10,0],[12,0],[9,1],[11,1],[8,2],[10,2],[12,2],
      [8,4],[9,4],[11,4],[8,6],[10,6],[12,6],[9,7],[11,7],
      [8,8],[10,8],[12,8],[9,9],[11,9],[8,10],[10,10],[12,10],
      [0,8],[2,8],[4,8],[0,10],[2,10],[4,10],[0,12],[2,12],
      [8,12],[10,12],[12,12],[9,13],[11,13],[8,14],[10,14],[12,14],
      [14,8],[16,8],[18,8],[15,9],[17,9],[14,10],[16,10],[18,10],
      [14,12],[16,12],[18,12],[15,13],[17,13],[14,14],[16,14],[18,14],
      [8,16],[10,16],[12,16],[9,17],[11,17],[8,18],[10,18],[12,18],
      [14,16],[16,16],[18,16],[20,16],[15,17],[17,17],[14,18],[16,18],
    ];
    for (final dot in dots) {
      drawCell(dot[0], dot[1]);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}