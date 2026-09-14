import 'package:chiledex_demo/app/theme/app_theme.dart';
import 'package:chiledex_demo/core/domain/models/especie_fotografia_model.dart';
import 'package:chiledex_demo/core/domain/models/especie_model.dart';
import 'package:chiledex_demo/features/home/presentation/pages/specieDetail_page.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  static final List<EspecieModel> _especies = [
    EspecieModel(
      id: 1,
      idEspecie: 1,
      nombreComun: 'Loica',
      nombreCientifico: 'Sturnella loyca',
      descripcion: 'Ave de pecho rojo característica de los campos chilenos.',
      categoria: 'Ave',
      estadoConservacion: 'Común',
      zonaGeografica: 'Zona Central y Sur',
      fotografias: [
        EspecieFotografiaModel(
          id: 1,
          idEspecie: 1,
          orden: 1,
          url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXg0E0LP4goXweCFFn7z5T5r1Kf4bOlY_voTaunvBqSA&s=10',
        ),
      ],
    ),
    EspecieModel(
      id: 2,
      idEspecie: 2,
      nombreComun: 'Pudú',
      nombreCientifico: 'Pudu puda',
      descripcion: 'El ciervo más pequeño del mundo.',
      categoria: 'Mamífero',
      estadoConservacion: 'Vulnerable',
      zonaGeografica: 'Zona Sur',
      fotografias: [
        EspecieFotografiaModel(
          id: 1,
          idEspecie: 2,
          orden: 1,
          url: 'https://reforestemos.org/wp-content/uploads/2025/09/384401781-18388415197033867-431876921902592106-n.jpg',
        ),
      ],
    ),
    EspecieModel(
      id: 3,
      idEspecie: 3,
      nombreComun: 'Cóndor Andino',
      nombreCientifico: 'Vultur gryphus',
      descripcion: 'El ave voladora más grande del mundo.',
      categoria: 'Ave',
      estadoConservacion: 'Vulnerable',
      zonaGeografica: 'Cordillera de los Andes',
      fotografias: [
        EspecieFotografiaModel(
          id: 1,
          idEspecie: 3,
          orden: 1,
          url: 'https://static.wikia.nocookie.net/reinoanimalia/images/d/d1/Andean_condor_by_Alamy.jpg/revision/latest/thumbnail/width/360/height/360?cb=20250902201815&path-prefix=es',
        ),
      ],
    ),
    EspecieModel(
      id: 4,
      idEspecie: 4,
      nombreComun: 'Monito del Monte',
      nombreCientifico: 'Dromiciops gliroides',
      descripcion: 'Único marsupial viviente de la familia Microbiotheriidae.',
      categoria: 'Mamífero',
      estadoConservacion: 'En Peligro',
      zonaGeografica: 'Bosque Valdiviano',
      fotografias: [
        EspecieFotografiaModel(
          id: 1,
          idEspecie: 4,
          orden: 1,
          url: 'https://upload.wikimedia.org/wikipedia/commons/5/51/Monito_del_Monte_ps6.jpg',
        ),
      ],
    ),
    EspecieModel(
      id: 5,
      idEspecie: 5,
      nombreComun: 'Ranita de Darwin',
      nombreCientifico: 'Rhinoderma darwinii',
      descripcion: 'Pequeño anfibio endémico del bosque templado.',
      categoria: 'Anfibio',
      estadoConservacion: 'En Peligro',
      zonaGeografica: 'Zona Sur',
      fotografias: [
        EspecieFotografiaModel(
          id: 1,
          idEspecie: 5,
          orden: 1,
          url: 'https://imagenes.elpais.com/resizer/v2/4DTRZHZ3VBCNNP2CFVCCDRU4CE.JPG?auth=2224ae7b6a745406d5475720a7003952bdf892739e266c6980fb53bb7cd4604f&width=980&height=980&focal=2172%2C1439',
        ),
      ],
    ),
    EspecieModel(
      id: 6,
      idEspecie: 6,
      nombreComun: 'Zorro Chilla',
      nombreCientifico: 'Lycalopex griseus',
      descripcion: 'Zorro gris de tamaño mediano muy distribuido en Chile.',
      categoria: 'Mamífero',
      estadoConservacion: 'Común',
      zonaGeografica: 'Estepa Patagónica',
      fotografias: [
        EspecieFotografiaModel(
          id: 1,
          idEspecie: 6,
          orden: 1,
          url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw6Q-h7lq7vlRrsXUMzCHnPDEKMkkj26hrHvuZ_5bj_2rKyhtAEOA0bSFj&s=10',
        ),
      ],
    ),
    EspecieModel(
      id: 7,
      idEspecie: 7,
      nombreComun: 'Huemul',
      nombreCientifico: 'Hippocamelus bisulcus',
      descripcion: 'Ciervo andino patagónico, símbolo del escudo de Chile.',
      categoria: 'Mamífero',
      estadoConservacion: 'En Peligro Crítico',
      zonaGeografica: 'Patagonia',
      fotografias: [
        EspecieFotografiaModel(
          id: 1,
          idEspecie: 7,
          orden: 1,
          url: 'https://simbio.mma.gob.cl/PlanesRecoge/DownloadImage/100',
        ),
      ],
    ),
    EspecieModel(
      id: 8,
      idEspecie: 8,
      nombreComun: 'Palma Chilena',
      nombreCientifico: 'Jubaea chilensis',
      descripcion: 'La palmera más austral del mundo, endémica de Chile.',
      categoria: 'Flora',
      estadoConservacion: 'Vulnerable',
      zonaGeografica: 'Zona Central',
      fotografias: [
        EspecieFotografiaModel(
          id: 1,
          idEspecie: 8,
          orden: 1,
          url: 'https://1000genomas.cl/wp-content/uploads/2024/07/Palma-chilena_2-Francisco-Gamboa-2.jpg',
        ),
      ],
    ),
  ];

  // Categorías únicas derivadas de los datos
  List<String> get _categorias {
    final cats = _especies.map((e) => e.categoria).toSet().toList()..sort();
    return ['Todas', ...cats];
  }

  String _categoriaSeleccionada = 'Todas';
  String _busqueda = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<EspecieModel> get _especiesFiltradas {
    return _especies.where((e) {
      final coincideCategoria =
          _categoriaSeleccionada == 'Todas' ||
          e.categoria == _categoriaSeleccionada;
      final coincideBusqueda =
          _busqueda.isEmpty ||
          e.nombreComun.toLowerCase().contains(_busqueda.toLowerCase()) ||
          e.nombreCientifico.toLowerCase().contains(_busqueda.toLowerCase()) ||
          e.zonaGeografica.toLowerCase().contains(_busqueda.toLowerCase());
      return coincideCategoria && coincideBusqueda;
    }).toList();
  }

  Color _colorEstado(String estado) {
    switch (estado) {
      case 'Común':
        return const Color(0xFF4A7C59);
      case 'Vulnerable':
        return const Color(0xFFE8A838);
      case 'En Peligro':
        return const Color(0xFFD9534F);
      case 'En Peligro Crítico':
        return const Color(0xFF8B0000);
      default:
        return AppTheme.textGray;
    }
  }

  @override
  Widget build(BuildContext context) {
    final especies = _especiesFiltradas;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Catálogo de Especies',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_especies.length * 56} especies registradas en Chile',
                    style: TextStyle(fontSize: 13, color: AppTheme.textGray),
                  ),
                  const SizedBox(height: 16),

                  // Barra de búsqueda
                  _buildSearchBar(),

                  const SizedBox(height: 14),
                ],
              ),
            ),

            // Chips de categoría
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _categorias.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final cat = _categorias[i];
                  final seleccionada = cat == _categoriaSeleccionada;
                  return GestureDetector(
                    onTap: () => setState(() => _categoriaSeleccionada = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: seleccionada
                            ? AppTheme.primaryGreen
                            : AppTheme.cardWhite,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: seleccionada
                              ? AppTheme.primaryGreen
                              : AppTheme.lightGray,
                        ),
                      ),
                      child: Text(
                        cat,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: seleccionada
                              ? FontWeight.w600
                              : FontWeight.normal,
                          color: seleccionada
                              ? Colors.white
                              : AppTheme.textGray,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // Contador de resultados
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${especies.length} resultado${especies.length != 1 ? 's' : ''}',
                style: TextStyle(fontSize: 12, color: AppTheme.textGray),
              ),
            ),

            const SizedBox(height: 8),

            // Lista
            Expanded(
              child: especies.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48,
                            color: AppTheme.lightGray,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Sin resultados',
                            style: TextStyle(color: AppTheme.textGray),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      itemCount: especies.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, i) => _EspecieTile(
                        especie: especies[i],
                        colorEstado: _colorEstado(
                          especies[i].estadoConservacion,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ), // Espaciado interno del contenedor

      decoration: BoxDecoration(
        // Diseño del contenedor
        color: AppTheme.cardWhite, // Color del fondo

        borderRadius: BorderRadius.circular(14), // Bordes redondeados

        border: Border.all(color: AppTheme.lightGray), // Color del borde
      ),

      child: Row(
        // Input
        children: [
          Icon(Icons.search, color: AppTheme.textGray), // Icono de busqueda

          const SizedBox(width: 8), // Espacio entre el icono y el texto

          Text(
            // Texto de busqueda
            'Buscar especie, planta o insecto...',
            style: TextStyle(color: AppTheme.textGray, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// ── Tile de especie ────────────────────────────────────────────────────────────

class _EspecieTile extends StatelessWidget {
  final EspecieModel especie;
  final Color colorEstado;

  const _EspecieTile({required this.especie, required this.colorEstado});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EspecieDetailPage(especie: especie),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Imagen
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 64,
                    height: 64,
                    child: especie.portada != null
                        ? Image.network(
                            especie.portada!,
                            fit: BoxFit.cover,
                            loadingBuilder: (_, child, progress) {
                              if (progress == null) return child;
                              return Container(
                                color: AppTheme.lightGray,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (_, __, ___) => Container(
                              color: AppTheme.lightGray,
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                color: AppTheme.textGray,
                              ),
                            ),
                          )
                        : Container(
                            color: AppTheme.lightGray,
                            child: Icon(
                              Icons.image_outlined,
                              color: AppTheme.textGray,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 12),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              especie.nombreComun,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: colorEstado.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              especie.estadoConservacion,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: colorEstado,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        especie.nombreCientifico,
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: AppTheme.textGray,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        especie.zonaGeografica,
                        style: TextStyle(
                          fontSize: 11,
                          color: AppTheme.textGray,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 4),
                Icon(Icons.chevron_right, color: AppTheme.lightGray, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
