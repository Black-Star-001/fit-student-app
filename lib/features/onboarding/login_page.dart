import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// Ajuste o import abaixo se o caminho para o seu student_health_app.dart for diferente
import 'package:projeto_final_coimbra/features/app/student_health_app.dart'; 
import '../home/home_page.dart';
// O import do splashscreen não é estritamente necessário aqui, mas se estiver usando, mantenha.
import '../splashscreen/splashscreen_page.dart'; 

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
  bool _isLoginMode = true; // true = Tela de Login, false = Tela de Cadastro

  // --- LÓGICA DE LOGIN (Entrar) ---
  Future<void> _signIn() async {
    setState(() => _isLoading = true);
    try {
      // 1. Autentica no sistema (Auth)
      final authResponse = await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // 2. Verifica se o usuário existe na SUA tabela personalizada
      if (authResponse.user != null) {
        // CORREÇÃO AQUI: Mudamos de 'estudantes' para 'usuario'
        final data = await Supabase.instance.client
            .from('usuario') 
            .select()
            // Buscamos pelo UID que é o link com o login
            .eq('uid', authResponse.user!.id)
            .maybeSingle();

        if (data == null) {
          // Usuário logou no Auth, mas não tem dados na tabela 'usuario'
          print("Aviso: Usuário sem dados na tabela 'usuario'.");
        } else {
          print("Login realizado. Nome na tabela: ${data['nome']}");
        }
        
        if (mounted) {
          // Redireciona para a Home
          Navigator.of(context).pushAndRemoveUntil(
             MaterialPageRoute(builder: (_) => const HomePage()),
             (route) => false, // Remove as telas anteriores do histórico
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

  // --- LÓGICA DE CADASTRO (Criar Conta) ---
  Future<void> _signUp() async {
    // Validação básica dos campos
    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preencha todos os campos!')));
      return;
    }

    setState(() => _isLoading = true);
    try {
      // 1. Cria o login no sistema de Autenticação (Auth)
      final authResponse = await Supabase.instance.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final user = authResponse.user;

      // 2. SALVA OS DADOS NA SUA TABELA 'usuario'
      if (user != null) {
        // CORREÇÃO AQUI: Mudamos de 'estudantes' para 'usuario'
        await Supabase.instance.client.from('usuario').insert({
          // Usamos o ID do Auth como 'uid' para vincular
          'uid': user.id, 
          'email': _emailController.text.trim(),
          'senha': _passwordController.text.trim(),
          'nome': _nameController.text.trim(),
          // Agora que mudamos para int8 no banco, o 0 vai funcionar
          'tempo_de_exercicio': 0,
          'tempo_de_estudo': 0,
        });
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Conta criada com sucesso! Faça login.')),
          );
          // Volta para a tela de login e limpa os campos
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
      // Esse catch vai pegar o erro se os tipos das colunas no banco ainda estiverem errados
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar na tabela: $e')));
      print("Erro detalhado do cadastro: $e");
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
              
              // Campo de Nome (Só aparece se estiver criando conta)
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