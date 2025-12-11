FitStudent

Um aplicativo desenvolvido em Flutter para ajudar estudantes a combater o sedentarismo, combinando rotina de estudos com pausas ativas e exercícios de alongamento.

Características

🎨 Interface limpa e intuitiva

🔐 Autenticação segura e cadastro via Supabase

📜 Termos de Uso com verificação de leitura obrigatória e scroll

🖼️ Avatar de perfil com foto (Câmera/Galeria) e persistência local

🌗 Tema Escuro (Dark Mode) com persistência de preferência

⏱️ Histórico de Estudos sincronizado (Local + Nuvem)

💧 Controle de Hidratação

🧘 Catálogo de Exercícios de Alongamento

🎯 Metas Diárias de Estudo

🏆 Sistema de Conquistas (Gamificação)

Paleta de Cores

Primary Blue: Colors.blue (Cor principal do app)

Background Light: #FFFFFF (Fundo claro)

Background Dark: #121212 (Fundo escuro)

Pré-requisitos

Para rodar este projeto, você precisará de:

Flutter SDK instalado

Conta no Supabase (para o backend)

Arquivo de configuração de variáveis de ambiente (.env)

Como Executar

Clone este repositório:

git clone [https://github.com/Black-Star-001/fit-student-app.git](https://github.com/Black-Star-001/fit-student-app.git)


Navegue até o diretório do projeto:

cd fit-student-app


Instale as dependências:

flutter pub get


Configuração do Ambiente (Importante):
Crie um arquivo chamado .env na raiz do projeto e adicione suas chaves:

SUPABASE_URL=sua_url_aqui
SUPABASE_ANON_KEY=sua_chave_anonima_aqui


Execute o aplicativo:

flutter run


Estrutura do Projeto

O projeto segue estritamente a Clean Architecture, organizando o código por features (funcionalidades) e camadas (Domain, Infrastructure, Presentation).

lib/
├── features/
│   ├── achievements/        # 🏆 Gamificação (Conquistas)
│   │   ├── domain/          # Entidade Achievement
│   │   ├── infrastructure/  # Conexão com tabela 'conquista'
│   │   └── presentation/    # Tela de lista de medalhas
│   ├── app/                 # Configuração global (MaterialApp, MultiProvider)
│   ├── exercises/           # 🧘 Catálogo de Exercícios
│   │   ├── domain/          # Entidade Exercise
│   │   ├── infrastructure/  # Conexão com tabela 'exercicio'
│   │   └── presentation/    # Tela de lista de alongamentos
│   ├── goals/               # 🎯 Metas Diárias
│   │   ├── domain/          # Entidade DailyGoal
│   │   ├── infrastructure/  # Conexão com tabela 'meta_diaria'
│   │   └── presentation/    # Widget de Card de Meta na Home
│   ├── home/                # Tela Principal, Drawer (Avatar) e Perfil
│   ├── hydration/           # 💧 Controle de Hidratação
│   │   ├── domain/          # Entidade Hydration
│   │   ├── infrastructure/  # Conexão com tabela 'hidratacao'
│   │   └── presentation/    # Widget de Card de Água na Home
│   ├── models/              # Modelos auxiliares (Consentimento, etc)
│   ├── onboarding/          # Telas de Login, Cadastro e Termos de Uso
│   ├── providers/           # ⏱️ Histórico de Estudos (Feature Base)
│   │   ├── domain/          # Regras de Negócio (StudySession)
│   │   ├── infrastructure/  # Repositório com Cache Local + Remoto
│   │   └── presentation/    # Tela de Histórico e Lógica de UI
│   └── splashscreen/        # Tela de carregamento inicial
├── services/                # Serviços de Terceiros
│   ├── auth_repository.dart # Autenticação
│   ├── env_service.dart     # Variáveis de ambiente
│   ├── supabase_service.dart# Cliente Supabase
│   └── ...                  # Serviços de Storage Local
├── theme/                   # 🌗 Configuração de Tema
│   ├── app_theme.dart       # Definição de Cores (Light/Dark)
│   └── theme_provider.dart  # Lógica de troca de tema
├── main.dart                # Ponto de entrada da aplicação
└── test_exercise.dart       # 🧪 Script de Teste de Arquitetura (4 Entidades)


Banco de Dados (Supabase)

O projeto utiliza as seguintes tabelas no PostgreSQL:

usuario: Dados do perfil (vínculo com Auth).

sessao_estudo: Histórico de tempo focado.

exercicio: Catálogo de alongamentos disponíveis.

meta_diaria: Registro de metas e progresso diário.

conquista: Medalhas desbloqueadas pelo usuário.

hidratacao: Registro de consumo de água.

Desenvolvido por Guilherme 