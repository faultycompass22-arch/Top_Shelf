import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Simple in-memory gate (persistence later).
class AgeGateState {
  static bool verified21 = false;
  static bool denied = false;
}

class AgeGateScreen extends StatelessWidget {
  const AgeGateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              // 🟣 FONT-TWEAK: title styling
              const Text(
                '21+ Only',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                'You must be 21 years of age or older to enter.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),

              const Spacer(),

              // 🔵 UI-TWEAK: button spacing
              ElevatedButton(
                // 🟢 COLOR-TWEAK: button colors
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD7B46A),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  AgeGateState.verified21 = true;
                  AgeGateState.denied = false;
                  context.go('/login');
                },
                child: const Text('Yes, I am 21+'),
              ),
              const SizedBox(height: 12),

              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white24),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  AgeGateState.denied = true;
                  AgeGateState.verified21 = false;
                  context.go('/age-denied');
                },
                child: const Text('No'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}