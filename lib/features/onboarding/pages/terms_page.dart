import 'package:flutter/material.dart';
import '../login_page.dart'; 

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  final ScrollController _scrollController = ScrollController();

  bool _agreedToTerms = false;      
  bool _hasReadToBottom = false;    

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent - 50 &&
        !_scrollController.position.outOfRange) {
      
      if (!_hasReadToBottom) {
        setState(() {
          _hasReadToBottom = true; 
        });
      }
    }
  }

  final String _termsText = """
TERMOS DE USO E POLÍTICA DE PRIVACIDADE - FITSTUDENT

Última atualização: Dezembro de 2025

Bem-vindo ao FitStudent. Ao utilizar este aplicativo, você concorda com os termos abaixo. Por favor, leia com atenção.

1. OBJETIVO DO APLICATIVO
O FitStudent é uma ferramenta de auxílio para estudantes, focada em produtividade (timer Pomodoro) e bem-estar (sugestões de pausas e alongamentos).

2. ISENÇÃO DE RESPONSABILIDADE MÉDICA (IMPORTANTE)
O conteúdo deste aplicativo (exercícios, alongamentos e dicas de saúde) tem caráter meramente informativo e educacional. 
- O FitStudent NÃO substitui o aconselhamento, diagnóstico ou tratamento médico profissional.
- Antes de iniciar qualquer rotina de exercícios, consulte um médico ou profissional de educação física, especialmente se tiver histórico de lesões ou condições pré-existentes.
- Ao realizar os movimentos sugeridos, você assume total responsabilidade por sua integridade física. O desenvolvedor não se responsabiliza por lesões decorrentes do uso do app.

3. COLETA E USO DE DADOS (LGPD)
Para o funcionamento do aplicativo, coletamos dados mínimos: Nome, E-mail e Senha (para login) e dados de uso (tempo de estudo).
- Seus dados são armazenados de forma segura e não são vendidos para terceiros.
- Você tem o direito de solicitar a exclusão da sua conta e de seus dados a qualquer momento através do menu de perfil.

4. CONDUTA DO USUÁRIO
Você concorda em usar o aplicativo apenas para fins lícitos e pessoais. É proibido tentar invadir, copiar ou distribuir o código-fonte deste software.

5. ALTERAÇÕES NOS TERMOS
Podemos atualizar estes termos periodicamente. O uso contínuo do aplicativo após as alterações constitui aceitação dos novos termos.

Ao clicar em "Concordo e Continuar", você declara que leu, compreendeu e aceita todas as condições acima.
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Termos de Uso'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Scrollbar(
                thumbVisibility: true,
                controller: _scrollController, 
                child: SingleChildScrollView(
                  controller: _scrollController, 
                  child: Text(
                    _termsText,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  // CORREÇÃO: Uso de .withValues(alpha: ...) ao invés de .withOpacity
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                )
              ],
            ),
            child: Column(
              children: [
                CheckboxListTile(
                  enabled: _hasReadToBottom, 
                  value: _agreedToTerms,
                  onChanged: _hasReadToBottom 
                      ? (value) {
                          setState(() {
                            _agreedToTerms = value ?? false;
                          });
                        }
                      : null, 
                  
                  title: Text(
                    "Li e concordo com os Termos de Uso e Política de Privacidade.",
                    style: TextStyle(
                      fontSize: 14,
                      color: _hasReadToBottom ? Colors.black : Colors.grey,
                    ),
                  ),
                  subtitle: !_hasReadToBottom 
                      ? const Text(
                          "(Role até o fim para habilitar)",
                          style: TextStyle(color: Colors.redAccent, fontSize: 12),
                        )
                      : null,
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.blue,
                ),
                
                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (_hasReadToBottom && _agreedToTerms)
                        ? () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPage()),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      "CONCORDAR E CONTINUAR",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}