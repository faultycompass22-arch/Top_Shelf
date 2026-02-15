import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final goingToAge = state.uri.path == '/age';
    final goingToDenied = state.uri.path == '/age-denied';

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
      builder: (context, state, child) =>
          AppShellScreen(child: child),
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

    GoRoute(
      path: '/item',
      builder: (context, state) {
        final payload =
            (state.extra as Map<String, dynamic>?) ?? {};
        return ItemDetailScreen(payload: payload);
      },
    ),

    GoRoute(
      path: '/my-profile',
      builder: (context, state) => const MyProfileScreen(),
    ),

    GoRoute(
      path: '/legal',
      builder: (context, state) =>
      const LegalDisclaimerScreen(),
    ),

    GoRoute(
      path: '/coa',
      builder: (context, state) => const CoaScreen(),
    ),
  ],
);