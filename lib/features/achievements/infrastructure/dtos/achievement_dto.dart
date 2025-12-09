class AchievementDto {
  final String id;
  final String titulo;           // Banco: titulo
  final String descricao;        // Banco: descricao
  final String nome_icone;       // Banco: nome_icone
  final bool desbloqueada;       // Banco: desbloqueada
  final String? desbloqueada_em; // Banco: desbloqueada_em (pode ser nulo)

  AchievementDto({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.nome_icone,
    required this.desbloqueada,
    this.desbloqueada_em,
  });

  factory AchievementDto.fromMap(Map<String, dynamic> map) {
    return AchievementDto(
      id: map['id']?.toString() ?? '',
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      nome_icone: map['nome_icone'] ?? 'default',
      desbloqueada: map['desbloqueada'] ?? false,
      desbloqueada_em: map['desbloqueada_em'], // Pode vir nulo
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'nome_icone': nome_icone,
      'desbloqueada': desbloqueada,
      'desbloqueada_em': desbloqueada_em,
    };
  }
}