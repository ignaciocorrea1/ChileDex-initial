import 'package:chiledex_demo/core/domain/models/especie_fotografia_model.dart';

class EspecieModel {
  final Object id;
  final String nombreComun;
  final String nombreCientifico;
  final String descripcion;
  final String categoria;
  final String zonaGeografica;
  final String estadoConservacion;
  final String? tamanio;
  final String? peso;
  final String? origen;
  final String? habitat;
  final List<EspecieFotografiaModel> fotografias;

  EspecieModel({
    required this.id,
    required this.nombreComun,
    required this.nombreCientifico,
    required this.descripcion,
    required this.categoria,
    required this.zonaGeografica,
    required this.estadoConservacion,
    this.tamanio,
    this.peso,
    required this.origen,
    required this.habitat,
    this.fotografias = const [], required Object idEspecie,
  });

  factory EspecieModel.fromJson(Map<String, dynamic> json) {
    String text(String key, [String fallback = '']) =>
        (json[key] ?? fallback).toString();

    final categoryLabels = {
      'AVE': 'Aves',
      'MAMIFERO': 'Mamíferos',
      'REPTIL': 'Reptiles',
      'ANFIBIO': 'Anfibios',
      'INSECTO': 'Insectos',
      'FLORA': 'Flora',
    };
    final category = text('categoria');

    final id = json['id']?.toString() ?? '';
    final photos = (json['fotografias'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(
          (photo) => EspecieFotografiaModel(
            id: photo['id']?.toString() ?? '',
            idEspecie: id,
            url: photo['url']?.toString() ?? '',
            orden: photo['orden'] as int? ?? 0,
          ),
        )
        .toList();
    return EspecieModel(
      id: id,
      idEspecie: id,
      nombreComun: text('nombre_comun', text('nombreComun')),
      nombreCientifico: text('nombre_cientifico', text('nombreCientifico')),
      descripcion: text('descripcion'),
      categoria: categoryLabels[category] ?? category,
      zonaGeografica: text('zona_geografica', text('zonaGeografica')),
      estadoConservacion: text(
        'estado_conservacion',
        text('estadoConservacion'),
      ),
      tamanio: json['tamanio']?.toString(),
      peso: json['peso']?.toString(),
      origen: json['origen']?.toString(),
      habitat: json['habitat']?.toString(),
      fotografias: photos,
    );
  }

  // Retorno de la primera foto de la especie
  String? get portada => fotografias.isNotEmpty ? fotografias.first.url : null;

}