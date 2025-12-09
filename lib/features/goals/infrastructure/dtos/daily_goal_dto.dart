class DailyGoalDto {
  final String id;
  final String data;             // No banco será: data (ISO String)
  final int meta_minutos;        // No banco será: meta_minutos
  final int minutos_atuais;      // No banco será: minutos_atuais
  final bool concluido;          // No banco será: concluido

  DailyGoalDto({
    required this.id,
    required this.data,
    required this.meta_minutos,
    required this.minutos_atuais,
    required this.concluido,
  });

  // JSON (Banco) -> DTO
  factory DailyGoalDto.fromMap(Map<String, dynamic> map) {
    return DailyGoalDto(
      id: map['id']?.toString() ?? '',
      data: map['data'] ?? '',
      meta_minutos: map['meta_minutos'] ?? 0,
      minutos_atuais: map['minutos_atuais'] ?? 0,
      concluido: map['concluido'] ?? false,
    );
  }

  // DTO -> JSON (Banco)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data,
      'meta_minutos': meta_minutos,
      'minutos_atuais': minutos_atuais,
      'concluido': concluido,
    };
  }
}