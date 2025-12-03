import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Imports dos serviços e repositórios que já criamos
import '../../services/supabase_service.dart';
import '../providers/domain/repositories/study_repository.dart';
import '../providers/infrastructure/remote/study_remote_datasource.dart';
import '../providers/infrastructure/repositories/study_repository_impl.dart';

// Import da única tela que temos pronta por enquanto
import '../providers/presentation/study_history_page.dart';

//Import da splashcreen
import '../splashscreen/splashscreen_page.dart';

class StudentHealthApp extends StatelessWidget {
  const StudentHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Aqui injetamos o Repositório para que as telas consigam salvar dados
        Provider<StudyRepository>(
          create: (_) => StudyRepositoryImpl(
            StudyRemoteDataSource(SupabaseService.client),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Estudante Ativo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        // Por enquanto, vamos abrir direto na tela de Histórico
        // Depois mudaremos para Splash ou Login
        home: const SplashscreenPage(),
      ),
    );
  }
}