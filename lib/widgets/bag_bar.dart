import 'package:flutter/material.dart';

class BagBar extends StatelessWidget {
  final int count;
  final VoidCallback onTap;

  const BagBar({
    super.key,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: const Offset(0, 8),
                  color: Colors.black.withValues(alpha: 0.35),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_bag_outlined, color: Color(0xFFD7B46A)),
                const SizedBox(width: 10),
                Text(
                  '$count item${count == 1 ? '' : 's'} in bag — View Cart',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
