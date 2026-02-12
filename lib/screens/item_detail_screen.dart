import 'package:flutter/material.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key, required this.payload});

  final Map<String, dynamic> payload;

  @override
  Widget build(BuildContext context) {
    final index = payload['index'] ?? 0;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('Item #$index'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Container(
                color: Colors.white.withValues(alpha: 0.10),
                height: 220,
                width: double.infinity,
                alignment: Alignment.center,
                child: Image.asset('assets/menu/flower.png', fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Flower (Demo)',
              style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'We’ll add: nose strength, indica/sativa/hybrid, and add-to-cart controls next.',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  // next step: hook into cart_controller
                  Navigator.pop(context);
                },
                child: const Text('Add to Cart (next)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
