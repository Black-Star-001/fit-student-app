import 'package:flutter/material.dart';
import 'features/app/student_health_app.dart';
import 'services/env_service.dart';
import 'services/supabase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Carrega as variáveis de ambiente
  await EnvService.init();

  // 2. Inicializa o Supabase
  await SupabaseService.init();

  // 3. Roda o App
  runApp(const StudentHealthApp());
}