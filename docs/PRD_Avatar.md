# PRD: Avatar com Foto no Drawer

## 1. Descrição da Funcionalidade
Permitir que o estudante personalize seu perfil adicionando uma foto via câmera ou galeria. Essa foto deve aparecer no Menu Lateral (Drawer) e na tela de Perfil. Caso o usuário não tenha foto, o sistema deve exibir automaticamente as iniciais do nome (Fallback).

## 2. Requisitos Funcionais
- [x] O usuário pode selecionar uma imagem da **Galeria** ou tirar uma **Foto**.
- [x] A imagem deve ser **comprimida** antes de salvar para economizar espaço.
- [x] Metadados (como localização GPS/EXIF) devem ser removidos por segurança.
- [x] A imagem deve ser persistida **localmente** (no dispositivo) para carregar offline.
- [x] Se não houver imagem, exibir um círculo com as **iniciais do nome** (ex: "Guilherme Silva" -> "GS").

## 3. Requisitos Não-Funcionais (Qualidade)
- **Acessibilidade:** Os botões devem ter tamanho mínimo de 48x48dp e etiquetas semânticas (ex: "Alterar foto de perfil").
- **Performance:** O carregamento da imagem deve ser instantâneo (cache local).
- **Privacidade:** A imagem não deve ser enviada para o servidor sem consentimento (nesta fase, apenas local).

## 4. Casos de Uso (Fluxo)
1. Usuário abre o Drawer (Menu Lateral).
2. Clica no ícone de câmera sobre o avatar.
3. Escolhe "Galeria" ou "Câmera".
4. A foto é processada (comprimida e limpa).
5. A interface atualiza imediatamente mostrando a nova foto.

## 5. Critérios de Aceite (Checklist da Atividade)
- [ ] Fallback automático (Foto -> Iniciais).
- [ ] Persistência Local implementada.
- [ ] Compressão de imagem funcionando.
- [ ] Testes de Widget e Unitários criados.