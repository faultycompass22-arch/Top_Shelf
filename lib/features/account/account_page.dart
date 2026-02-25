import 'package:flutter/material.dart';
import '../../theme/tokens.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Account (coming soon)', style: AppText.h1),
        ),
      ),
    );
  }
}