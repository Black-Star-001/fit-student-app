import 'package:supabase_flutter/supabase_flutter.dart';
import 'env_service.dart';

class SupabaseService {
  static Future<void> init() async {
    await Supabase.initialize(
      url: EnvService.supabaseUrl,
      anonKey: EnvService.supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}