import 'package:flutter/material.dart';

class AppTheme {
  // Configuração do Tema Claro
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white, // Cor do texto/ícones
      centerTitle: true,
    ),
    // Removi o cardTheme para evitar o erro de tipo
  );

  // Configuração do Tema Escuro
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark, // Isso faz a mágica do escuro
    ),
    scaffoldBackgroundColor: const Color(0xFF121212), // Preto suave
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade900,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
    // Removi o cardTheme para evitar o erro de tipo
  );
}