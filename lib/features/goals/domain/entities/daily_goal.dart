class DailyGoal {
  final String id;
  final DateTime date;        // Data da meta
  final int targetMinutes;    // Meta (ex: 120 min)
  final int currentMinutes;   // O que já estudou (ex: 45 min)
  final bool isCompleted;     // Se bateu a meta

  const DailyGoal({
    required this.id,
    required this.date,
    required this.targetMinutes,
    required this.currentMinutes,
    required this.isCompleted,
  });
}