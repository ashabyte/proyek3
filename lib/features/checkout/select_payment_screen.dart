import 'package:flutter/material.dart';
import '../../shared/widgets/app_widgets.dart';

class SelectPaymentScreen extends StatelessWidget {
  const SelectPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemplatePage(
      title: 'Pilih Pembayaran',
      icon: Icons.payment_outlined,
    );
  }
}
