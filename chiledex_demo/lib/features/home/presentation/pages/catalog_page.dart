import 'package:chiledex_demo/core/domain/models/catalogo_filtro_model.dart';
import 'package:chiledex_demo/core/domain/models/especie_fotografia_model.dart';
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
  String _searchQuery = '';
  String _activeCategory = 'Todas';        // <- esto se sobreescribe en initState
  CatalogFilterModel _activeFilter = const CatalogFilterModel();

  // initState se ejecuta una sola vez cuando la pantalla se crea
  // Aquí tomamos la categoría que viene desde HomePage (si existe)
  @override
  void initState() {
    super.initState();
    _activeCategory = widget.categoriaInicial ?? 'Todas';
  }

  // ─────────────────────────────────────────────
  // DATOS HARDCODEADOS
  // Cuando se conecte la BD, esta lista se reemplaza
  // por la respuesta del repositorio de especies
  // ─────────────────────────────────────────────
  static final List<EspecieModel> _allSpecies = [
    EspecieModel(
      id: 1,
      nombreComun: 'Loica',
      nombreCientifico: 'Sturnella loyca',
      descripcion: 'Ave de pecho rojo característica de Chile.',
      categoria: 'Aves',
      estadoConservacion: 'Común',
      origen: 'Nativa',
      zonaGeografica: 'Zona Central y Sur',
      idEspecie: 1,
      habitat: 'Pastizales',
      fotografias: [
        EspecieFotografiaModel(
          id: 1,
          idEspecie: 1,
          url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcJ-0VvgAXf_36xe4Rvt_hrAo58VhASIHwGfiLMAi69E0bFu0OwzHVa8ABjUr1afXUpDYBIOxWy6G_5rQq4spV8GS6hyEsQhFi13O2oEPZGQ&s=10',
          orden: 1,
        ),
      ],
    ),
    EspecieModel(
      id: 2,
      idEspecie: 2,
      nombreComun: 'Pudú',
      nombreCientifico: 'Pudu puda',
      descripcion: 'El ciervo más pequeño del mundo.',
      categoria: 'Mamíferos',
      estadoConservacion: 'Vulnerable',
      origen: 'Nativa',
      tamanio: '35 - 45 cm',
      peso: '6 - 12 kg',
      zonaGeografica: 'Zona Sur',
      habitat: 'Bosque Templado',
      fotografias: [
        EspecieFotografiaModel(
          id: 1,
          idEspecie: 1,
          url: 'https://reforestemos.org/wp-content/uploads/2025/09/384401781-18388415197033867-431876921902592106-n.jpg',
          orden: 1,
        ),
      ],
    ),
    EspecieModel(
      id: 3,
      idEspecie: 3,
      nombreComun: 'Cóndor Andino',
      nombreCientifico: 'Vultur gryphus',
      descripcion: 'El ave voladora más grande del mundo.',
      categoria: 'Aves',
      estadoConservacion: 'Vulnerable',
      origen: 'Nativa',
      zonaGeografica: 'Cordillera de los Andes',
      habitat: 'Alturas',
      fotografias: [
        EspecieFotografiaModel(
          id: 1,
          idEspecie: 1,
          url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSD27-yyDH7KMUlJA7G64LHZ1_mJEu2Ud3yCmPFJBPldw&s',
          orden: 1,
        ),
      ],
    ),
    EspecieModel(
      id: 4,
      idEspecie: 4,
      nombreComun: 'Monito del Monte',
      nombreCientifico: 'Dromiciops gliroides',
      descripcion: 'Único marsupial de la familia Microbiotheriidae.',
      categoria: 'Mamíferos',
      estadoConservacion: 'En Peligro',
      origen: 'Endémica',
      zonaGeografica: 'Bosque Valdiviano',
      habitat: 'Árboles',
      fotografias: [
        EspecieFotografiaModel(
          id: 1,
          idEspecie: 1,
          url:
              'https://www.reporteagricola.cl/files/691395ab24e99_1200x719.jpg',
          orden: 1,
        ),
      ],
    ),
    EspecieModel(
      id: 5,
      idEspecie: 5,
      nombreComun: 'Ranita de Darwin',
      nombreCientifico: 'Rhinoderma darwinii',
      descripcion: 'Anfibio endémico del bosque templado.',
      categoria: 'Reptiles',
      estadoConservacion: 'En Peligro',
      origen: 'Endémica',
      zonaGeografica: 'Zona Sur',
      habitat: 'Vertientes y Hojarasca',
      fotografias: [
        EspecieFotografiaModel(
          id: 1,
          idEspecie: 1,
          url: 'https://imagenes.elpais.com/resizer/v2/4DTRZHZ3VBCNNP2CFVCCDRU4CE.JPG?auth=2224ae7b6a745406d5475720a7003952bdf892739e266c6980fb53bb7cd4604f&width=980&height=980&focal=2172%2C1439',
          orden: 1,
        ),
      ],
    ),
    EspecieModel(
      id: 6,
      idEspecie: 6,
      nombreComun: 'Zorro Chilla',
      nombreCientifico: 'Lycalopex griseus',
      descripcion: 'Zorro pequeño de la estepa patagónica.',
      categoria: 'Mamíferos',
      estadoConservacion: 'Común',
      origen: 'Nativa',
      zonaGeografica: 'Estepa Patagónica y Matorral',
      habitat: 'Matorral',
      fotografias: [
        EspecieFotografiaModel(
          id: 1,
          idEspecie: 1,
          url: 'https://parquevallelosulmos.cl/calbuco/wp-content/uploads/2018/10/zorrochilla.jpg',
          orden: 1,
        ),
      ],
    ),
    EspecieModel(
      id: 7,
      idEspecie: 7,
      nombreComun: 'Araña Pollito',
      nombreCientifico: 'Grammostola rosea',
      descripcion: 'Tarántula del norte y centro de Chile.',
      categoria: 'Reptiles',
      estadoConservacion: 'Común',
      origen: 'Nativa',
      zonaGeografica: 'Norte y Centro',
      habitat: 'Áreas Secas',
      fotografias: [
        EspecieFotografiaModel(
          id: 1,
          idEspecie: 1,
          url: 'https://upload.wikimedia.org/wikipedia/commons/2/22/Grammostola_rosea_adult_weiblich.jpg?utm_source=es.wikipedia.org&utm_campaign=index&utm_content=original',
          orden: 1,
        ),
      ],
    ),
  ];

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
                '450 Especies registradas en Chile',
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
                child: species.isEmpty
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
