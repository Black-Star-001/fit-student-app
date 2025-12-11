import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/achievement.dart';
import '../../infrastructure/repositories/achievement_repository_impl.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({super.key});

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  List<Achievement> _achievements = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final repo = context.read<AchievementRepositoryImpl>();
      // Esta função chama o "seed" internamente no repositório,
      // então se for a primeira vez, ele cria as medalhas no banco.
      final list = await repo.getMyAchievements();
      
      if (mounted) {
        setState(() {
          _achievements = list;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Erro ao carregar conquistas: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Escolhe o ícone visualmente baseado no nome salvo no banco
  IconData _getIcon(String name) {
    switch (name) {
      case 'star': return Icons.star;
      case 'water_drop': return Icons.water_drop;
      case 'timer': return Icons.timer;
      default: return Icons.emoji_events;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Conquistas')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _achievements.isEmpty 
              ? const Center(child: Text("Nenhuma conquista encontrada."))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _achievements.length,
                  itemBuilder: (context, index) {
                    final item = _achievements[index];
                    return Card(
                      // Visual muda se estiver desbloqueada
                      elevation: item.isUnlocked ? 4 : 0,
                      color: item.isUnlocked ? Colors.white : Colors.grey.shade200,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: item.isUnlocked ? Colors.amber : Colors.grey.shade400,
                          child: Icon(_getIcon(item.iconName), color: Colors.white),
                        ),
                        title: Text(
                          item.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: item.isUnlocked ? Colors.black : Colors.grey.shade700,
                          ),
                        ),
                        subtitle: Text(item.description),
                        trailing: item.isUnlocked 
                            ? const Icon(Icons.check_circle, color: Colors.green)
                            : const Icon(Icons.lock, color: Colors.grey),
                      ),
                    );
                  },
                ),
    );
  }
}