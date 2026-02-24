import 'package:flutter/material.dart';
import 'package:treefire/components/utils/constants.dart';

class ThcaFlowerHeaderBar extends StatelessWidget {
  final String leftTop;
  final String leftBottom;
  final String? asset; // e.g. assets/images/flower_bar.png
  const ThcaFlowerHeaderBar({
    super.key,
    required this.leftTop,
    required this.leftBottom,
    this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: AppColors.gold2.withValues(alpha: 0.55)),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1410),
            Color(0xFF0E0B0A),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x77000000),
            blurRadius: 18,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  leftTop,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  leftBottom,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.gold.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(999),
                  ),
                )
              ],
            ),
          ),
          if (asset != null) ...[
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(
                width: 72,
                height: 48,
                child: Image.asset(asset!, fit: BoxFit.cover),
              ),
            ),
          ],
        ],
      ),
    );
  }
}