import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/menu_item.dart';

import '../screens/app_shell_screen.dart';
import '../screens/order_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/rewards_screen.dart';
import '../screens/account_screen.dart';
import '../screens/item_detail_screen.dart';

import '../screens/age_gate_screen.dart';
import '../screens/age_denied_screen.dart';
import '../screens/my_profile_screen.dart';
import '../screens/legal_disclaimer_screen.dart';
import '../screens/coa_screen.dart';

Future<bool> _isAgeVerified() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('age_verified') ?? false;
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/app',
  redirect: (context, state) async {
    final verified = await _isAgeVerified();
    final path = state.uri.path;

    final goingToAge = path == '/age';
    final goingToDenied = path == '/age-denied';

    if (!verified && !goingToAge && !goingToDenied) {
      return '/age';
    }

    if (verified && goingToAge) {
      return '/app';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/age',
      builder: (context, state) => const AgeGateScreen(),
    ),
    GoRoute(
      path: '/age-denied',
      builder: (context, state) => const AgeDeniedScreen(),
    ),

    ShellRoute(
      builder: (context, state, child) => AppShellScreen(child: child),
      routes: [
        GoRoute(
          path: '/app',
          builder: (context, state) => const OrderScreen(),
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) => const CartScreen(),
        ),
        GoRoute(
          path: '/rewards',
          builder: (context, state) => const RewardsScreen(),
        ),
        GoRoute(
          path: '/account',
          builder: (context, state) => const AccountScreen(),
        ),
      ],
    ),

    // ✅ Item detail expects a MenuItem passed in `extra`
    GoRoute(
      path: '/item',
      builder: (context, state) {
        final extra = state.extra;
        if (extra is! MenuItem) {
          return const _RouteErrorScreen(
            message: 'Missing MenuItem payload for /item',
          );
        }
        return ItemDetailScreen(item: extra);
      },
    ),

    GoRoute(
      path: '/my-profile',
      builder: (context, state) => const MyProfileScreen(),
    ),

    GoRoute(
      path: '/legal',
      builder: (context, state) => const LegalDisclaimerScreen(),
    ),

    // ✅ COA screen (safe compile version for now)
    GoRoute(
      path: '/coa',
      builder: (context, state) => const CoaScreen(),
    ),
  ],
);

class _RouteErrorScreen extends StatelessWidget {
  final String message;
  const _RouteErrorScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: Text(message),
      ),
    );
  }
}