import 'package:flutter/material.dart';
import 'package:treefire/components/utils/constants.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.bg,
      body: Center(
        child: Text('Checkout', style: TextStyle(color: AppColors.text, fontWeight: FontWeight.w900, fontSize: 20)),
      ),
    );
  }
}