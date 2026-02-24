import 'package:flutter/material.dart';
import '../../theme/tokens.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: const Center(
        child: Text(
          'Search coming soon',
          style: TextStyle(
            color: AppColors.textMuted,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}