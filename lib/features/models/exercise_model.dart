class ExerciseModel {
  final String id;
  final String title;
  final String description;
  final int durationSeconds;
  final String? assetPath; // Caminho para o ícone/imagem

  ExerciseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.durationSeconds,
    this.assetPath,
  });
}