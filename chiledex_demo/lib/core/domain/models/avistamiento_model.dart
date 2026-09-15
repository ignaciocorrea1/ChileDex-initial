import 'package:latlong2/latlong.dart';

class AvistamientoModel {
  final String id;
  final String especie;
  final String nombreCientifico;
  final DateTime? fecha;
  final double? latitud;
  final double? longitud;
  final String? fotografiaUrl;

  const AvistamientoModel({
    required this.id,
    required this.especie,
    required this.nombreCientifico,
    this.fecha,
    this.latitud,
    this.longitud,
    this.fotografiaUrl,
  });

  factory AvistamientoModel.fromJson(Map<String, dynamic> json) {
    return AvistamientoModel(
      id: json['id']?.toString() ?? '',
      especie: json['nombre_comun']?.toString() ?? 'Especie sin identificar',
      nombreCientifico: json['nombre_cientifico']?.toString() ?? '',
      fecha: DateTime.tryParse(json['fecha']?.toString() ?? ''),
      latitud: (json['latitud'] as num?)?.toDouble(),
      longitud: (json['longitud'] as num?)?.toDouble(),
      fotografiaUrl: json['fotografia_url']?.toString(),
    );
  }

  LatLng? get coordenadas {
    if (latitud == null || longitud == null) return null;
    return LatLng(latitud!, longitud!);
  }

  String get fechaFormateada {
    if (fecha == null) return 'Fecha desconocida';
    return '${fecha!.day.toString().padLeft(2, '0')}/'
        '${fecha!.month.toString().padLeft(2, '0')}/${fecha!.year}';
  }
}
