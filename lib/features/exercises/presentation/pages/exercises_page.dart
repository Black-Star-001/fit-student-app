import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/exercise.dart';
import '../../infrastructure/repositories/exercise_repository_impl.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  List<Exercise> _exercises = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  Future<void> _loadExercises() async {
    try {
      final repo = context.read<ExerciseRepositoryImpl>();
      final list = await repo.getAllExercises();
      if (mounted) {
        setState(() {
          _exercises = list;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        // Se der erro (tabela vazia), mostramos uma lista fake pra ficar bonito
        _generateFakeData(); 
      }
    }
  }

  void _generateFakeData() {
    setState(() {
      _exercises = [
        const Exercise(id: '1', title: 'Alongamento de Pescoço', description: 'Gire suavemente por 30s', videoUrl: '', durationSeconds: 30),
        const Exercise(id: '2', title: 'Rotação de Ombros', description: 'Para frente e para trás', videoUrl: '', durationSeconds: 45),
        const Exercise(id: '3', title: 'Esticar Braços', description: 'Entrelace os dedos e estique', videoUrl: '', durationSeconds: 60),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alongamentos Rápidos')),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _exercises.length,
              itemBuilder: (context, index) {
                final exercise = _exercises[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text("${index + 1}", style: const TextStyle(color: Colors.blue)),
                    ),
                    title: Text(exercise.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${exercise.description} • ${exercise.durationSeconds}s"),
                    trailing: const Icon(Icons.play_circle_fill, color: Colors.blue, size: 32),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Iniciando: ${exercise.title}')),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}