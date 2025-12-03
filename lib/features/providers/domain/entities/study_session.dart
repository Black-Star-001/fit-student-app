class StudySession {
  final String id;
  final DateTime date;
  final int durationMinutes;
  final String type; // Pode ser 'FOCUS' (estudo) ou 'BREAK' (pausa/alongamento)

  StudySession({
    required this.id,
    required this.date,
    required this.durationMinutes,
    required this.type,
  });

  // Converte para Map (útil para salvar no banco depois)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'duration_minutes': durationMinutes,
      'type': type,
    };
  }

  // Cria o objeto a partir de um Map (útil ao ler do banco)
  factory StudySession.fromMap(Map<String, dynamic> map) {
    return StudySession(
      id: map['id'] ?? '',
      date: DateTime.parse(map['date']),
      durationMinutes: map['duration_minutes'] ?? 0,
      type: map['type'] ?? 'FOCUS',
    );
  }
}