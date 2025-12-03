import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../home/home_page.dart';
//import '../onboarding/login_page.dart';
import '../onboarding/welcome_page.dart';

class SplashscreenPage extends StatefulWidget {
  const SplashscreenPage({super.key});

  @override
  State<SplashscreenPage> createState() => _SplashscreenPageState();
}

class _SplashscreenPageState extends State<SplashscreenPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    // 1. Simula um tempinho de carregamento (aumentei para 2s para dar tempo de ver a logo)
    await Future.delayed(const Duration(seconds: 2));

    // 2. Verifica se tem sessão ativa no Supabase
    final session = Supabase.instance.client.auth.currentSession;

    if (!mounted) return;

    if (session != null) {
      // USUÁRIO LOGADO -> Vai para a Home
      // (Descomentei a linha abaixo para funcionar)
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
    } else {
      // USUÁRIO NÃO LOGADO -> Vai para o Login
      // (Descomentei a linha abaixo para funcionar)
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const WelcomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(
              'assets/splashscreen.png',
              width: 150, 
              height: 150,
            ),
            // --------------------------------------------------
            
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            const Text("Carregando FitStudent..."),
          ],
        ),
      ),
    );
  }
}