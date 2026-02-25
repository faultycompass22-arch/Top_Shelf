import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'age_gate.dart';
import 'state/cart_store.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(TopShelfApp(cartStore: CartStore()));
}

class TopShelfApp extends StatelessWidget {
  const TopShelfApp({super.key, required this.cartStore});
  final CartStore cartStore;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Top Shelf',
      theme: AppTheme.dark(),
      home: AgeGate(cartStore: cartStore),
    );
  }
}