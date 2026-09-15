import 'package:chiledex_demo/app/navigation/main_scaffold.dart';
import 'package:chiledex_demo/app/theme/app_theme.dart';
import 'package:chiledex_demo/core/domain/models/ecosistema_model.dart';
import 'package:chiledex_demo/core/domain/models/especie_fotografia_model.dart';
import 'package:chiledex_demo/core/domain/models/especie_model.dart';
import 'package:chiledex_demo/features/home/presentation/pages/specieDetail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      tamanio: '100 - 120 cm',
      peso: '10 - 20 kg',
      origen: 'Nativa',
      habitat: 'Bosque Templado',
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
      tamanio: '140 - 160 cm',
      peso: '5 - 10 kg',
      origen: 'Nativa',
      habitat: 'Bosque Templado',
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
      tamanio: '20 - 30 cm',
      peso: '40 - 60 gr',
      origen: 'Nativa',
      habitat: 'Bosque Templado',
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
    EcosistemaModel(
      id: 5,
      nombre: 'Santuario',
      contadorEspecies: 404,
      imagenURL: 'https://st5.depositphotos.com/2863241/68062/i/450/depositphotos_680620534-stock-photo-giraffe-head-neck-background-trees.jpg',
    ),
  ];

  // Interfaz completa del home
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                'CHILEDEX',
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 24),
              _buildFeaturedSpecies(context), // pasa contexto
              const SizedBox(height: 24),
              _buildEcosystem(context), // pasa contexto
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Especies destacadas
  Widget _buildFeaturedSpecies(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Especies destacadas',
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.textGray,
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _especies.map((especie) {
              return _EspeciesCard(
                especie: especie,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EspecieDetailPage(especie: especie),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Ecosistemas
  Widget _buildEcosystem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ecosistemas',
          style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 12),
        Column(
          children: _ecosistemas.map((ecosistema) {
            return _EcosistemasCard(
              ecosistema: ecosistema,
              onTap: () =>
                  MainScaffold.of(context)
                      .navegarACatalogo(categoria: ecosistema.nombre),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// Widget para la card de especie
class _EspeciesCard extends StatelessWidget {
  final EspecieModel especie;
  final VoidCallback onTap; // nuevo

  const _EspeciesCard({
    required this.especie,
    required this.onTap, // nuevo
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // nuevo
      child: Container(
        width: 130,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: AppTheme.cardWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppTheme.lightGray),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              child: SizedBox(
                height: 90,
                width: double.infinity,
                child: especie.portada != null
                    ? Image.network(
                        especie.portada!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: AppTheme.lightGray,
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        },
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
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    especie.nombreComun,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w700,
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
      ),
    );
  }
}

// Widget para la card de ecosistema
class _EcosistemasCard extends StatelessWidget {
  final EcosistemaModel ecosistema;
  final VoidCallback onTap; // nuevo

  const _EcosistemasCard({
    required this.ecosistema,
    required this.onTap, // nuevo
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // nuevo
      child: Container(
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
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
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
      ),
    );
  }
}
