import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CoaScreen extends StatelessWidget {
  const CoaScreen({super.key});

  static const Color kOffWhite = Color(0xFFF6F1E7);
  static const Color kEmerald = Color(0xFF0F5C4A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(
              title: 'COA (Certificate of Analysis)',
              onBack: () => context.pop(),
            ),
            Expanded(
              child: Container(
                color: kOffWhite,
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: const [
                    _CoaCard(
                      productName: 'Product Batch A',
                      lab: 'Verified Lab',
                      date: 'MM/DD/YYYY',
                    ),
                    SizedBox(height: 16),
                    _CoaCard(
                      productName: 'Product Batch B',
                      lab: 'Verified Lab',
                      date: 'MM/DD/YYYY',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const _TopBar({
    required this.title,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          const SizedBox(width: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _CoaCard extends StatelessWidget {
  final String productName;
  final String lab;
  final String date;

  const _CoaCard({
    required this.productName,
    required this.lab,
    required this.date,
  });

  static const Color kEmerald = Color(0xFF0F5C4A);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kEmerald, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Lab: $lab',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Test Date: $date',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'View Report',
            style: TextStyle(
              color: kEmerald,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}