import 'package:flutter/material.dart';
// <--- CORREÇÃO: Import necessário para debugPrint
import 'package:supabase_flutter/supabase_flutter.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController(); 
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isLoading = false;
  bool _isLoginMode = true; 

  Future<void> _signIn() async {
    setState(() => _isLoading = true);
    try {
      final authResponse = await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (authResponse.user != null) {
        final data = await Supabase.instance.client
            .from('usuario') 
            .select()
            .eq('uid', authResponse.user!.id)
            .maybeSingle();

        if (data == null) {
          // CORREÇÃO: debugPrint em vez de print
          debugPrint("Aviso: Usuário sem dados na tabela 'usuario'.");
        } else {
          // CORREÇÃO: debugPrint em vez de print
          debugPrint("Login realizado. Nome na tabela: ${data['nome']}");
        }
        
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
             MaterialPageRoute(builder: (_) => const HomePage()),
             (route) => false, 
          );
        }
      }
    } on AuthException catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro de Login: ${e.message}")));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro inesperado: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _signUp() async {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preencha todos os campos!')));
      return;
    }

    setState(() => _isLoading = true);
    try {
      final authResponse = await Supabase.instance.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final user = authResponse.user;

      if (user != null) {
        await Supabase.instance.client.from('usuario').insert({
          'uid': user.id, 
          'email': _emailController.text.trim(),
          'senha': _passwordController.text.trim(),
          'nome': _nameController.text.trim(),
          'tempo_de_exercicio': 0,
          'tempo_de_estudo': 0,
        });
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Conta criada com sucesso! Faça login.')),
          );
          setState(() {
            _isLoginMode = true;
            _passwordController.clear();
            _nameController.clear();
          });
        }
      }
    } on AuthException catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro de Cadastro: ${e.message}")));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar na tabela: $e')));
      // CORREÇÃO: debugPrint em vez de print
      debugPrint("Erro detalhado do cadastro: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLoginMode ? 'Entrar no FitStudent' : 'Criar Conta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.school, size: 80, color: Colors.blue),
              const SizedBox(height: 20),
              
              if (!_isLoginMode) ...[
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Seu Nome', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
              ],

              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Senha', border: OutlineInputBorder()),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              
              if (_isLoading)
                const CircularProgressIndicator()
              else ...[
                ElevatedButton(
                  onPressed: _isLoginMode ? _signIn : _signUp,
                  style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                  child: Text(_isLoginMode ? 'ENTRAR' : 'CADASTRAR'),
                ),
                
                const SizedBox(height: 10),
                
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLoginMode = !_isLoginMode; 
                    });
                  },
                  child: Text(_isLoginMode 
                    ? 'Ainda não tem conta? Crie agora' 
                    : 'Já tem conta? Fazer Login'),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}