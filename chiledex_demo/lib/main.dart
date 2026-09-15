import 'package:flutter/material.dart';

import 'package:chiledex_demo/app/theme/app_theme.dart';
import 'package:chiledex_demo/features/auth/presentation/pages/login_page.dart';

void main() {
  runApp(const ChileDexApp());
}

class ChileDexApp extends StatelessWidget {
  const ChileDexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quitar el banner de debug
      title: 'ChileDex',
      theme: AppTheme.theme, // Carga de la paleta de colores
      home: const LoginPage(),
    );
  }
}