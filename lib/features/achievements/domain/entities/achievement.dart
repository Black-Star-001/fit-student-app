class Achievement {
  final String id;
  final String title;
  final String description;
  final String iconName;      // Nome do ícone (ex: 'trophy', 'star')
  final bool isUnlocked;      // Se o aluno já ganhou
  final DateTime? unlockedAt; // Quando ganhou (pode ser nulo se não ganhou)

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    required this.isUnlocked,
    this.unlockedAt,
  });
}