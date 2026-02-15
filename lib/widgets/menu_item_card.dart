import 'package:flutter/material.dart';

class MenuItemCard extends StatelessWidget {
  final double radius;
  final String imagePath;
  final VoidCallback onTap;

  const MenuItemCard({
    super.key,
    this.radius = 22,
    required this.imagePath,
    required this.onTap,
  });

  // 🟢 COLOR-TWEAK: Emerald frame color
  static const Color kEmerald = Color(0xFF0F6B3D);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: Ink(
        decoration: BoxDecoration(
          // Emerald frame
          color: kEmerald,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.18),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.45),
              blurRadius: 14,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          // 🔵 UI-TWEAK: thickness of the emerald “frame”
          padding: const EdgeInsets.all(12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius - 10),
            child: Container(
              // 🤍 White insert (exact vibe from your screenshot)
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.12),
                  width: 1.2,
                ),
              ),
              child: Padding(
                // 🔵 UI-TWEAK: spacing inside the white insert
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius - 16),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}