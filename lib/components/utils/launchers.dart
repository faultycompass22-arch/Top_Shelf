import 'package:url_launcher/url_launcher.dart';

Future<void> launchSms(String phone, {String message = ''}) async {
  final uri = Uri.parse('sms:$phone${message.isEmpty ? '' : '?body=${Uri.encodeComponent(message)}'}');
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch SMS');
  }
}

Future<void> launchTel(String phone) async {
  final uri = Uri.parse('tel:$phone');
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch phone');
  }
}