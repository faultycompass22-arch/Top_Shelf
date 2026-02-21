// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'app_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Optional: keep UI consistent for a “premium” feel (no random rotations)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Optional: transparent system overlays (lets your UI feel more “edge-to-edge”)
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Optional: nicer crash surface instead of red error screen
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      color: const Color(0xFF111214),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Something went wrong.\n\n${details.exception}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFFE6E6E6)),
          ),
        ),
      ),
    );
  };

  runApp(const TreefireApp());
}

class TreefireApp extends StatelessWidget {
  const TreefireApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Treefire',

      // Keep both themes available (Checkout uses light theme)
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),

      // Tonight mode default = dark
      themeMode: ThemeMode.dark,

      // Root shell holds bottom nav + pages
      home: const AppShell(),
    );
  }
}