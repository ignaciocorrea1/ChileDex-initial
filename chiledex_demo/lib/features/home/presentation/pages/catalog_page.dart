import 'package:chiledex_demo/core/domain/models/catalogo_filtro_model.dart';
import 'package:chiledex_demo/core/data/services/chiledex_api.dart';
import 'package:chiledex_demo/core/domain/models/especie_model.dart';
import 'package:chiledex_demo/features/home/presentation/pages/specieDetail_page.dart';
import 'package:chiledex_demo/features/home/presentation/widgets/boton_filtro.dart';
import 'package:chiledex_demo/features/home/presentation/widgets/catalogo_barra_busqueda.dart';
import 'package:chiledex_demo/features/home/presentation/widgets/catalogo_filtro.dart';
import 'package:chiledex_demo/features/home/presentation/widgets/catalogo_vacio.dart';
import 'package:chiledex_demo/features/home/presentation/widgets/lista_especies.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/theme/app_theme.dart';

class CatalogPage extends StatefulWidget {
  final String? categoriaInicial; // nueva propiedad

  const CatalogPage({super.key, this.categoriaInicial});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final _searchController = TextEditingController();
  final _api = ChiledexApi();
  String _searchQuery = '';
  String _activeCategory = 'Todas';
  CatalogFilterModel _activeFilter = const CatalogFilterModel();
  List<EspecieModel> _allSpecies = [];
  bool _isLoading = true;
  String? _loadError;

  // initState se ejecuta una sola vez cuando la pantalla se crea
  // Aquí tomamos la categoría que viene desde HomePage (si existe)
  @override
  void initState() {
    super.initState();
    _activeCategory = widget.categoriaInicial ?? 'Todas';
    _loadSpecies();
  }

  Future<void> _loadSpecies() async {
    try {
      final species = await _api.obtenerEspecies();
      if (!mounted) return;
      setState(() {
        _allSpecies = species;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _loadError = error.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────────
  // Aplica búsqueda, categoría y filtros sobre la lista completa
  // Cuando haya BD, este método recibirá la lista del repositorio
  // ─────────────────────────────────────────────
  List<EspecieModel> get _filteredSpecies {
    List<EspecieModel> result = _allSpecies;

    // Filtro por búsqueda de texto
    if (_searchQuery.isNotEmpty) {
      result = result.where((s) {
        return s.nombreComun.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ) ||
            s.nombreCientifico.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            );
      }).toList();
    }

    // Filtro por categoría del carousel
    if (_activeCategory != 'Todas') {
      result = result.where((s) => s.categoria == _activeCategory).toList();
    }

    // Filtro por estado de conservación
    if (_activeFilter.estadosConservacion.isNotEmpty) {
      result = result.where((s) {
        return _activeFilter.estadosConservacion.contains(s.estadoConservacion);
      }).toList();
    }

    // Orden alfabético
    result.sort(
      (a, b) => _activeFilter.ordenAlfabetico == 'A-Z'
          ? a.nombreComun.compareTo(b.nombreComun)
          : b.nombreComun.compareTo(a.nombreComun),
    );

    return result;
  }

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterBottomSheet(
        currentFilter: _activeFilter,
        onApply: (newFilter) {
          setState(() => _activeFilter = newFilter);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final species = _filteredSpecies;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Título
              Text(
                'Catálogo de Especies',
                style: GoogleFonts.outfit(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                '${_allSpecies.length} especies registradas en Chile',
                style: TextStyle(fontSize: 13, color: AppTheme.textGray),
              ),
              const SizedBox(height: 16),

              // Buscador
              CatalogSearchBar(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
              const SizedBox(height: 14),

              // Carousel de categorías
              CategoryFilterBar(
                activeCategory: _activeCategory,
                onCategorySelected: (cat) =>
                    setState(() => _activeCategory = cat),
              ),
              const SizedBox(height: 14),

              // Ordenar y filtros
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botón ordenar A-Z / Z-A
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _activeFilter = _activeFilter.copyWith(
                          ordenAlfabetico:
                              _activeFilter.ordenAlfabetico == 'A-Z'
                              ? 'Z-A'
                              : 'A-Z',
                        );
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          'Ordenar por: ',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.textGray,
                          ),
                        ),
                        Text(
                          _activeFilter.ordenAlfabetico,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryGreen,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: AppTheme.primaryGreen,
                          size: 18,
                        ),
                      ],
                    ),
                  ),

                  // Botón filtros
                  GestureDetector(
                    onTap: _openFilterSheet,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.cardWhite,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.tune, size: 16, color: AppTheme.textDark),
                          const SizedBox(width: 6),
                          Text(
                            'Filtros',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Lista de especies o estado vacío
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _loadError != null
                    ? Center(
                        child: Text(
                          _loadError!,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppTheme.textGray),
                        ),
                      )
                    : species.isEmpty
                    ? const EmptyCatalogState()
                    : ListView.builder(
                        itemCount: species.length,
                        itemBuilder: (context, index) {
                          return SpeciesListTile(
                            species: species[index],
                            onTap: () {
                              // Navigator.push abre una nueva pantalla encima de la actual
                              // y permite volver con el botón de regreso
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EspecieDetailPage(
                                    especie: species[index],
                                  ),
                                ),
                              );

                              // Aquí irá la navegación a SpeciesDetailPage
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
