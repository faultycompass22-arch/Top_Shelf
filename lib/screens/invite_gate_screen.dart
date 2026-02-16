import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/invite_service.dart';

class InviteGateScreen extends StatefulWidget {
  const InviteGateScreen({super.key});

  @override
  State<InviteGateScreen> createState() => _InviteGateScreenState();
}

class _InviteGateScreenState extends State<InviteGateScreen> {
  final _inviteService = InviteService();

  @override
  void initState() {
    super.initState();
    _boot();
  }

  Future<void> _boot() async {
    final prefs = await SharedPreferences.getInstance();
    final inviteOk = prefs.getBool('invite_ok') ?? false;

    if (inviteOk && mounted) {
      context.go('/app');
      return;
    }

    // PWA/web deep link support: https://domain.com/?code=AAA123
    final codeFromUrl = Uri.base.queryParameters['code'];

    if (codeFromUrl != null && codeFromUrl.trim().isNotEmpty) {
      final ok = await _inviteService.verifyAndConsumeCode(codeFromUrl);
      if (ok) {
        await prefs.setBool('invite_ok', true);
        await prefs.setString('invite_code', codeFromUrl.trim().toUpperCase());
        if (mounted) context.go('/app');
        return;
      }
    }

    if (mounted) context.go('/enter-invite');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}