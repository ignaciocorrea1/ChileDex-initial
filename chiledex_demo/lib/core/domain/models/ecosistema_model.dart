class EcosistemaModel {
  final int id;
  final String nombre;
  final int contadorEspecies;
  final String? imagenURL;

  EcosistemaModel({
    required this.id,
    required this.nombre,
    required this.contadorEspecies,
    this.imagenURL,
  });
}