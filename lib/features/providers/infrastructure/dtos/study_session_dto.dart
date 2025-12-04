class StudySessionDto {
  final String id;
  final String date;
  final int durationMinutes;
  final String type;

  StudySessionDto({
    required this.id,
    required this.date,
    required this.durationMinutes,
    required this.type,
  });

  // Lê do banco (criado_em) -> Transforma em (date)
  factory StudySessionDto.fromMap(Map<String, dynamic> map) {
    return StudySessionDto(
      id: map['id']?.toString() ?? '',
      // CORREÇÃO: Usando o nome correto da coluna do banco
      date: map['criado_em'] ?? '', 
      durationMinutes: map['duracao'] ?? 0, 
      type: map['tipo'] ?? 'FOCUS',
    );
  }

  // Pega do App (date) -> Transforma para o banco (criado_em)
  Map<String, dynamic> toMap() {
    return {
      'id': id, 
      // CORREÇÃO: Usando o nome correto
      'criado_em': date, 
      'duracao': durationMinutes,
      'tipo': type,
    };
  }
}