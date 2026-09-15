import 'package:chiledex_demo/core/domain/models/catalogo_filtro_model.dart';
import 'package:flutter/material.dart';
import '../../../../app/theme/app_theme.dart';

class FilterBottomSheet extends StatefulWidget {
  final CatalogFilterModel currentFilter;
  final ValueChanged<CatalogFilterModel> onApply;

  const FilterBottomSheet({
    super.key,
    required this.currentFilter,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late CatalogFilterModel _filter;

  // Opciones disponibles — luego vendrán de la BD
  static const _estadosConservacion = [
    {'label': 'En Peligro', 'code': 'EN', 'color': 0xFFE53935},
    {'label': 'Vulnerable', 'code': 'VU', 'color': 0xFFFFA726},
    {'label': 'Común', 'code': 'LC', 'color': 0xFF66BB6A},
  ];

  static const _ecosistema = ['Norte', 'Centro', 'Sur'];
  static const _habitats = ['Bosque', 'Montaña', 'Costa', 'Humedal'];

  // Conteo hardcodeado — luego vendrá de la BD
  static const _estadoCount = {'EN': 12, 'VU': 24, 'LC': 115};

  @override
  void initState() {
    super.initState();
    _filter = widget.currentFilter;
  }

  void _toggleEstado(String estado) {
    final list = List<String>.from(_filter.estadosConservacion);
    list.contains(estado) ? list.remove(estado) : list.add(estado);
    setState(() => _filter = _filter.copyWith(estadosConservacion: list));
  }

  void _toggleRegion(String region) {
    final list = List<String>.from(_filter.ecosistema);
    list.contains(region) ? list.remove(region) : list.add(region);
    setState(() => _filter = _filter.copyWith(ecosistema: list));
  }

  void _toggleHabitat(String habitat) {
    final list = List<String>.from(_filter.habitats);
    list.contains(habitat) ? list.remove(habitat) : list.add(habitat);
    setState(() => _filter = _filter.copyWith(habitats: list));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFFF5F0E8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Título
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filtrar especies',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, size: 16),
                ),
              ),
            ],
          ),

          const Divider(),
          const SizedBox(height: 12),

          // Estado de conservación
          Text(
            'ESTADO DE CONSERVACIÓN',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppTheme.textGray,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          ..._estadosConservacion.map((e) {
            final isSelected =
                _filter.estadosConservacion.contains(e['code']);
            return GestureDetector(
              onTap: () => _toggleEstado(e['code'] as String),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    // Checkbox personalizado
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primaryGreen
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.primaryGreen
                              : const Color(0xFFE0E0E0),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: isSelected
                          ? const Icon(Icons.check,
                              size: 14, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Text(e['label'] as String,
                        style: const TextStyle(fontSize: 15)),
                    const SizedBox(width: 8),
                    // Badge con código
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Color(e['color'] as int).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        e['code'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(e['color'] as int),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${_estadoCount[e['code']]}',
                      style: TextStyle(color: AppTheme.textGray),
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 8),

          // Región
          Text(
            'REGIÓN DE AVISTAMIENTO',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppTheme.textGray,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: _ecosistema.map((r) {
              final isSelected = _filter.ecosistema.contains(r);
              return GestureDetector(
                onTap: () => _toggleRegion(r),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.primaryGreen
                        : AppTheme.cardWhite,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.primaryGreen
                          : const Color(0xFFE0E0E0),
                    ),
                  ),
                  child: Text(
                    r,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppTheme.textDark,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          // Hábitat
          Text(
            'HÁBITAT',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppTheme.textGray,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: _habitats.map((h) {
              final isSelected = _filter.habitats.contains(h);
              return GestureDetector(
                onTap: () => _toggleHabitat(h),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.primaryGreen
                        : AppTheme.cardWhite,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.primaryGreen
                          : const Color(0xFFE0E0E0),
                    ),
                  ),
                  child: Text(
                    h,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppTheme.textDark,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 28),

          // Botones
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _filter = const CatalogFilterModel();
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 52),
                    side: BorderSide(color: const Color(0xFFE0E0E0)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Limpiar',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApply(_filter);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    minimumSize: const Size(0, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Aplicar filtros'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}