import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _supabase;

  AuthRepository(this._supabase);

  // Login
  Future<AuthResponse> signIn({required String email, required String password}) async {
    return await _supabase.auth.signInWithPassword(
      email: email, 
      password: password
    );
  }

  // Cadastro
  Future<AuthResponse> signUp({required String email, required String password}) async {
    return await _supabase.auth.signUp(
      email: email, 
      password: password
    );
  }

  // Logout
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // Pegar usuário atual
  User? get currentUser => _supabase.auth.currentUser;
}