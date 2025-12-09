class HydrationDto {
  final String id;
  final String data_registro;  // Banco: data_registro
  final int ml_consumidos;     // Banco: ml_consumidos
  final int meta_diaria_ml;    // Banco: meta_diaria_ml

  HydrationDto({
    required this.id,
    required this.data_registro,
    required this.ml_consumidos,
    required this.meta_diaria_ml,
  });

  factory HydrationDto.fromMap(Map<String, dynamic> map) {
    return HydrationDto(
      id: map['id']?.toString() ?? '',
      data_registro: map['data_registro'] ?? '',
      ml_consumidos: map['ml_consumidos'] ?? 0,
      meta_diaria_ml: map['meta_diaria_ml'] ?? 2000, // Valor padrão saudável
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data_registro': data_registro,
      'ml_consumidos': ml_consumidos,
      'meta_diaria_ml': meta_diaria_ml,
    };
  }
}