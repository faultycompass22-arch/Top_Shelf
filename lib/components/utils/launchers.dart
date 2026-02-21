// lib/utils/launchers.dart

import 'package:url_launcher/url_launcher.dart';
import '../core/constants/app_constants.dart';

/// Text-to-order + Call-to-order launchers.
/// Set your phone number in:
///   lib/core/constants/app_constants.dart  -> AppConstants.orderPhone

Future<void> launchTextOrder({String? productName, String? body}) async {
  final phone = AppConstants.orderPhone;

  final message = body ??
      (productName == null || productName.trim().isEmpty
          ? "${AppConstants.smsGreeting}."
          : "${AppConstants.smsGreeting} $productName.");

  // sms:+1....?body=...
  final uri = Uri(
    scheme: 'sms',
    path: phone,
    queryParameters: <String, String>{
      'body': message,
    },
  );

  await _launch(uri);
}

Future<void> launchCallOrder() async {
  final phone = AppConstants.orderPhone;
  final uri = Uri(scheme: 'tel', path: phone);
  await _launch(uri);
}

Future<void> launchUrlExternal(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  await _launch(uri);
}

Future<void> _launch(Uri uri) async {
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}