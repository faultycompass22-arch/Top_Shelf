import 'package:flutter/material.dart';

class BagBar extends StatelessWidget {
  final int count;
  final int totalCents;
  final VoidCallback onTap;

  const BagBar({
    super.key,
    required this.count,
    required this.totalCents,
    required this.onTap,
  });

  static const Color kEyeGreen = Color(0xFF1E6B52);

  String _money(int cents) => '\$${(cents / 100).toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();

    return SafeArea(
      top: false,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 66,
          decoration: const BoxDecoration(color: kEyeGreen),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              const Icon(
                Icons.shopping_bag_rounded,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '$count item${count == 1 ? '' : 's'} • ${_money(totalCents)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Text(
                'View Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}