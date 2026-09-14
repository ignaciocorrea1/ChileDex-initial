import 'package:chiledex_demo/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Datos estáticos de usuario
  static const String _nombre = 'Natalia Silva';
  static const String _ubicacion = 'Santiago, Chile';
  static const String _titulo = 'Naturalista Experto';
  static const int _nivel = 4;
  static const int _ranking = 248;
  static const int _especies = 127;
  static const int _avistamientos = 42;
  static const int _logros = 14;
  static const int _rachaDias = 5;

  static const List<String> _diasSemana = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];
  static const List<bool> _rachaActiva = [true, true, true, true, true, false, false];

  static final List<_InsigniaData> _insignias = [
    _InsigniaData(icono: Icons.visibility_outlined, nombre: 'Primer Avistamiento', fecha: '22/08/2026'),
    _InsigniaData(icono: Icons.remove_red_eye_outlined, nombre: 'Ojo de Águila', fecha: '22/08/2026'),
    _InsigniaData(icono: Icons.eco_outlined, nombre: 'Brote Verde', fecha: '22/08/2026'),
  ];

  static final List<String> _capturas = [
    'https://reforestemos.org/wp-content/uploads/2025/09/384401781-18388415197033867-431876921902592106-n.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/Loica_Sturnella_loyca.jpg/640px-Loica_Sturnella_loyca.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Jubaea_chilensis_-_Jardin_des_plantes_de_Paris_-_full.jpg/480px-Jubaea_chilensis_-_Jardin_des_plantes_de_Paris_-_full.jpg',
  ];

  // Coordenadas de avistamientos para el mini mapa
  static final List<LatLng> _coordsAvistamientos = [
    const LatLng(-33.4, -70.6),
    const LatLng(-33.6, -70.4),
    const LatLng(-33.5, -70.8),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildStats(),
              const SizedBox(height: 20),
              _buildRacha(),
              const SizedBox(height: 20),
              _buildInsignias(),
              const SizedBox(height: 20),
              _buildMiniMapa(),
              const SizedBox(height: 20),
              _buildCapturas(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Row(
      children: [
        // Avatar
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: const Icon(Icons.person, size: 40, color: Colors.grey),
        ),
        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _nombre,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '$_ubicacion · $_titulo',
                style: TextStyle(fontSize: 12, color: AppTheme.textGray),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 14, color: Color(0xFFD9534F)),
                  const SizedBox(width: 4),
                  Text(
                    'Nivel $_nivel · #$_ranking en Ranking',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFD9534F),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Botón editar
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.edit_outlined, color: AppTheme.textGray, size: 20),
        ),
      ],
    );
  }

  // ── Stats ─────────────────────────────────────────────────────────────────

  Widget _buildStats() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          _StatItem(valor: _especies, label: 'Especies'),
          _Divider(),
          _StatItem(valor: _avistamientos, label: 'Avistamientos'),
          _Divider(),
          _StatItem(valor: _logros, label: 'Logros'),
        ],
      ),
    );
  }

  // ── Racha ─────────────────────────────────────────────────────────────────

  Widget _buildRacha() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RACHA DE AVISTAMIENTOS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textGray,
                  letterSpacing: 1.1,
                ),
              ),
              Row(
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 4),
                  Text(
                    '$_rachaDias Días Seguidos',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE8A838),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_diasSemana.length, (i) {
              final activo = _rachaActiva[i];
              return Column(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: activo
                          ? AppTheme.primaryGreen
                          : const Color(0xFFF0F0F0),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: activo
                          ? const Icon(Icons.check, color: Colors.white, size: 16)
                          : Text(
                              _diasSemana[i],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textGray,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (!activo)
                    Text(
                      _diasSemana[i],
                      style: TextStyle(fontSize: 11, color: AppTheme.textGray),
                    )
                  else
                    Text(
                      _diasSemana[i],
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  // ── Insignias ─────────────────────────────────────────────────────────────

  Widget _buildInsignias() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'INSIGNIAS DE CAMPO',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppTheme.textGray,
                letterSpacing: 1.1,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'Ver más',
                style: TextStyle(
                  fontSize: 13,
                  color: AppTheme.primaryGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: _insignias.map((ins) {
            return Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(ins.icono,
                          color: AppTheme.primaryGreen, size: 22),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ins.nombre,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      ins.fecha,
                      style: TextStyle(fontSize: 10, color: AppTheme.textGray),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ── Mini mapa ─────────────────────────────────────────────────────────────

  Widget _buildMiniMapa() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MAPA DE AVISTAMIENTOS',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: AppTheme.textGray,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 180,
            child: FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(-33.5, -70.6),
                initialZoom: 9.0,
                interactionOptions:
                    InteractionOptions(flags: InteractiveFlag.none),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.chiledex.app',
                ),
                MarkerLayer(
                  markers: _coordsAvistamientos.map((coord) {
                    return Marker(
                      point: coord,
                      width: 28,
                      height: 28,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGreen,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(Icons.pets,
                            color: Colors.white, size: 12),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Capturas de campo ─────────────────────────────────────────────────────

  Widget _buildCapturas() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mis Capturas de Campo',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: _capturas.map((url) {
            return Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    url,
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
            );
          }).toList(),
        ),
      ],
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

class _InsigniaData {
  final IconData icono;
  final String nombre;
  final String fecha;
  const _InsigniaData({required this.icono, required this.nombre, required this.fecha});
}

class _StatItem extends StatelessWidget {
  final int valor;
  final String label;
  const _StatItem({required this.valor, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            '$valor',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(fontSize: 12, color: AppTheme.textGray)),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 40, color: const Color(0xFFE0E0E0));
  }
}