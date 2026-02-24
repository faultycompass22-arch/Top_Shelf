// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'app_shell.dart';
import 'state/cart_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final cartStore = CartStore();

  runApp(TopShelfApp(cartStore: cartStore));
}

class TopShelfApp extends StatelessWidget {
  const TopShelfApp({super.key, required this.cartStore});
  final CartStore cartStore;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Top Shelf',
      home: AppShell(cartStore: cartStore),
    );
  }
}