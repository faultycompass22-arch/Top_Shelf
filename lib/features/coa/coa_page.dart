import 'package:flutter/material.dart';
import 'package:treefire/components/utils/constants.dart';

class CoaPage extends StatelessWidget {
  const CoaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.bg,
      body: Center(
        child: Text('COA', style: TextStyle(color: AppColors.text, fontWeight: FontWeight.w900, fontSize: 20)),
      ),
    );
  }
}