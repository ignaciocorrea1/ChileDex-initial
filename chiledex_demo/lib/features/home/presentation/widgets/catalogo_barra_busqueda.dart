import 'package:flutter/material.dart';
import '../../../../app/theme/app_theme.dart';

class CatalogSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const CatalogSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Buscar especie, planta o insecto...',
        prefixIcon: Icon(Icons.search, color: AppTheme.textGray),
        hintStyle: TextStyle(color: AppTheme.textGray, fontSize: 14),
      ),
    );
  }
}