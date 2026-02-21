// lib/features/home/widgets/home_header.dart

import 'package:flutter/material.dart';
import '../../../../../theme/tokens.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    this.onMenuTap,
    this.greeting = 'Hi Sean',
  });

  final VoidCallback? onMenuTap;
  final String greeting;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onMenuTap,
            borderRadius: BorderRadius.circular(14),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.menu, color: AppColors.textPrimary),
            ),
          ),
          Text(
            greeting,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}