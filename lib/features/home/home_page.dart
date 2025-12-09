import 'package:flutter/material.dart';
import 'profile_page.dart';
import '../providers/presentation/study_history_page.dart';
import 'widgets/home_drawer.dart';

// Import dos novos widgets
import '../hydration/presentation/widgets/hydration_card.dart';
import '../exercises/presentation/pages/exercises_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FitStudent'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
            },
          )
        ],
      ),
      
      drawer: const HomeDrawer(),

      body: SingleChildScrollView( // Adicionado scroll para caber tudo
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Card de Hidratação (NOVO)
            const HydrationCard(),
            
            const SizedBox(height: 20),

            // 2. Card Principal - Timer
            Card(
              color: Colors.blue,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: const [
                    Icon(Icons.timer, size: 64, color: Colors.white),
                    SizedBox(height: 16),
                    Text(
                      'Pronto para focar?',
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 24, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // 3. Botões de Ação
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const StudyHistoryPage()));
                    },
                    icon: const Icon(Icons.history),
                    label: const Text('Histórico'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Navega para a tela de Exercícios (NOVO)
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ExercisesPage()));
                    },
                    icon: const Icon(Icons.accessibility_new),
                    label: const Text('Exercícios'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade50,
                      foregroundColor: Colors.green.shade800,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}