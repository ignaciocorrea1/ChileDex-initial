class CatalogFilterModel {
  final List<String> estadosConservacion;
  final List<String> ecosistema;
  final List<String> habitats;
  final String ordenAlfabetico; // 'A-Z' o 'Z-A'

  const CatalogFilterModel({
    this.estadosConservacion = const [],
    this.ecosistema = const [],
    this.habitats = const [],
    this.ordenAlfabetico = 'A-Z',
  });

  // Retorna una copia del filtro con los campos modificados
  CatalogFilterModel copyWith({
    List<String>? estadosConservacion,
    List<String>? ecosistema,
    List<String>? habitats,
    String? ordenAlfabetico,
  }) {
    return CatalogFilterModel(
      estadosConservacion: estadosConservacion ?? this.estadosConservacion,
      ecosistema: ecosistema ?? this.ecosistema,
      habitats: habitats ?? this.habitats,
      ordenAlfabetico: ordenAlfabetico ?? this.ordenAlfabetico,
    );
  }
}