# FitStudent

Um aplicativo desenvolvido em Flutter para ajudar estudantes a combater o sedentarismo, combinando rotina de estudos com pausas ativas e exercícios de alongamento.

## Características

- 🎨 Interface limpa e intuitiva
- 🔐 Autenticação segura e cadastro via **Supabase**
- 📜 Termos de Uso com verificação de leitura obrigatória
- ⏱️ Monitoramento de tempo de estudo e exercício (em breve)
- 🧘 Sugestões de alongamentos para pausas (em breve)
- ☁️ Sincronização de dados na nuvem

## Paleta de Cores

- **Primary Blue**: `Colors.blue` (Cor principal do app)
- **Background**: `#FFFFFF` (Fundo claro)

## Pré-requisitos

Para rodar este projeto, você precisará de:

- Flutter SDK instalado
- Conta no Supabase (para o backend)
- Arquivo de configuração de variáveis de ambiente (`.env`)

## Como Executar

1. Clone este repositório:
```bash
git clone [https://github.com/SEU_USUARIO/fit-student-app.git](https://github.com/SEU_USUARIO/fit-student-app.git)

2. Navegue até o diretório do projeto

3. Execute os seguintes comandos: 

-cd fit-student-app
-flutter pub get
-flutter run 

## Supabase

SUPABASE_URL=sua_url_do_supabase_aqui
SUPABASE_ANON_KEY=sua_chave_anonima_aqui


## Estrutura do Projeto

lib/
├── features/
│   ├── app/                 # Configuração global (MaterialApp, Providers)
│   ├── home/                # Tela Principal e Perfil
│   ├── onboarding/          # Telas de Login, Cadastro e Termos de Uso
│   ├── providers/           # Gerenciamento de Estado e Lógica de Histórico
│   │   ├── domain/          # Regras de Negócio (Entidades)
│   │   ├── infrastructure/  # Conexão com Banco (DTOs, Remote Data Source)
│   │   └── presentation/    # Widgets visuais do histórico
│   └── splashscreen/        # Tela de carregamento inicial
├── services/
│   ├── env_service.dart     # Carregamento de variáveis de ambiente
│   └── supabase_service.dart# Inicialização do Supabase
└── main.dart                # Ponto de entrada

## Tecnologias Utilizadas

Flutter & Dart: Desenvolvimento Mobile

Supabase: Backend as a Service (Auth e Database)

Provider: Gerenciamento de Estado e Injeção de Dependência

Flutter Dotenv: Gerenciamento de variáveis de ambiente

## Próximos Passos

[ ] Implementar o Timer Pomodoro na Home

[ ] Criar a lista de exercícios de alongamento

[ ] Conectar o histórico visual com o banco de dados

[ ] Adicionar gráficos de desempenho no Perfil

Desenvolvido por Guilherme Henrique da Silva