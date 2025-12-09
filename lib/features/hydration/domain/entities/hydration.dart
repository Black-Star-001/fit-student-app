class Hydration {
  final String id;
  final DateTime date;      // Data do registo
  final int waterIntakeMl;  // Quanto bebeu (ex: 250ml)
  final int dailyGoalMl;    // Meta do dia (ex: 2000ml)

  const Hydration({
    required this.id,
    required this.date,
    required this.waterIntakeMl,
    required this.dailyGoalMl,
  });
}