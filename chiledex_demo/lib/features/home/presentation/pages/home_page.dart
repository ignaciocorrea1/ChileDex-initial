import 'package:chiledex_demo/app/theme/app_theme.dart';
import 'package:chiledex_demo/core/domain/models/ecosistema_model.dart';
import 'package:chiledex_demo/core/domain/models/especie_fotografia_model.dart';
import 'package:chiledex_demo/core/domain/models/especie_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Carga de información
  static final List<EspecieModel> _especies = [
    EspecieModel(
      id: 1,
      nombreComun: 'Pudú',
      nombreCientifico: 'Pudu puda',
      descripcion: 'El ciervo más pequeño del mundo.',
      categoria: 'Mamífero',
      estadoConservacion: 'Vulnerable',
      zonaGeografica: 'Zona Sur',
      idEspecie: 1,
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
      id: 2,
      nombreComun: 'Cóndor',
      nombreCientifico: 'Vultur gryphus',
      descripcion: 'El ave voladora más grande del mundo.',
      categoria: 'Ave Magna',
      estadoConservacion: 'Vulnerable',
      zonaGeografica: 'Cordillera de los Andes',
      idEspecie: 2,
      fotografias: [
        EspecieFotografiaModel(
          id: 1,
          idEspecie: 2,
          url: 'https://static.wikia.nocookie.net/reinoanimalia/images/d/d1/Andean_condor_by_Alamy.jpg/revision/latest/thumbnail/width/360/height/360?cb=20250902201815&path-prefix=es',
          orden: 1,
        ),
      ],
    ),
    EspecieModel(
      id: 3,
      nombreComun: 'Monito del Monte',
      nombreCientifico: 'Dromiciops gliroides',
      descripcion: 'Único marsupial viviente de la familia Microbiotheriidae.',
      categoria: 'Marsupial',
      estadoConservacion: 'En Peligro',
      zonaGeografica: 'Zona Sur',
      idEspecie: 3,
      fotografias: [
        EspecieFotografiaModel(
          id: 1,
          idEspecie: 3,
          url: 'https://upload.wikimedia.org/wikipedia/commons/5/51/Monito_del_Monte_ps6.jpg?utm_source=es.wikipedia.org&utm_campaign=index&utm_content=original',
          orden: 1,
        ),
      ],
    ),
  ];

  static final List<EcosistemaModel> _ecosistemas = [
    EcosistemaModel(
      id: 1,
      nombre: 'Desierto de Atacama',
      contadorEspecies: 84,
      imagenURL: 'https://www.civitatis.com/blog/wp-content/uploads/2022/12/paisajes-desierto-atacama-chile-scaled.jpg',
    ),
    EcosistemaModel(
      id: 2,
      nombre: 'Bosque Valdiviano',
      contadorEspecies: 189,
      imagenURL: 'https://natureconservancy-h.assetsadobe.com/is/image/content/dam/tnc/nature/en/photos/n/c/NCM120816_D295.jpg?crop=301%2C0%2C4746%2C3560&wid=800&hei=600&scl=5.933333333333334',
    ),
    EcosistemaModel(
      id: 3,
      nombre: 'Patagonia',
      contadorEspecies: 112,
      imagenURL: 'https://upload.wikimedia.org/wikipedia/commons/4/49/Cuernos_del_Paine_from_Lake_Peho%C3%A9.jpg?utm_source=es.wikipedia.org&utm_campaign=index&utm_content=original',
    ),
    EcosistemaModel(
      id: 4,
      nombre: 'Zona Central',
      contadorEspecies: 145,
      imagenURL: 'https://admin.kunapak.com/uploads/imagenes/a0e4bf21d24b652a518c3921d4e8145a0753cb49.jpg',
    ),
  ];

  // Interfaz completa del home
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Evita que el contenido se superponga

        child: SingleChildScrollView(
          // Scroll en la pantalla

          padding: const EdgeInsets.symmetric(horizontal: 20), // Padding

          child: Column(
            // Una unica columna para todo el contenido

            crossAxisAlignment:
                CrossAxisAlignment.start, // Alineación a la izquierda,

            children: [
              const SizedBox(
                height: 20,
              ), // Espacio entre el borde superior y el titulo

              const Text(
                // Titulo
                'Ecosistemas',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ), // Estilos del titulo
              ),

              const SizedBox(
                height: 16,
              ), // Espacio entre el titulo y la barra de busqueda

              _buildSearchBar(), // Barra de busqueda

              const SizedBox(
                height: 24,
              ), // Espacio entre la barra de busqueda y las especies destacadas

              _buildFeaturedSpecies(), // Especies destacadas

              const SizedBox(height: 24), // Espacio entre las especies destacadas y la lista de ecosistemas

              _buildEcosystem(), // Lista de ecosistemas

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Barra de busqueda
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

  // Especies destacadas
  Widget _buildFeaturedSpecies() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Alineación a la izquierda

      children: [
        Text(
          'Especies destacadas',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: AppTheme.textGray,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(
          height: 8,
        ), // Espacio entre el titulo y la lista de especies

        SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Scroll horizontal

          child: Row(
            // Se mapean las especies y se pasan a una card
            children: _especies.map((especie) {
              return _EspeciesCard(especie: especie);
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Ecosistemas
  Widget _buildEcosystem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Alineación a la izquierda

      children: [
        const Text(
          // Titulo
          'Ecosistemas',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 12), // Espacio entre el titulo y la lista

        Column(
          // Se mapean los ecosistemas y se pasan a una card
          children: _ecosistemas.map((ecosistema) {
            return _EcosistemasCard(ecosistema: ecosistema);
          }).toList(),
        ),
      ],
    );
  }
}

// Widget para la card de especie
class _EspeciesCard extends StatelessWidget {
  final EspecieModel especie;

  const _EspeciesCard({required this.especie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,

      margin: const EdgeInsets.only(right: 12),

      decoration: BoxDecoration(
        color: AppTheme.cardWhite, // Color del fondo

        borderRadius: BorderRadius.circular(14), // Bordes redondeados

        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alineación a la izquierda

        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: SizedBox(
              height: 90,
              width: double.infinity,
              child: especie.portada != null
                  ? Image.network(
                      especie.portada!,
                      fit: BoxFit.cover,
                      // Mientras carga
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: AppTheme.lightGray,
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      },
                      // Si falla la URL
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppTheme.lightGray,
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: AppTheme.textGray,
                          ),
                        );
                      },
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

          Padding(
            // Padding
            padding: const EdgeInsets.all(10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  especie.nombreComun,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),

                Text(
                  especie.categoria,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textGray,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget para la card de ecosistema
class _EcosistemasCard extends StatelessWidget {
  final EcosistemaModel ecosistema;

  const _EcosistemasCard({required this.ecosistema});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,

      width: double.infinity,

      margin: const EdgeInsets.only(bottom: 14),

      decoration: BoxDecoration(
        color: AppTheme.primaryGreen,

        borderRadius: BorderRadius.circular(16),
      ),

      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: ecosistema.imagenURL != null
                  ? Image.network(
                      ecosistema.imagenURL!,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(color: AppTheme.primaryGreen);
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppTheme.primaryGreen,
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.white38,
                            size: 48,
                          ),
                        );
                      },
                    )
                  : Container(color: AppTheme.primaryGreen),
            ),
          ),

          ClipRRect(
            // Gradiente sobre la imagen
            // Recorte de la imagen para que tenga bordes redondeados
            borderRadius: BorderRadius.circular(16),

            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,

                  end: Alignment.centerLeft,

                  colors: [Colors.transparent, AppTheme.textGray],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(18),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                Text(
                  ecosistema.nombre,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Text(
                    '${ecosistema.contadorEspecies} Especies',

                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
