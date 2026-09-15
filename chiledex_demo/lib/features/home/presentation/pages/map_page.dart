import 'package:chiledex_demo/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

// ── Modelo de avistamiento ────────────────────────────────────────────────────
// Cuando se conecte la BD, este modelo se reemplaza por el modelo real
// que venga del repositorio de avistamientos
class AvistamientoMock {
  final String especie;
  final String nombreCientifico;
  final String estadoConservacion;
  final String zona;
  final LatLng coordenadas;
  final String imagenUrl;
  final String fecha;

  const AvistamientoMock({
    required this.especie,
    required this.nombreCientifico,
    required this.estadoConservacion,
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
  final TextEditingController _searchController = TextEditingController();

  LatLng? _ubicacionUsuario;
  bool _cargandoUbicacion = false;
  bool _sinResultados = false;
  String _searchQuery = '';

  // ── Datos hardcodeados ────────────────────────────────────────────────────
  // Cuando se conecte la BD, esta lista vendrá del repositorio de avistamientos
  static final List<AvistamientoMock> _avistamientos = [
    AvistamientoMock(
      especie: 'Cóndor Andino',
      nombreCientifico: 'Vultur gryphus',
      estadoConservacion: 'Vulnerable',
      zona: 'Cordillera de los Andes',
      coordenadas: const LatLng(-33.4, -70.1),
      imagenUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/Condor_and_nest_edit.jpg/640px-Condor_and_nest_edit.jpg',
      fecha: '02 Mar 2026',
    ),
    AvistamientoMock(
      especie: 'Pudú',
      nombreCientifico: 'Pudu puda',
      estadoConservacion: 'Vulnerable',
      zona: 'Zona Sur',
      coordenadas: const LatLng(-39.8, -73.2),
      imagenUrl: 'https://reforestemos.org/wp-content/uploads/2025/09/384401781-18388415197033867-431876921902592106-n.jpg',
      fecha: '18 Ago 2026',
    ),
    AvistamientoMock(
      especie: 'Monito del Monte',
      nombreCientifico: 'Dromiciops gliroides',
      estadoConservacion: 'En Peligro',
      zona: 'Bosque Valdiviano',
      coordenadas: const LatLng(-40.5, -72.8),
      imagenUrl: 'https://upload.wikimedia.org/wikipedia/commons/5/51/Monito_del_Monte_ps6.jpg',
      fecha: '10 Sep 2026',
    ),
    AvistamientoMock(
      especie: 'Huemul',
      nombreCientifico: 'Hippocamelus bisulcus',
      estadoConservacion: 'En Peligro',
      zona: 'Patagonia',
      coordenadas: const LatLng(-46.2, -72.5),
      imagenUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Huemul_patagonian_deer.jpg/640px-Huemul_patagonian_deer.jpg',
      fecha: '05 Jul 2026',
    ),
    AvistamientoMock(
      especie: 'Loica',
      nombreCientifico: 'Sturnella loyca',
      estadoConservacion: 'Común',
      zona: 'Zona Central',
      coordenadas: const LatLng(-34.1, -70.9),
      imagenUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/Loica_Sturnella_loyca.jpg/640px-Loica_Sturnella_loyca.jpg',
      fecha: '01 Sep 2026',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _obtenerUbicacion();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ── Ubicación del usuario ─────────────────────────────────────────────────
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
    } finally {
      setState(() => _cargandoUbicacion = false);
    }
  }

  // ── Buscar zona ───────────────────────────────────────────────────────────
  // Cuando se conecte la BD, aquí se llamará al repositorio
  // filtrando avistamientos por zona geográfica
  void _buscarZona(String query) {
    setState(() => _searchQuery = query);
    if (query.isEmpty) {
      setState(() => _sinResultados = false);
      return;
    }
    final hayResultados = _avistamientos.any(
      (a) =>
          a.zona.toLowerCase().contains(query.toLowerCase()) ||
          a.especie.toLowerCase().contains(query.toLowerCase()),
    );
    setState(() => _sinResultados = !hayResultados);
  }

  void _centrarEnChile() => _mapController.move(_chileCentro, 5.0);

  void _centrarEnUsuario() {
    if (_ubicacionUsuario != null) {
      _mapController.move(_ubicacionUsuario!, 12.0);
    }
  }

  // ── Filtrar avistamientos según búsqueda ──────────────────────────────────
  List<AvistamientoMock> get _avistamientosFiltrados {
    if (_searchQuery.isEmpty) return _avistamientos;
    return _avistamientos
        .where(
          (a) =>
              a.zona.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              a.especie.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  // ── Color badge estado ────────────────────────────────────────────────────
  Color _colorEstado(String estado) {
    switch (estado) {
      case 'En Peligro':
        return const Color(0xFFE53935);
      case 'Vulnerable':
        return const Color(0xFFFFA726);
      default:
        return const Color(0xFF66BB6A);
    }
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
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.chiledex.app',
                ),
                MarkerLayer(
                  markers: [
                    // Marcadores de avistamientos
                    ..._avistamientosFiltrados.map(
                      (a) => Marker(
                        point: a.coordenadas,
                        width: 40,
                        height: 40,
                        child: GestureDetector(
                          onTap: () => _mostrarDetalleAvistamiento(context, a),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.primaryGreen,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2.5,
                              ),
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
                      ),
                    ),

                    // Marcador de ubicación del usuario
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
                                  color: Colors.white,
                                  width: 2.5,
                                ),
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

            // ── Header con búsqueda ───────────────────────────────────────
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundCream,
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
                    const SizedBox(height: 10),

                    Text(
                      'Mapa de Avistamientos',
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            // ── Estado vacío: sin resultados ──────────────────────────────
            if (_sinResultados)
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: AppTheme.accentOrange.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.search_off,
                          color: AppTheme.accentOrange,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No se encontraron avistamientos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Intenta buscar en otra ubicación o amplía el área de búsqueda',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textGray,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _searchController.clear();
                          _buscarZona('');
                          _centrarEnChile();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryGreen,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Explorar otras zonas'),
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
                  _MapFAB(
                    icon: Icons.flag_outlined,
                    onTap: _centrarEnChile,
                    tooltip: 'Ver Chile completo',
                  ),
                  const SizedBox(height: 10),
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

  // ── Bottom sheet al tocar un marcador ────────────────────────────────────
  void _mostrarDetalleAvistamiento(BuildContext context, AvistamientoMock a) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _AvistamientoSheet(
        avistamiento: a,
        colorEstado: _colorEstado(a.estadoConservacion),
      ),
    );
  }
}

// ── Botón flotante reutilizable ───────────────────────────────────────────────
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

// ── Bottom sheet de detalle de avistamiento ───────────────────────────────────
class _AvistamientoSheet extends StatelessWidget {
  final AvistamientoMock avistamiento;
  final Color colorEstado;

  const _AvistamientoSheet({
    required this.avistamiento,
    required this.colorEstado,
  });

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
          const SizedBox(height: 12),

          // Imagen
          ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: SizedBox(
              height: 150,
              width: double.infinity,
              child: Image.network(
                avistamiento.imagenUrl,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: AppTheme.lightGray,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryGreen,
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
                    // Miniatura de la especie
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: Image.network(
                          avistamiento.imagenUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Container(color: AppTheme.lightGray),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Nombre + estado
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                avistamiento.especie,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Badge estado de conservación
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: colorEstado.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  avistamiento.estadoConservacion,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: colorEstado,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            avistamiento.nombreCientifico,
                            style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: AppTheme.textGray,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Icon(Icons.chevron_right, color: AppTheme.textGray),
                  ],
                ),

                const SizedBox(height: 16),

                // Zona y fecha
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: AppTheme.textGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      avistamiento.zona,
                      style: TextStyle(fontSize: 13, color: AppTheme.textGray),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 13,
                      color: AppTheme.textGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      avistamiento.fecha,
                      style: TextStyle(fontSize: 13, color: AppTheme.textGray),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Botón ver en catálogo
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Ver especie en catálogo'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
