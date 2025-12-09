import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/supabase_service.dart';
import '../../theme/app_theme.dart';
import '../../theme/theme_provider.dart';

// --- Imports do Histórico (Já existiam) ---
import '../providers/domain/repositories/study_repository.dart';
import '../providers/infrastructure/local/study_local_datasource.dart';
import '../providers/infrastructure/remote/study_remote_datasource.dart';
import '../providers/infrastructure/repositories/study_repository_impl.dart';

// --- NOVOS IMPORTS (Hidratação e Exercícios) ---
// Adicionamos esses para o app conhecer as novas funcionalidades
import '../hydration/infrastructure/remote/hydration_remote_datasource.dart';
import '../hydration/infrastructure/repositories/hydration_repository_impl.dart';
import '../exercises/infrastructure/remote/exercise_remote_datasource.dart';
import '../exercises/infrastructure/repositories/exercise_repository_impl.dart';

import '../splashscreen/splashscreen_page.dart';

class StudentHealthApp extends StatelessWidget {
  const StudentHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 1. Provider do Histórico de Estudos (Banco + Local)
        Provider<StudyRepository>(
          create: (_) => StudyRepositoryImpl(
            StudyRemoteDataSource(SupabaseService.client),
            StudyLocalDataSource(),
          ),
        ),
        
        // 2. Provider de Hidratação (NOVO)
        // Permite salvar e ler os copos d'água
        Provider<HydrationRepositoryImpl>(
          create: (_) => HydrationRepositoryImpl(
            HydrationRemoteDataSource(SupabaseService.client),
          ),
        ),

        // 3. Provider de Exercícios (NOVO)
        // Permite carregar a lista de alongamentos
        Provider<ExerciseRepositoryImpl>(
          create: (_) => ExerciseRepositoryImpl(
            ExerciseRemoteDataSource(SupabaseService.client),
          ),
        ),

        // 4. Provider do Tema (Escuro/Claro)
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      
      // O Consumer "escuta" as mudanças do ThemeProvider para trocar as cores
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'FitStudent',
            debugShowCheckedModeBanner: false,
            
            // Define qual é o tema claro e o escuro
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            
            // Decide qual usar baseado na variável do Provider
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            
            home: const SplashscreenPage(),
          );
        },
      ),
    );
  }
}