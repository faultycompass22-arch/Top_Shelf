import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.subtitle,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // DEV NAV BUTTONS — remove later
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () => context.go(AppRoutes.shell),
                  child: const Text('Go: App Shell'),
                ),
                OutlinedButton(
                  onPressed: () => context.go(AppRoutes.adminInvites),
                  child: const Text('Go: Admin Invites'),
                ),
                OutlinedButton(
                  onPressed: () => context.go(AppRoutes.notInvited),
                  child: const Text('Go: Not Invited'),
                ),
                OutlinedButton(
                  onPressed: () => context.go(AppRoutes.finishSignIn),
                  child: const Text('Go: Finish Sign-In'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
