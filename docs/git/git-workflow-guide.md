# Guia de Trabalho em Equipe com Git Flow

## Introdução

Este guia define o fluxo de trabalho padrão da equipe de desenvolvimento da Intellisys para trabalhar com Git e GitHub em projetos existentes. Seguimos o modelo Git Flow, que organiza o desenvolvimento através de branches específicas para cada tipo de tarefa.

---

## Estrutura de Branches

### Branches Principais

- **`main`**: código em produção, sempre estável
- **`develop`**: branch de desenvolvimento, contém as últimas alterações aprovadas

### Branches de Trabalho

- **`feature/*`**: novas funcionalidades
- **`bugfix/*`**: correção de bugs identificados em desenvolvimento
- **`hotfix/*`**: correções urgentes em produção
- **`release/*`**: preparação para lançamento de nova versão

---

## Iniciando seu Trabalho

### 1. Certifique-se de estar atualizado

Antes de começar qualquer tarefa, atualize seu repositório local:

```bash
# Vá para a branch develop
git checkout develop

# Busque as últimas alterações do repositório remoto
git fetch origin

# Atualize sua branch local
git pull origin develop
```

### 2. Identifique o tipo de tarefa

Determine qual tipo de branch você precisa criar:

| Tipo de Tarefa | Branch Base | Nome da Branch |
|----------------|-------------|----------------|
| Nova funcionalidade | `develop` | `feature/nome-da-funcionalidade` |
| Correção de bug (dev) | `develop` | `bugfix/nome-do-bug` |
| Correção urgente (produção) | `main` | `hotfix/nome-da-correcao` |
| Preparar release | `develop` | `release/v1.2.0` |

### 3. Crie sua branch de trabalho

#### Para Features e Bugfixes:

```bash
# A partir da develop
git checkout develop
git pull origin develop
git checkout -b feature/implementar-login
```

#### Para Hotfixes:

```bash
# A partir da main
git checkout main
git pull origin main
git checkout -b hotfix/corrigir-erro-critico
```

#### Para Releases:

```bash
# A partir da develop
git checkout develop
git pull origin develop
git checkout -b release/v1.2.0
```

---

## Durante o Desenvolvimento

### Commits Frequentes e Descritivos

Faça commits regularmente com mensagens claras:

```bash
git add .
git commit -m "feat: adiciona validação de email no formulário de login"
```

#### Convenção de Mensagens de Commit

Use prefixos para categorizar seus commits:

- **feat**: nova funcionalidade
- **fix**: correção de bug
- **docs**: alterações em documentação
- **style**: formatação, ponto e vírgula faltando, etc
- **refactor**: refatoração de código
- **test**: adição ou correção de testes
- **chore**: tarefas de manutenção, build, etc

**Exemplos:**
```
feat: adiciona autenticação com JWT
fix: corrige erro ao salvar dados do usuário
docs: atualiza README com instruções de instalação
refactor: reorganiza estrutura de pastas do projeto
```

### Mantendo sua Branch Atualizada

Se sua tarefa demorar vários dias, mantenha sua branch atualizada com a `develop`:

```bash
# Salve seu trabalho atual
git add .
git commit -m "work in progress: implementando feature X"

# Atualize a develop local
git checkout develop
git pull origin develop

# Volte para sua branch
git checkout feature/sua-feature

# Integre as mudanças da develop
git merge develop

# Ou use rebase para manter histórico linear (avançado)
git rebase develop
```

### Enviando Alterações para o GitHub

Envie sua branch regularmente para o repositório remoto:

```bash
# Primeira vez
git push -u origin feature/sua-feature

# Próximas vezes
git push
```

---

## Encerrando seu Trabalho

### 1. Finalize e Teste

Antes de abrir o Pull Request:

- ✅ Teste todas as funcionalidades implementadas
- ✅ Certifique-se de que não há erros no console
- ✅ Verifique se o código segue os padrões da equipe
- ✅ Remova comentários desnecessários e código comentado
- ✅ Atualize a documentação se necessário

### 2. Atualize com a Branch Base

```bash
# Para features/bugfixes - atualizar com develop
git checkout develop
git pull origin develop
git checkout feature/sua-feature
git merge develop

# Resolva conflitos se houver
# Teste novamente após resolver conflitos

git push
```

### 3. Abra um Pull Request (PR)

#### No GitHub:

1. Acesse o repositório no GitHub
2. Clique em "Pull requests" → "New pull request"
3. Selecione:
   - **Base**: `develop` (para features/bugfixes) ou `main` (para hotfixes)
   - **Compare**: sua branch de trabalho
4. Preencha as informações:

**Título do PR:**
```
[Feature] Implementa autenticação de usuários
[Bugfix] Corrige erro ao salvar formulário
[Hotfix] Resolve problema crítico de segurança
```

**Descrição do PR:**
```markdown
## Descrição
Breve descrição do que foi implementado/corrigido.

## Tipo de mudança
- [ ] Nova funcionalidade
- [ ] Correção de bug
- [ ] Hotfix
- [ ] Refatoração
- [ ] Documentação

## Como testar
1. Acesse a página X
2. Clique no botão Y
3. Verifique que Z acontece

## Checklist
- [ ] Código testado localmente
- [ ] Código segue padrões da equipe
- [ ] Documentação atualizada (se aplicável)
- [ ] Sem conflitos com a branch base
```

5. Adicione **reviewers** (revisores) da equipe
6. Adicione **labels** apropriadas (feature, bug, hotfix, etc)
7. Clique em "Create pull request"

### 4. Revisão de Código

Aguarde a revisão dos colegas. Durante esse período:

- Responda comentários e dúvidas
- Faça ajustes solicitados
- Envie novos commits para a mesma branch (o PR atualiza automaticamente)

```bash
# Fazer ajustes solicitados
git add .
git commit -m "fix: ajusta validação conforme code review"
git push
```

### 5. Merge do Pull Request

Após aprovação dos revisores:

#### Opção A: Merge via GitHub (Recomendado)
1. No PR aprovado, clique em "Merge pull request"
2. Escolha o tipo de merge:
   - **Create a merge commit**: mantém todos os commits (padrão)
   - **Squash and merge**: combina todos os commits em um só (recomendado para features pequenas)
   - **Rebase and merge**: aplica commits linearmente
3. Confirme o merge

#### Opção B: Merge via linha de comando
```bash
# Atualizar develop
git checkout develop
git pull origin develop

# Fazer merge da sua branch
git merge --no-ff feature/sua-feature

# Enviar para o GitHub
git push origin develop
```

### 6. Limpeza Pós-Merge

Após o merge bem-sucedido:

```bash
# Volte para a develop
git checkout develop
git pull origin develop

# Delete a branch local
git branch -d feature/sua-feature

# Delete a branch remota (se não foi deletada automaticamente)
git push origin --delete feature/sua-feature
```

---

## Fluxos Específicos

### Feature Completa (Exemplo Prático)

```bash
# 1. Criar branch
git checkout develop
git pull origin develop
git checkout -b feature/cadastro-usuario

# 2. Desenvolver
# ... fazer alterações ...
git add .
git commit -m "feat: adiciona formulário de cadastro"
git push -u origin feature/cadastro-usuario

# 3. Mais desenvolvimento
# ... mais alterações ...
git add .
git commit -m "feat: adiciona validação de CPF"
git push

# 4. Finalizar
git checkout develop
git pull origin develop
git checkout feature/cadastro-usuario
git merge develop
git push

# 5. Abrir PR no GitHub
# ... criar pull request ...

# 6. Após aprovação e merge
git checkout develop
git pull origin develop
git branch -d feature/cadastro-usuario
```

### Hotfix Urgente (Exemplo Prático)

```bash
# 1. Criar branch da main
git checkout main
git pull origin main
git checkout -b hotfix/corrige-falha-pagamento

# 2. Corrigir problema
# ... fazer correção ...
git add .
git commit -m "fix: corrige erro no processamento de pagamento"
git push -u origin hotfix/corrige-falha-pagamento

# 3. Abrir PR para main
# ... criar pull request para main ...

# 4. Após merge na main, também aplicar na develop
git checkout develop
git pull origin develop
git merge main
git push origin develop

# 5. Limpar
git branch -d hotfix/corrige-falha-pagamento
```

---

## Boas Práticas

### ✅ Faça

- Mantenha branches pequenas e focadas em uma única tarefa
- Faça commits frequentes com mensagens descritivas
- Teste seu código antes de abrir PR
- Revise seu próprio código antes de solicitar revisão
- Responda rapidamente aos comentários de code review
- Mantenha sua branch atualizada com a base
- Delete branches após o merge

### ❌ Evite

- Trabalhar direto na `main` ou `develop`
- Commits com mensagens vagas ("ajustes", "fix", "wip")
- Abrir PRs sem testar o código
- Deixar PRs abertos por muito tempo
- Fazer merge sem aprovação
- Acumular muitas alterações em um único commit
- Commitar código comentado ou console.logs de debug

---

*Última atualização: Outubro 2025*