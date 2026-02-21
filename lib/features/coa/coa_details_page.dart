// lib/features/coa/coa_details_page.dart

import 'package:flutter/material.dart';
import '../../theme/tokens.dart';

class CoaDetailsPage extends StatelessWidget {
  const CoaDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'COA',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.schedule,
                size: 48,
                color: AppColors.gold,
              ),
              SizedBox(height: 20),
              Text(
                'Coming Soon',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Certificates of Analysis are available upon request.\n\nPlease text or call to receive lab reports.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}