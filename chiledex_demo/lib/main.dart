import 'package:chiledex_demo/app/navigation/main_scaffold.dart';

import 'package:flutter/material.dart';

import 'package:chiledex_demo/app/theme/app_theme.dart';


void main() {
  runApp(const ChileDexApp());
}

class ChileDexApp extends StatelessWidget {
  const ChileDexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChileDex',
      theme: AppTheme.theme,
      home: const MainScaffold(),
    );
  }
}
