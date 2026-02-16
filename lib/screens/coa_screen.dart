import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CoaScreen extends StatelessWidget {
  const CoaScreen({
    super.key,
    this.coaUrl,
  });

  final String? coaUrl;

  static const Color kOffWhite = Color(0xFFF6F1E7);
  static const Color kEyeGreen = Color(0xFF1E6B52);

  @override
  Widget build(BuildContext context) {
    final url = (coaUrl ?? '').trim();

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
                child: url.isNotEmpty
                    ? _CoaSingle(url: url)
                    : ListView(
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

class _CoaSingle extends StatelessWidget {
  final String url;
  const _CoaSingle({required this.url});

  static const Color kEyeGreen = Color(0xFF1E6B52);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kEyeGreen, width: 2),
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
          const Text(
            'Certificate of Analysis',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'COA URL:',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 6),
          SelectableText(
            url,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Note: this is wired and ready. Next we can add an in-app PDF viewer or open-in-browser button (admin-controlled).',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),
        ],
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
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
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

  static const Color kEyeGreen = Color(0xFF1E6B52);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kEyeGreen, width: 2),
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
              color: kEyeGreen,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}