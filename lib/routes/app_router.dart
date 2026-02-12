import 'package:go_router/go_router.dart';

import '../screens/app_shell_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/order_screen.dart';
import '../screens/item_detail_screen.dart';
import '../screens/account_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/app',
  routes: [
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
      ],
    ),

    // Item details (push on top of shell)
    GoRoute(
      path: '/item',
      builder: (context, state) {
        final payload = (state.extra as Map<String, dynamic>?) ?? {};
        return ItemDetailScreen(payload: payload);
      },
    ),

    // Account (from hamburger)
    GoRoute(
      path: '/account',
      builder: (context, state) => const AccountScreen(),
    ),
  ],
);
