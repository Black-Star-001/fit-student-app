class ExerciseDto {
  final String id;
  final String titulo;      // Português (Banco)
  final String descricao;   // Português (Banco)
  final String url_video;   // Snake_case (Banco)
  final int duracao_seg;    // Snake_case (Banco)

  ExerciseDto({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.url_video,
    required this.duracao_seg,
  });

  // Converte de JSON (Banco) para DTO
  factory ExerciseDto.fromMap(Map<String, dynamic> map) {
    return ExerciseDto(
      id: map['id']?.toString() ?? '',
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      url_video: map['url_video'] ?? '',
      duracao_seg: map['duracao_seg'] ?? 0,
    );
  }

  // Converte de DTO para JSON (Banco)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'url_video': url_video,
      'duracao_seg': duracao_seg,
    };
  }
}