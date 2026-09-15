import 'package:flutter/material.dart';
import '../../../../app/theme/app_theme.dart';

class EmptyCatalogState extends StatelessWidget {
  const EmptyCatalogState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off,
              size: 40,
              color: AppTheme.textGray,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Información no encontrada',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'No se encontraron especies que\ncoincidan con tu búsqueda.\nIntenta con otros términos.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: AppTheme.textGray, height: 1.6),
          ),
        ],
      ),
    );
  }
}