import 'package:flutter/material.dart';
import '../../components/utils/constants.dart';
import '../../components/utils/launchers.dart';
import '../../state/cart_store.dart';
import '../../theme/tokens.dart';

class CoaPage extends StatelessWidget {
  const CoaPage({super.key, required this.cartStore});
  final CartStore cartStore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('COA', style: AppText.h1),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.stroke),
                ),
                child: Text(
                  'Coming soon.\n\nText your order and request COAs — we’ll send the full list.',
                  style: AppText.body.copyWith(color: AppColors.muted),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.stroke),
                ),
                child: Text(
                  'Tip: Add items to your cart first, then Text to Order.\n\nCOA requests are handled via text for now.',
                  style: AppText.body.copyWith(color: AppColors.muted),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: OutlinedButton(
                        onPressed: () async => launchTel(AppConstants.callPhone),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.text,
                          side: BorderSide(color: AppColors.stroke),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('Call'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () async {
                          await launchSms(AppConstants.smsPhone, message: 'Requesting COAs / full list.');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.gold,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('Text to Order'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}