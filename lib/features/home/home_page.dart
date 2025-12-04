import 'package:flutter/material.dart';
import 'profile_page.dart';
// Import da tela de histórico
import '../providers/presentation/study_history_page.dart';
// Import do Menu Lateral (Drawer) que acabamos de criar
import 'widgets/home_drawer.dart';

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
        // O Drawer adiciona automaticamente o ícone de menu na esquerda.
        // Se quiser manter o ícone de perfil na direita como atalho rápido, pode deixar:
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (_) => const ProfilePage())
              );
            },
          )
        ],
      ),
      
      // --- AQUI ESTÁ A MUDANÇA PRINCIPAL ---
      drawer: const HomeDrawer(), 
      // -------------------------------------

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Card Principal - Timer de Estudo (Exemplo visual)
            Card(
              color: Colors.blue,
              elevation: 4,
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
            
            // Botão para ver o Histórico
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const StudyHistoryPage())
                );
              },
              icon: const Icon(Icons.history),
              label: const Text('Ver Histórico de Estudos'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Botão para ver Exercícios (Placeholder)
            OutlinedButton.icon(
              onPressed: () {
                 ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text('Funcionalidade de exercícios em breve!'))
                 );
              },
              icon: const Icon(Icons.accessibility_new),
              label: const Text('Alongamentos Rápidos'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}