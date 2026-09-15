import 'package:chiledex_demo/app/theme/app_theme.dart';
import 'package:chiledex_demo/core/data/services/chiledex_api.dart';
import 'package:chiledex_demo/core/domain/models/avistamiento_model.dart';
import 'package:chiledex_demo/core/domain/models/usuario_model.dart';
import 'package:chiledex_demo/features/auth/presentation/pages/login_page.dart';
import 'package:chiledex_demo/features/home/presentation/widgets/edit_profile_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ProfilePage extends StatefulWidget {
  final UsuarioModel usuario;

  const ProfilePage({super.key, required this.usuario});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _api = ChiledexApi();
  late UsuarioModel _usuario;
  List<AvistamientoModel> _avistamientos = [];
  List<Map<String, dynamic>> _logros = [];
  bool _cargando = true;

  static const String _titulo = 'Naturalista Experto';

  List<String> get _diasSemana => const ['L', 'M', 'M', 'J', 'V', 'S', 'D'];
  List<bool> get _rachaActiva => List.generate(
        7,
        (index) => index >= 7 - _usuario.rachaActual.clamp(0, 7),
      );
  int get _especies => _avistamientos.map((item) => item.especie).toSet().length;
  int get _rachaDias => _usuario.rachaActual;
  List<_InsigniaData> get _insignias => _logros.take(3).map((logro) {
        return _InsigniaData(
          icono: Icons.emoji_events_outlined,
          nombre: logro['nombre']?.toString() ?? 'Logro',
          fecha: logro['fecha_obtencion']?.toString().split('T').first ?? '',
        );
      }).toList();
  List<String> get _capturas => _avistamientos
      .map((item) => item.fotografiaUrl)
      .whereType<String>()
      .where((url) => url.isNotEmpty)
      .toList();
  List<LatLng> get _coordsAvistamientos => _avistamientos
      .map((item) => item.coordenadas)
      .whereType<LatLng>()
      .toList();

  @override
  void initState() {
    super.initState();
    _usuario = widget.usuario;
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    try {
      final results = await Future.wait([
        _api.obtenerAvistamientos(_usuario.id),
        _api.obtenerLogros(_usuario.id),
      ]);
      if (!mounted) return;
      setState(() {
        _avistamientos = results[0] as List<AvistamientoModel>;
        _logros = results[1] as List<Map<String, dynamic>>;
        _cargando = false;
      });
    } catch (_) {
      if (mounted) setState(() => _cargando = false);
    }
  }

  Future<void> _editarPerfil() async {
    final updatedUser = await Navigator.of(context).push<UsuarioModel>(
      MaterialPageRoute(
        builder: (_) => EditProfileSheet(usuario: _usuario, api: _api),
      ),
    );
    if (updatedUser != null && mounted) {
      setState(() => _usuario = updatedUser);
    }
  }

  Future<void> _cerrarSesion() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Quieres salir de tu cuenta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );

    if (confirmar != true || !mounted) return;
    try {
      await _api.cerrarSesion(_usuario.id);
    } catch (_) {
      // La navegación local también cierra la sesión en el dispositivo.
    }
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (_) => false,
    );
  }

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
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _cerrarSesion,
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar sesión'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.accentOrange,
                  side: const BorderSide(color: AppTheme.accentOrange),
                  minimumSize: const Size(double.infinity, 46),
                ),
              ),
              if (_cargando) ...[
                const SizedBox(height: 12),
                const LinearProgressIndicator(),
              ],
              const SizedBox(height: 20),
              _buildStats(),
              const SizedBox(height: 20),
              _buildAvistamientos(),
              const SizedBox(height: 20),
              _buildRacha(),
              const SizedBox(height: 20),
              _buildInsignias(),
              const SizedBox(height: 20),
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
                _usuario.nombreCompleto,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _usuario.correo,
                style: TextStyle(fontSize: 12, color: AppTheme.textGray),
              ),
              const SizedBox(height: 6),
              
            ],
          ),
        ),

        // Botón editar
        IconButton(
          onPressed: _editarPerfil,
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
          _StatItem(valor: _avistamientos.length, label: 'Avistamientos'),
          _Divider(),
          _StatItem(valor: _logros.length, label: 'Logros'),
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

  Widget _buildAvistamientos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MIS AVISTAMIENTOS',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: AppTheme.textGray,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 12),
        if (_avistamientos.isEmpty)
          _ProfileEmptyState(
            icon: Icons.visibility_outlined,
            message: 'Todavía no tienes avistamientos registrados.',
          )
        else
          ..._avistamientos.take(5).map(
                (avistamiento) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.pets, color: AppTheme.primaryGreen),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              avistamiento.especie,
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              avistamiento.fechaFormateada,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.textGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
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
              'MIS LOGROS',
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
        if (_insignias.isEmpty)
          _ProfileEmptyState(
            icon: Icons.emoji_events_outlined,
            message: 'Aún no tienes logros desbloqueados.',
          )
        else
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
                        color: AppTheme.primaryGreen.withValues(alpha: 0.1),
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
                    errorBuilder: (_, _, _) => Container(
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

class _ProfileEmptyState extends StatelessWidget {
  final IconData icon;
  final String message;

  const _ProfileEmptyState({required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.textGray),
          const SizedBox(width: 10),
          Expanded(
            child: Text(message, style: TextStyle(color: AppTheme.textGray)),
          ),
        ],
      ),
    );
  }
}