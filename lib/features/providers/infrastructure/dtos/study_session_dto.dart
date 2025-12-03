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

  factory StudySessionDto.fromMap(Map<String, dynamic> map) {
    return StudySessionDto(
      id: map['id']?.toString() ?? '',
      date: map['created_at'] ?? '',
      durationMinutes: map['duration'] ?? 0,
      type: map['type'] ?? 'FOCUS',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'duration': durationMinutes,
      'type': type,
      // O Supabase gera ID e Date automaticamente na criação, 
      // mas enviamos se for atualização
    };
  }
}