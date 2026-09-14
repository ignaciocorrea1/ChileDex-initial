import 'package:chiledex_demo/core/domain/models/especie_fotografia_model.dart';

class EspecieModel {
  final int id;
  final String nombreComun;
  final String nombreCientifico;
  final String descripcion;
  final String categoria;
  final String zonaGeografica;
  final String estadoConservacion;
  final List<EspecieFotografiaModel> fotografias;

  EspecieModel({
    required this.id,
    required this.nombreComun,
    required this.nombreCientifico,
    required this.descripcion,
    required this.categoria,
    required this.zonaGeografica,
    required this.estadoConservacion,
    this.fotografias = const [], required int idEspecie,
  });

  // Retorno de la primera foto de la especie
  String? get portada => fotografias.isNotEmpty ? fotografias.first.url : null;

}