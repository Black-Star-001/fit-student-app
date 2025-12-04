import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  // Variável que guarda se é escuro (true) ou claro (false)
  bool _isDarkMode = false;

  // Getter para saber o estado atual
  bool get isDarkMode => _isDarkMode;

  // Construtor: Carrega o tema salvo ao iniciar
  ThemeProvider() {
    _loadThemeFromPrefs();
  }

  // Alterna o tema e salva
  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // Avisa o app para repintar a tela

    // Salva a escolha
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_dark_mode', _isDarkMode);
  }

  // Carrega do celular
  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('is_dark_mode') ?? false; // Padrão é claro
    notifyListeners();
  }
}