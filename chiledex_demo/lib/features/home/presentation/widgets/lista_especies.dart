// features/home/presentation/widgets/lista_especies.dart

import 'package:chiledex_demo/core/domain/models/especie_model.dart';
import 'package:flutter/material.dart';
import '../../../../app/theme/app_theme.dart';

class SpeciesListTile extends StatelessWidget {
  final EspecieModel species;
  final VoidCallback onTap;

  const SpeciesListTile({
    super.key,
    required this.species,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String? imageUrl =
        (species.fotografias.isNotEmpty ?? false) ? species.fotografias.first.url : null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.cardWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE8E8E8)),
        ),
        child: Row(
          children: [
            // ── Imagen ──────────────────────────────
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: imageUrl != null
                  ? Image.network(
                      imageUrl,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return _ImagePlaceholder();
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          _ImagePlaceholder(),
                    )
                  : _ImagePlaceholder(),
            ),

            // ── Datos ────────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nombre común
                    Text(
                      species.nombreComun,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    // Nombre científico
                    Text(
                      species.nombreCientifico,
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: AppTheme.textGray,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Chips: categoría + estado de conservación
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        _Chip(
                          label: species.categoria,
                          color: AppTheme.primaryGreen,
                        ),
                        _Chip(
                          label: species.estadoConservacion,
                          color: _conservationColor(species.estadoConservacion),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ── Flecha ───────────────────────────────
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: AppTheme.textGray,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _conservationColor(String estado) {
    switch (estado) {
      case 'En Peligro':
        return Colors.red.shade600;
      case 'Vulnerable':
        return Colors.orange.shade600;
      default:
        return Colors.blueGrey;
    }
  }
}

// ── Widgets auxiliares ────────────────────────────────────

class _ImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      color: const Color(0xFFEEEEEE),
      child: const Icon(Icons.image_not_supported_outlined, color: Colors.grey),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;

  const _Chip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}