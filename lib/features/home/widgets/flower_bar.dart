// lib/features/home/widgets/flower_bar.dart
import 'package:flutter/material.dart';
import '../../../theme/tokens.dart';

class FlowerBar extends StatelessWidget {
  const FlowerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Premium Indoor',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'TOP SHELF CERTIFIED',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.6,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}