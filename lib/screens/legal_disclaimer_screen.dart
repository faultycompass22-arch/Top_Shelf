import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LegalDisclaimerScreen extends StatelessWidget {
  const LegalDisclaimerScreen({super.key});

  static const Color kOffWhite = Color(0xFFF6F1E7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(
              title: 'Legal Disclaimer',
              onBack: () => context.pop(),
            ),
            Expanded(
              child: Container(
                color: kOffWhite,
                padding: const EdgeInsets.all(20),
                child: const SingleChildScrollView(
                  child: Text(
                    'All products are intended for adults 21+ only.\n\n'
                        'By using this platform, you confirm that you are of legal age '
                        'and understand all applicable local and federal regulations.\n\n'
                        'Products are sold in compliance with current hemp regulations. '
                        'Always consume responsibly.\n\n'
                        'Further compliance language and full legal text will be '
                        'loaded dynamically in production.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                      color: Colors.black,
                    ),
                  ),
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
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}