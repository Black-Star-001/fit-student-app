import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/supabase_service.dart';
import '../../theme/app_theme.dart'; // <--- Import dos temas
import '../../theme/theme_provider.dart'; // <--- Import da lógica
import '../providers/domain/repositories/study_repository.dart';
import '../providers/infrastructure/local/study_local_datasource.dart';
import '../providers/infrastructure/remote/study_remote_datasource.dart';
import '../providers/infrastructure/repositories/study_repository_impl.dart';
import '../splashscreen/splashscreen_page.dart';

class StudentHealthApp extends StatelessWidget {
  const StudentHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider do Banco de Dados (já existia)
        Provider<StudyRepository>(
          create: (_) => StudyRepositoryImpl(
            StudyRemoteDataSource(SupabaseService.client),
            StudyLocalDataSource(),
          ),
        ),
        
        // NOVO: Provider do Tema
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      // O Consumer "escuta" as mudanças do ThemeProvider
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Estudante Ativo',
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