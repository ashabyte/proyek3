import 'package:flutter/material.dart';
import '../../shared/widgets/app_widgets.dart';

class CartSelectScreen extends StatelessWidget {
  const CartSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemplatePage(
      title: 'Pilih Pesanan',
      icon: Icons.shopping_cart_outlined,
    );
  }
}
