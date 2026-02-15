import 'package:flutter/material.dart';

class BagBar extends StatelessWidget {
  final int count;
  final VoidCallback onTap;

  const BagBar({
    super.key,
    required this.count,
    required this.onTap,
  });

  static const Color kEmerald = Color(0xFF0F5C4A);
  static const Color kGold = Color(0xFFD7B46A);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 64,
          decoration: const BoxDecoration(
            color: kEmerald,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.shopping_bag_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                  Positioned(
                    top: 6,
                    right: 2,
                    child: Icon(
                      Icons.remove_red_eye,
                      size: 14,
                      color: kGold,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  '$count item${count == 1 ? '' : 's'} in bag',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Text(
                'View Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 6),
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