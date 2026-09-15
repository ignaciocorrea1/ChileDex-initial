class UsuarioModel {
  final String id;
  final String correo;
  final String nombre;
  final String? apellidoPaterno;
  final String? apellidoMaterno;
  final String? fotoPerfilUrl;
  final int rachaActual;

  const UsuarioModel({
    required this.id,
    required this.correo,
    required this.nombre,
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.fotoPerfilUrl,
    this.rachaActual = 0,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id']?.toString() ?? '',
      correo: json['correo']?.toString() ?? '',
      nombre: json['nombre']?.toString() ?? 'Usuario ChileDex',
      apellidoPaterno: json['ap_paterno']?.toString(),
      apellidoMaterno: json['ap_materno']?.toString(),
      fotoPerfilUrl: json['foto_perfil_url']?.toString(),
      rachaActual: json['racha_actual'] as int? ?? 0,
    );
  }

  String get nombreCompleto => [nombre, apellidoPaterno, apellidoMaterno]
      .whereType<String>()
      .where((part) => part.isNotEmpty)
      .join(' ');
}
