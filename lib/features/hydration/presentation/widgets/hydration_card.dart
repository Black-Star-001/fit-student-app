import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/hydration.dart';
import '../../infrastructure/repositories/hydration_repository_impl.dart';

class HydrationCard extends StatefulWidget {
  const HydrationCard({super.key});

  @override
  State<HydrationCard> createState() => _HydrationCardState();
}

class _HydrationCardState extends State<HydrationCard> {
  int _currentMl = 0;
  final int _goalMl = 2000;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final repo = context.read<HydrationRepositoryImpl>();
    final data = await repo.getTodayHydration();
    if (data != null && mounted) {
      setState(() {
        _currentMl = data.waterIntakeMl;
      });
    }
  }

  Future<void> _addWater() async {
    setState(() => _isLoading = true);
    try {
      final repo = context.read<HydrationRepositoryImpl>();
      final newAmount = _currentMl + 250; // Adiciona um copo
      
      final entry = Hydration(
        id: '', 
        date: DateTime.now(), 
        waterIntakeMl: newAmount, 
        dailyGoalMl: _goalMl
      );

      await repo.saveHydration(entry);
      setState(() => _currentMl = newAmount);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('💧 Água registrada! Continue assim.')),
        );
      }
    } catch (e) {
      debugPrint('Erro ao salvar água: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calcula porcentagem (0.0 a 1.0)
    double progress = (_currentMl / _goalMl).clamp(0.0, 1.0);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Hidratação", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Icon(Icons.water_drop, color: Colors.blue.shade400),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Gráfico Circular
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 8,
                        backgroundColor: Colors.grey.shade200,
                        color: Colors.blue,
                      ),
                    ),
                    Text("${(progress * 100).toInt()}%", style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(width: 20),
                // Textos
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("$_currentMl / $_goalMl ml", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const Text("Meta Diária", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                const Spacer(),
                // Botão Adicionar
                IconButton.filled(
                  onPressed: _isLoading ? null : _addWater,
                  icon: _isLoading 
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white))
                      : const Icon(Icons.add),
                  style: IconButton.styleFrom(backgroundColor: Colors.blue),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}