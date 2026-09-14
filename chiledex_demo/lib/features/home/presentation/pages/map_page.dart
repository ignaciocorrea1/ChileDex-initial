import 'package:chiledex_demo/app/theme/app_theme.dart';
import 'package:chiledex_demo/core/domain/models/especie_fotografia_model.dart';
import 'package:chiledex_demo/core/domain/models/especie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

// ── Modelo de avistamiento estático ──────────────────────────────────────────

class AvistamientoMock {
  final String especie;
  final String zona;
  final LatLng coordenadas;
  final String imagenUrl;
  final String fecha;

  const AvistamientoMock({
    required this.especie,
    required this.zona,
    required this.coordenadas,
    required this.imagenUrl,
    required this.fecha,
  });
}

// ── MapPage ───────────────────────────────────────────────────────────────────

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _chileCentro = LatLng(-35.6751, -71.5430);

  final MapController _mapController = MapController();

  LatLng? _ubicacionUsuario;
  bool _cargandoUbicacion = false;

  static final List<AvistamientoMock> _avistamientos = [
    AvistamientoMock(
      especie: 'Cóndor Andino',
      zona: 'Cordillera de los Andes',
      coordenadas: const LatLng(-33.4, -70.1),
      imagenUrl:
          'https://static.wikia.nocookie.net/reinoanimalia/images/d/d1/Andean_condor_by_Alamy.jpg/revision/latest/thumbnail/width/360/height/360?cb=20250902201815&path-prefix=es',
      fecha: '02 Mar 2026',
    ),
    AvistamientoMock(
      especie: 'Pudú',
      zona: 'Zona Sur',
      coordenadas: const LatLng(-39.8, -73.2),
      imagenUrl:
          'https://reforestemos.org/wp-content/uploads/2025/09/384401781-18388415197033867-431876921902592106-n.jpg',
      fecha: '18 Ago 2026',
    ),
    AvistamientoMock(
      especie: 'Monito del Monte',
      zona: 'Bosque Valdiviano',
      coordenadas: const LatLng(-40.5, -72.8),
      imagenUrl:
          'https://upload.wikimedia.org/wikipedia/commons/5/51/Monito_del_Monte_ps6.jpg',
      fecha: '10 Sep 2026',
    ),
    AvistamientoMock(
      especie: 'Huemul',
      zona: 'Patagonia',
      coordenadas: const LatLng(-46.2, -72.5),
      imagenUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Huemul_patagonian_deer.jpg/640px-Huemul_patagonian_deer.jpg',
      fecha: '05 Jul 2026',
    ),
    AvistamientoMock(
      especie: 'Zorro Chilla',
      zona: 'Estepa Patagónica',
      coordenadas: const LatLng(-51.7, -72.0),
      imagenUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/54/Lycalopex_griseus_-_Punta_Arenas.jpg/640px-Lycalopex_griseus_-_Punta_Arenas.jpg',
      fecha: '20 Jun 2026',
    ),
    AvistamientoMock(
      especie: 'Loica',
      zona: 'Zona Central',
      coordenadas: const LatLng(-34.1, -70.9),
      imagenUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/Loica_Sturnella_loyca.jpg/640px-Loica_Sturnella_loyca.jpg',
      fecha: '01 Sep 2026',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _obtenerUbicacion();
  }

  Future<void> _obtenerUbicacion() async {
    setState(() => _cargandoUbicacion = true);
    try {
      bool servicioActivo = await Geolocator.isLocationServiceEnabled();
      if (!servicioActivo) return;

      LocationPermission permiso = await Geolocator.checkPermission();
      if (permiso == LocationPermission.denied) {
        permiso = await Geolocator.requestPermission();
        if (permiso == LocationPermission.denied) return;
      }
      if (permiso == LocationPermission.deniedForever) return;

      final pos = await Geolocator.getCurrentPosition();
      setState(() {
        _ubicacionUsuario = LatLng(pos.latitude, pos.longitude);
      });
    } catch (_) {
      // Si falla, simplemente no mostramos el marcador de usuario
    } finally {
      setState(() => _cargandoUbicacion = false);
    }
  }

  void _centrarEnChile() {
    _mapController.move(_chileCentro, 5.0);
  }

  void _centrarEnUsuario() {
    if (_ubicacionUsuario != null) {
      _mapController.move(_ubicacionUsuario!, 12.0);
    }
  }

  void _mostrarDetalleAvistamiento(BuildContext context, AvistamientoMock a) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _AvistamientoSheet(avistamiento: a),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // ── Mapa ──────────────────────────────────────────────────────
            FlutterMap(
              mapController: _mapController,
              options: const MapOptions(
                initialCenter: _chileCentro,
                initialZoom: 5.0,
                minZoom: 3.0,
                maxZoom: 18.0,
              ),
              children: [
                // Tiles OpenStreetMap
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.chiledex.app',
                ),

                // Marcadores de avistamientos
                MarkerLayer(
                  markers: [
                    // Avistamientos
                    ..._avistamientos.map((a) {
                      return Marker(
                        point: a.coordenadas,
                        width: 40,
                        height: 40,
                        child: GestureDetector(
                          onTap: () =>
                              _mostrarDetalleAvistamiento(context, a),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.primaryGreen,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.white, width: 2.5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.pets,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      );
                    }),

                    // Ubicación del usuario
                    if (_ubicacionUsuario != null)
                      Marker(
                        point: _ubicacionUsuario!,
                        width: 48,
                        height: 48,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white, width: 2.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.4),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),

            // ── Header ────────────────────────────────────────────────────
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mapa de Avistamientos',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${_avistamientos.length} avistamientos registrados',
                      style:
                          TextStyle(fontSize: 13, color: AppTheme.textGray),
                    ),
                  ],
                ),
              ),
            ),

            // ── Botones flotantes ─────────────────────────────────────────
            Positioned(
              bottom: 24,
              right: 16,
              child: Column(
                children: [
                  // Centrar en Chile
                  _MapFAB(
                    icon: Icons.flag_outlined,
                    onTap: _centrarEnChile,
                    tooltip: 'Ver Chile completo',
                  ),
                  const SizedBox(height: 10),
                  // Ir a mi ubicación
                  _MapFAB(
                    icon: _cargandoUbicacion
                        ? Icons.hourglass_empty
                        : Icons.my_location,
                    onTap: _ubicacionUsuario != null
                        ? _centrarEnUsuario
                        : _obtenerUbicacion,
                    tooltip: 'Mi ubicación',
                    color: _ubicacionUsuario != null
                        ? Colors.blue
                        : AppTheme.primaryGreen,
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

// ── Botón flotante del mapa ───────────────────────────────────────────────────

class _MapFAB extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;
  final Color? color;

  const _MapFAB({
    required this.icon,
    required this.onTap,
    required this.tooltip,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color ?? AppTheme.primaryGreen,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}

// ── Bottom sheet de avistamiento ──────────────────────────────────────────────

class _AvistamientoSheet extends StatelessWidget {
  final AvistamientoMock avistamiento;

  const _AvistamientoSheet({required this.avistamiento});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.lightGray,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // Imagen
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(0)),
            child: SizedBox(
              height: 160,
              width: double.infinity,
              child: Image.network(
                avistamiento.imagenUrl,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return Container(color: AppTheme.lightGray);
                },
                errorBuilder: (_, __, ___) => Container(
                  color: AppTheme.lightGray,
                  child: Icon(Icons.image_not_supported_outlined,
                      color: AppTheme.textGray),
                ),
              ),
            ),
          ),

          // Info
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        avistamiento.especie,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        avistamiento.fecha,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 14, color: AppTheme.textGray),
                    const SizedBox(width: 4),
                    Text(
                      avistamiento.zona,
                      style: TextStyle(
                          fontSize: 13, color: AppTheme.textGray),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Ver especie en catálogo'),
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