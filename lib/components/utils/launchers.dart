import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';

Future<void> launchTextOrder({String? body}) async {
  final message =
  (body != null && body.trim().isNotEmpty)
      ? body.trim()
      : "Hi! I'd like to place an order from ${AppConstants.storeName}.";

  final uri = Uri(
    scheme: 'sms',
    path: AppConstants.orderPhone,
    queryParameters: {'body': message},
  );

  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

Future<void> launchCallOrder() async {
  final uri = Uri(
    scheme: 'tel',
    path: AppConstants.orderPhone,
  );

  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

Future<void> launchUrlExternal(String url) async {
  final uri = Uri.parse(url.trim());
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}