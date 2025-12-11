import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/daily_goal.dart';
import '../../infrastructure/repositories/daily_goal_repository_impl.dart';

class DailyGoalCard extends StatefulWidget {
  const DailyGoalCard({super.key});

  @override
  State<DailyGoalCard> createState() => _DailyGoalCardState();
}

class _DailyGoalCardState extends State<DailyGoalCard> {
  DailyGoal? _goal;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGoal();
  }

  Future<void> _loadGoal() async {
    final repo = context.read<DailyGoalRepositoryImpl>();
    var goal = await repo.getTodayGoal();
    
    // Se não tiver meta hoje, cria uma padrão
    if (goal == null) {
      goal = DailyGoal(
        id: '', // Banco gera
        date: DateTime.now(),
        targetMinutes: 120, // Meta padrão de 2 horas
        currentMinutes: 0,
        isCompleted: false
      );
      await repo.saveGoal(goal);
    }

    if (mounted) {
      setState(() {
        _goal = goal;
        _isLoading = false;
      });
    }
  }

  Future<void> _addProgress() async {
    if (_goal == null) return;
    final repo = context.read<DailyGoalRepositoryImpl>();
    
    // Simula estudar +30 min
    final newMinutes = _goal!.currentMinutes + 30;
    final isDone = newMinutes >= _goal!.targetMinutes;

    final newGoal = DailyGoal(
      id: _goal!.id,
      date: _goal!.date,
      targetMinutes: _goal!.targetMinutes,
      currentMinutes: newMinutes,
      isCompleted: isDone
    );

    await repo.saveGoal(newGoal);
    setState(() => _goal = newGoal);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _goal == null) return const Center(child: CircularProgressIndicator());

    double progress = (_goal!.currentMinutes / _goal!.targetMinutes).clamp(0.0, 1.0);

    return Card(
      color: Colors.indigo.shade50,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Meta de Estudo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
                Text("${_goal!.currentMinutes} / ${_goal!.targetMinutes} min", style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
              backgroundColor: Colors.indigo.shade100,
              color: Colors.indigo,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: _addProgress,
                icon: const Icon(Icons.add_task),
                label: const Text("Registrar +30min"),
              ),
            )
          ],
        ),
      ),
    );
  }
}