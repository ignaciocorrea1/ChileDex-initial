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
      debugShowCheckedModeBanner: false, // Quitar el banner de debug
      title: 'ChileDex',
      theme: AppTheme.theme, // Carga de la paleta de colores
      home: const MainScaffold(), // Carga de la pantalla de inicio
    );
  }
}