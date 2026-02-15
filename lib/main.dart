import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'routes/app_router.dart';
import 'state/cart_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const TopShelfApp());
}

class TopShelfApp extends StatelessWidget {
  const TopShelfApp({super.key});

  static const double _desktopThreshold = 800;
  static const double _maxAppWidth = 460;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartController(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isDesktopWide =
              constraints.maxWidth >= _desktopThreshold;

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark(),
            routerConfig: appRouter,
            builder: (context, child) {
              final app = child ?? const SizedBox.shrink();

              if (!isDesktopWide) {
                return app;
              }

              return ColoredBox(
                color: Colors.black,
                child: Center(
                  child: ConstrainedBox(
                    constraints:
                    const BoxConstraints(maxWidth: _maxAppWidth),
                    child: app,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}