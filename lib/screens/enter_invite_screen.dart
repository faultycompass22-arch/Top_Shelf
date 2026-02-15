import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/invite_service.dart';

class EnterInviteScreen extends StatefulWidget {
  const EnterInviteScreen({super.key});

  @override
  State<EnterInviteScreen> createState() => _EnterInviteScreenState();
}

class _EnterInviteScreenState extends State<EnterInviteScreen> {
  final _inviteService = InviteService();
  final _controller = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _submit() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final code = _controller.text.trim().toUpperCase();
    final ok = await _inviteService.verifyAndConsumeCode(code);

    if (!mounted) return;

    if (!ok) {
      setState(() {
        _loading = false;
        _error = 'Invalid invite code.';
      });
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('invite_ok', true);
    await prefs.setString('invite_code', code);

    if (!mounted) return;
    context.go('/app');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Invite Only',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your invite code to continue.',
                style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 18),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: TextField(
                  controller: _controller,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'e.g. AAA123',
                  ),
                ),
              ),

              if (_error != null) ...[
                const SizedBox(height: 10),
                Text(_error!, style: const TextStyle(color: Colors.redAccent)),
              ],

              const SizedBox(height: 14),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD7B46A),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _loading
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Text(
                    'Continue',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              const Text(
                'Tip: QR codes should open a link like:\nhttps://yourdomain.com/?code=AAA123',
                style: TextStyle(color: Colors.white54, height: 1.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}