import 'package:flutter/material.dart';
import 'app_shell.dart';
import 'state/cart_store.dart';
import 'theme/tokens.dart';

class AgeGate extends StatefulWidget {
  const AgeGate({super.key, required this.cartStore});
  final CartStore cartStore;

  @override
  State<AgeGate> createState() => _AgeGateState();
}

class _AgeGateState extends State<AgeGate> {
  bool _confirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.stroke),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Age Verification', style: AppText.h2),
                    const SizedBox(height: 10),
                    Text(
                      'You must be 21+ to enter.',
                      style: AppText.body.copyWith(color: AppColors.muted),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Checkbox(
                          value: _confirmed,
                          onChanged: (v) => setState(() => _confirmed = v ?? false),
                          activeColor: AppColors.gold,
                        ),
                        Expanded(
                          child: Text('I confirm I am 21 or older.', style: AppText.body),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _confirmed
                            ? () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => AppShell(cartStore: widget.cartStore),
                            ),
                          );
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.gold,
                          disabledBackgroundColor: AppColors.gold.withOpacity(.25),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Enter'),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text('TreeFire Hemp & Co', style: AppText.caption.copyWith(color: AppColors.muted)),
            ],
          ),
        ),
      ),
    );
  }
}