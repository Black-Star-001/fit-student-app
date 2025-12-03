PRD - FitStudent
1) Identificação

    Seu nome completo: Guilherme Henrique da Silva

    E-mail institucional: guilherme.221203@alunos.utfpr.edu.br

    Equipe (4 pessoas): Guilherme Henrique da Silva OBS: Não tinha grupo então fiz sozinho.

2) Pareamento — Colegas que EU vou avaliar (da minha equipe) OBS: Não tinha grupo então me avaliei.
Colega A

    Nome: Guilherme

    @GitHub: Black-Star-001

    URL do repositório: https://github.com/Black-Star-001/fit-student-app

    Branch padrão (tree): .../tree/main

    PRD (se aplicável): .../blob/main/docs/PRD.md


Integridade:

    [] Confirmo que não incluí meu próprio repositório entre os avaliados.


3) Meu repositório (para conferência)

    URL do meu repositório: https://github.com/Black-Star-001/fit-student-app

    Branch padrão (tree): .../tree/main

    Último commit (SHA/link): [LINK DO ÚLTIMO COMMIT NO GITHUB]

    PRD (se aplicável): .../blob/main/docs/PRD.md

    Visibilidade: (x) Público ( ) Privado — concedi acesso ao professor

4) Evidências no PRD (obrigatórias — 2+)

    Evidência 1 (Termos de Uso com Scroll Obrigatório):

        Arquivo: lib/features/onboarding/pages/terms_page.dart

        Descrição: Implementação de ScrollController que detecta o fim da rolagem para habilitar o checkbox de aceite.

    Evidência 2 (Persistência e Auth com Supabase):

        Arquivo: lib/features/onboarding/login_page.dart

        Descrição: Lógica de cadastro que vincula o Auth do Supabase com uma tabela personalizada usuario (usando int8 e uid).

    Evidência 3 (Arquitetura Clean):

        Pasta: lib/features/providers/

        Descrição: Separação clara entre Domain, Infrastructure e Presentation.

5) Fluxo pronto para demo (marque o que funciona AGORA)

    [x] Splash direciona conforme consentimento/login salvo (splashscreen_page.dart)

    [x] Onboarding / Welcome Page (welcome_page.dart)

    [x] PolicyViewer com scroll completo e “Marcar como lido” (terms_page.dart)

    [x] Opt-in: botão Salvar só habilita após leitura + checkbox (terms_page.dart)

    [ ] Home com Revogar + Desfazer (Temos Logout no Perfil, mas não revogação explícita de termos ainda)

6) LGPD & A11y (checagem objetiva)

    [x] Opt-in real (sem aceite implícito - Checkbox obrigatório)

    [x] Alvos ≥ 48dp (Botões padrão do Material Design)

    [x] Contraste legível (Azul sobre Branco / Preto sobre Branco)

    [x] Text scaling ≥ 1.3 OK (Uso de SingleChildScrollView nas telas de Login e Termos para evitar overflow)

7) Arquitetura

    [ ] Rotas nomeadas (Utilizamos Navegação direta MaterialPageRoute por enquanto)

    [x] Persistência via service (Uso de SupabaseService e StudyRepository, sem acesso direto na View)

    [x] Arquivo(s) relevante(s): lib/features/providers/infrastructure/repositories/study_repository_impl.dart

8) Prontidão para demo

    Aparelho/emulador pronto? (x) Sim ( ) Não

    Roteiro preparado (90s + 30s)? ( ) Sim (x) Não 

9) Bloqueios (se houver)

    Nenhum bloqueio técnico no momento (App rodando e conectado).

10) Compromisso imediato pós-demo

Assuma 1 ajuste rápido para executar em até 24h.

    Meu ajuste rápido será: Implementar o contador visual (Timer Pomodoro) na tela Home para registrar o tempo real de estudo.