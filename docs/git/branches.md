# Estratégia de Branches

Guia sobre organização e nomenclatura de branches no Git.

## Git Flow

Utilizamos uma estratégia baseada no Git Flow com algumas adaptações.

### Branches Principais

#### `main` (ou `master`)

- **Propósito:** Código em produção
- **Proteção:** Branch protegida, não aceita commits diretos
- **Deploy:** Automaticamente deployado em produção

```bash
# NUNCA faça commits diretos em main
git checkout main  # ❌ Evite trabalhar direto aqui
```

#### `develop`

- **Propósito:** Branch de integração para desenvolvimento
- **Proteção:** Branch protegida, aceita apenas PRs
- **Deploy:** Automaticamente deployado em staging/homologação

```bash
# Criar branch de feature a partir de develop
git checkout develop
git pull origin develop
git checkout -b feature/nome-da-feature
```

### Branches Temporárias

#### Feature Branches

**Formato:** `feature/descricao-curta`

**Propósito:** Desenvolver novas funcionalidades

**Ciclo de vida:**
1. Criada a partir de `develop`
2. Desenvolvida e testada
3. Merged de volta para `develop` via PR
4. Deletada após merge

```bash
# Criar feature branch
git checkout develop
git pull origin develop
git checkout -b feature/user-authentication

# Trabalhar na feature
git add .
git commit -m "feat(auth): add login endpoint"

# Push para remote
git push origin feature/user-authentication

# Após merge, deletar branch
git branch -d feature/user-authentication
```

**Exemplos:**
```
feature/add-payment-gateway
feature/user-profile-page
feature/dark-mode
```

#### Bugfix Branches

**Formato:** `bugfix/descricao-do-bug`

**Propósito:** Corrigir bugs encontrados em `develop`

```bash
git checkout develop
git checkout -b bugfix/fix-login-redirect

# Fix the bug
git commit -m "fix(auth): correct redirect after login"

# Push and create PR
git push origin bugfix/fix-login-redirect
```

**Exemplos:**
```
bugfix/fix-cart-calculation
bugfix/resolve-memory-leak
bugfix/correct-date-format
```

#### Hotfix Branches

**Formato:** `hotfix/descricao-urgente`

**Propósito:** Corrigir bugs **críticos em produção**

**Diferença:** Criada a partir de `main` e merged tanto em `main` quanto `develop`

```bash
# Criar hotfix a partir de main
git checkout main
git pull origin main
git checkout -b hotfix/critical-security-fix

# Fazer a correção
git commit -m "fix(security): patch XSS vulnerability"

# Merge em main
git checkout main
git merge hotfix/critical-security-fix
git push origin main

# Merge em develop também
git checkout develop
git merge hotfix/critical-security-fix
git push origin develop

# Deletar branch
git branch -d hotfix/critical-security-fix
```

**Exemplos:**
```
hotfix/fix-payment-failure
hotfix/patch-security-vulnerability
hotfix/restore-broken-api
```

#### Release Branches

**Formato:** `release/vX.Y.Z`

**Propósito:** Preparar uma nova versão para produção

```bash
# Criar release branch
git checkout develop
git checkout -b release/v1.2.0

# Ajustes finais (versão, changelog, etc.)
npm version 1.2.0
git commit -m "chore(release): bump version to 1.2.0"

# Merge em main
git checkout main
git merge release/v1.2.0
git tag v1.2.0
git push origin main --tags

# Merge em develop
git checkout develop
git merge release/v1.2.0
git push origin develop

# Deletar branch
git branch -d release/v1.2.0
```

## Nomenclatura de Branches

### Regras Gerais

- ✅ Use kebab-case (palavras separadas por hífen)
- ✅ Seja descritivo mas conciso
- ✅ Use inglês
- ✅ Evite números de issues na branch (use no commit)

### ✅ Bons exemplos

```
feature/add-user-authentication
feature/implement-payment-flow
bugfix/fix-cart-total-calculation
bugfix/resolve-mobile-menu-issue
hotfix/patch-critical-security-bug
release/v2.0.0
```

### ❌ Exemplos ruins

```
feature/123  # Não descritivo
fix-bug  # Falta prefixo
Feature/AddUserAuth  # Capitalização errada
my-feature  # Muito genérico
feature_new_thing  # Underscore ao invés de hífen
```

## Prefixos Adicionais

Além dos principais, você pode usar:

| Prefixo | Propósito | Exemplo |
|---------|-----------|---------|
| `chore/` | Tarefas de manutenção | `chore/update-dependencies` |
| `docs/` | Documentação | `docs/update-api-documentation` |
| `refactor/` | Refatoração | `refactor/simplify-auth-logic` |
| `test/` | Adicionar testes | `test/add-unit-tests-for-api` |
| `perf/` | Melhorias de performance | `perf/optimize-database-queries` |
| `style/` | Formatação de código | `style/apply-prettier-formatting` |

## Workflow Completo

### 1. Começar uma nova feature

```bash
# Atualizar develop
git checkout develop
git pull origin develop

# Criar feature branch
git checkout -b feature/add-notifications

# Trabalhar na feature (commits frequentes)
git add .
git commit -m "feat(notifications): add email notification service"

# Push regularmente
git push origin feature/add-notifications
```

### 2. Criar Pull Request

1. Push da branch para o remote
2. Abrir PR no GitHub/GitLab
3. Descrever mudanças e adicionar screenshots
4. Solicitar review
5. Resolver comentários

### 3. Após merge

```bash
# Voltar para develop
git checkout develop
git pull origin develop

# Deletar branch local
git branch -d feature/add-notifications

# Deletar branch remota (se não foi automático)
git push origin --delete feature/add-notifications
```

## Proteção de Branches

### Configurações recomendadas para `main` e `develop`

- ✅ Require pull request reviews (mínimo 1)
- ✅ Require status checks to pass
- ✅ Require conversation resolution before merging
- ✅ Do not allow bypassing the above settings
- ✅ Restrict who can push to matching branches

### Como configurar no GitHub

1. Settings → Branches
2. Add branch protection rule
3. Branch name pattern: `main` ou `develop`
4. Configurar regras acima

## Limpeza de Branches

### Deletar branches já merged localmente

```bash
# Listar branches merged
git branch --merged

# Deletar branches merged (exceto main/develop)
git branch --merged | grep -v "\*\|main\|develop" | xargs -n 1 git branch -d
```

### Deletar branches remotas obsoletas

```bash
# Ver branches remotas
git branch -r

# Limpar referências de branches remotas deletadas
git fetch --prune

# Deletar branch remota específica
git push origin --delete feature/old-feature
```

## Resolução de Conflitos

### Durante rebase

```bash
# Atualizar feature branch com develop
git checkout feature/my-feature
git rebase develop

# Se houver conflitos
# 1. Resolver conflitos manualmente
# 2. Adicionar arquivos resolvidos
git add .

# 3. Continuar rebase
git rebase --continue

# Ou abortar se necessário
git rebase --abort
```

### Durante merge

```bash
# Se houver conflitos durante merge
# 1. Resolver conflitos manualmente
# 2. Adicionar arquivos resolvidos
git add .

# 3. Commitar o merge
git commit -m "merge: resolve conflicts from develop"
```

## Boas Práticas

### ✅ FAÇA

- Mantenha branches de vida curta (máximo 1-2 semanas)
- Faça commits frequentes e atômicos
- Atualize sua branch com develop regularmente
- Delete branches após merge
- Use nomes descritivos
- Crie PR cedo (pode ser draft)

### ❌ NÃO FAÇA

- Deixar branches abertas por muito tempo
- Trabalhar direto em main/develop
- Criar branches com nomes genéricos
- Commitar código que quebra a build
- Fazer force push em branches compartilhadas

## Comandos Úteis

```bash
# Ver todas as branches
git branch -a

# Ver branches remotas
git branch -r

# Ver última atividade em cada branch
git for-each-ref --sort=-committerdate refs/heads/

# Trocar de branch
git checkout nome-da-branch

# Criar e trocar para nova branch
git checkout -b nova-branch

# Atualizar lista de branches remotas
git fetch --prune

# Comparar branches
git diff branch1..branch2

# Ver commits de uma branch que não estão em outra
git log develop..feature/my-feature
```

## Fluxograma

```
main (produção)
  ↓
  └─ hotfix/fix-critical-bug ──→ merge ──→ main + develop

develop (staging)
  ↓
  ├─ feature/add-user-auth ──→ PR ──→ develop
  ├─ feature/payment-flow ────→ PR ──→ develop
  ├─ bugfix/fix-login ────────→ PR ──→ develop
  └─ release/v1.2.0 ──────────→ PR ──→ main + develop
```

## Recursos Adicionais

- [Git Flow Cheatsheet](https://danielkummer.github.io/git-flow-cheatsheet/)
- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [GitLab Flow](https://docs.gitlab.com/ee/topics/gitlab_flow.html)
