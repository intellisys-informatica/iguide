# Regras de Commits

Guia completo sobre como escrever commits seguindo o padrão Conventional Commits.

## Por que commits bem escritos importam?

- ✅ Histórico legível e organizado
- ✅ Geração automática de changelogs
- ✅ Facilita code review
- ✅ Ajuda a entender mudanças no futuro

## Conventional Commits

O padrão Conventional Commits define uma estrutura clara para mensagens de commit.

### Estrutura Básica

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Exemplo Completo

```
feat(auth): add login with Google OAuth

Implements Google OAuth 2.0 authentication flow.
Users can now sign in using their Google accounts.

Closes #123
```

## Types (Tipos)

### Principais tipos

| Tipo | Descrição | Exemplo |
|------|-----------|---------|
| `feat` | Nova funcionalidade | `feat: add user registration` |
| `fix` | Correção de bug | `fix: resolve login error` |
| `docs` | Documentação | `docs: update README` |
| `style` | Formatação (sem mudança de código) | `style: format with prettier` |
| `refactor` | Refatoração | `refactor: simplify auth logic` |
| `test` | Adicionar/modificar testes | `test: add unit tests for auth` |
| `chore` | Tarefas de manutenção | `chore: update dependencies` |
| `perf` | Melhorias de performance | `perf: optimize image loading` |

### Tipos adicionais

- `build` - Mudanças no sistema de build
- `ci` - Mudanças em CI/CD
- `revert` - Reverter commit anterior

## Scope (Escopo)

O escopo especifica qual parte do código foi afetada.

### Exemplos de escopos

```
feat(auth): add JWT validation
fix(ui): correct button alignment
docs(api): update endpoint documentation
refactor(database): optimize queries
```

### Escopos comuns

- `auth` - Autenticação
- `ui` - Interface do usuário
- `api` - API/Backend
- `database` - Banco de dados
- `config` - Configurações
- `tests` - Testes

## Subject (Assunto)

O assunto deve ser:

- ✅ Curto (máximo 50 caracteres)
- ✅ Imperativo ("add" não "added")
- ✅ Sem ponto final
- ✅ Começar com letra minúscula

### ✅ Bons exemplos

```
feat: add password reset functionality
fix: resolve null pointer exception
docs: update installation guide
```

### ❌ Exemplos ruins

```
feat: Added password reset functionality.  # imperativo errado + ponto
fix: Fixed stuff  # muito vago
FIX: RESOLVE BUG  # maiúsculas
```

## Body (Corpo)

O corpo é **opcional** mas recomendado para mudanças complexas.

### O que incluir

- Por que a mudança foi feita?
- Qual era o problema?
- Como foi resolvido?

### Exemplo

```
fix(auth): prevent duplicate user registration

Users were able to register multiple times with the same email
due to a race condition in the validation logic.

Added a unique constraint at the database level and improved
the validation flow to check for existing users before processing
the registration.
```

## Footer (Rodapé)

Use o rodapé para:

### 1. Referenciar issues

```
Closes #123
Fixes #456
Relates to #789
```

### 2. Breaking changes

```
BREAKING CHANGE: API endpoint /users now requires authentication
```

### Exemplo completo com breaking change

```
feat(api): require authentication for user endpoints

All user-related endpoints now require a valid JWT token.

BREAKING CHANGE: /users, /users/:id endpoints now return 401
if no authentication token is provided. Update your API calls
to include the Authorization header.

Closes #234
```

## Commits Especiais

### Revert

Quando reverter um commit anterior:

```
revert: feat(auth): add login with Google

This reverts commit 1234567.

Reason: Google OAuth integration caused performance issues.
```

### Merge

Evite commits de merge desnecessários usando `git rebase`:

```bash
# Ao invés de
git merge feature-branch

# Prefira
git rebase main
```

## Regras de Ouro

### ✅ FAÇA

- Use commits atômicos (uma mudança por vez)
- Escreva mensagens claras e descritivas
- Use o imperativo ("add" não "added")
- Referencie issues quando relevante
- Mantenha o subject em 50 caracteres ou menos

### ❌ NÃO FAÇA

- Commits genéricos: "fix bugs", "update code"
- Misturar múltiplas mudanças em um commit
- Commitar código que não funciona
- Usar pontos finais no subject
- Escrever em primeira pessoa: "I added..."

## Exemplos Práticos

### Nova funcionalidade

```
feat(dashboard): add user activity chart

Implements a line chart showing user activity over the last 30 days.
Uses Chart.js for visualization.

Closes #145
```

### Correção de bug

```
fix(cart): calculate correct total with discounts

The shopping cart was not applying discount codes correctly
when multiple items were present.

Fixes #289
```

### Refatoração

```
refactor(api): extract validation logic to middleware

Moved all input validation from controllers to dedicated
middleware functions for better code organization and reusability.
```

### Documentação

```
docs(readme): add troubleshooting section

Added common issues and solutions based on user feedback.
```

### Performance

```
perf(images): implement lazy loading

Reduces initial page load time by ~40% by deferring
off-screen image loading.

Closes #178
```

## Ferramentas

### Commitizen

Assistente interativo para criar commits:

```bash
# Instalação
npm install -g commitizen

# Uso
git cz
```

### Commitlint

Validar mensagens de commit:

```bash
# Instalação
npm install --save-dev @commitlint/{config-conventional,cli}

# Configuração (.commitlintrc.json)
{
  "extends": ["@commitlint/config-conventional"]
}
```

### Husky Hook

Validar commits antes de enviar:

```bash
# package.json
{
  "husky": {
    "hooks": {
      "commit-msg": "commitlint -E HUSKY_GIT_PARAMS"
    }
  }
}
```

## Template de Commit

Crie um template para facilitar:

```bash
# ~/.gitmessage.txt
<type>(<scope>): <subject>

# Body: Por que essa mudança foi necessária?

# Footer
# - Closes #issue
# - BREAKING CHANGE: descrição
```

Configure o Git para usar o template:

```bash
git config --global commit.template ~/.gitmessage.txt
```

## Checklist de Commit

Antes de fazer commit, verifique:

- [ ] O commit faz apenas uma coisa?
- [ ] A mensagem descreve claramente a mudança?
- [ ] Segue o formato `<type>(<scope>): <subject>`?
- [ ] O código foi testado?
- [ ] Não há código comentado ou console.logs desnecessários?
- [ ] A build não está quebrada?

## Recursos Adicionais

- [Conventional Commits Spec](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)
- [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/)
