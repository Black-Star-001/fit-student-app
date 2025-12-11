import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/supabase_service.dart';
import '../../theme/app_theme.dart';
import '../../theme/theme_provider.dart';

// --- Imports do Histórico ---
import '../providers/domain/repositories/study_repository.dart';
import '../providers/infrastructure/local/study_local_datasource.dart';
import '../providers/infrastructure/remote/study_remote_datasource.dart';
import '../providers/infrastructure/repositories/study_repository_impl.dart';

// --- Imports de Hidratação e Exercícios ---
import '../hydration/infrastructure/remote/hydration_remote_datasource.dart';
import '../hydration/infrastructure/repositories/hydration_repository_impl.dart';
import '../exercises/infrastructure/remote/exercise_remote_datasource.dart';
import '../exercises/infrastructure/repositories/exercise_repository_impl.dart';

// --- NOVOS IMPORTS (Meta Diária e Conquistas) ---
import '../goals/infrastructure/remote/daily_goal_remote_datasource.dart';
import '../goals/infrastructure/repositories/daily_goal_repository_impl.dart';
import '../achievements/infrastructure/remote/achievement_remote_datasource.dart';
import '../achievements/infrastructure/repositories/achievement_repository_impl.dart';

import '../splashscreen/splashscreen_page.dart';

class StudentHealthApp extends StatelessWidget {
  const StudentHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 1. Histórico de Estudos
        Provider<StudyRepository>(
          create: (_) => StudyRepositoryImpl(
            StudyRemoteDataSource(SupabaseService.client),
            StudyLocalDataSource(),
          ),
        ),
        
        // 2. Hidratação
        Provider<HydrationRepositoryImpl>(
          create: (_) => HydrationRepositoryImpl(
            HydrationRemoteDataSource(SupabaseService.client),
          ),
        ),

        // 3. Exercícios
        Provider<ExerciseRepositoryImpl>(
          create: (_) => ExerciseRepositoryImpl(
            ExerciseRemoteDataSource(SupabaseService.client),
          ),
        ),

        // 4. Meta Diária (NOVO - Passo 4)
        Provider<DailyGoalRepositoryImpl>(
          create: (_) => DailyGoalRepositoryImpl(
            DailyGoalRemoteDataSource(SupabaseService.client),
          ),
        ),

        // 5. Conquistas (NOVO - Passo 4)
        Provider<AchievementRepositoryImpl>(
          create: (_) => AchievementRepositoryImpl(
            AchievementRemoteDataSource(SupabaseService.client),
          ),
        ),

        // 6. Tema (Escuro/Claro)
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'FitStudent',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const SplashscreenPage(),
          );
        },
      ),
    );
  }
}