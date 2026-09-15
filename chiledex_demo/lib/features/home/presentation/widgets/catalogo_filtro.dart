import 'package:flutter/material.dart';
import '../../../../app/theme/app_theme.dart';

class CategoryFilterBar extends StatelessWidget {
  final String activeCategory;
  final ValueChanged<String> onCategorySelected;

  // Categorías hardcodeadas — coinciden con el campo 'categoria' de SpeciesModel
  static const List<Map<String, dynamic>> _categories = [
    {'label': 'Todas', 'icon': Icons.grid_view},
    {'label': 'Aves', 'icon': Icons.flutter_dash},
    {'label': 'Mamíferos', 'icon': Icons.pets},
    {'label': 'Flora', 'icon': Icons.eco},
    {'label': 'Reptiles', 'icon': Icons.bug_report},
  ];

  const CategoryFilterBar({
    super.key,
    required this.activeCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories.map((cat) {
          final isActive = cat['label'] == activeCategory;
          return GestureDetector(
            onTap: () => onCategorySelected(cat['label']),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? AppTheme.primaryGreen : AppTheme.cardWhite,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isActive
                      ? AppTheme.primaryGreen
                      : const Color(0xFFE0E0E0),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    cat['icon'] as IconData,
                    size: 15,
                    color: isActive ? Colors.white : AppTheme.textGray,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    cat['label'],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isActive ? Colors.white : AppTheme.textDark,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}