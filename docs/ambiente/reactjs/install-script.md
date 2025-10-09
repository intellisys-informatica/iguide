# Instalação Manual do Script de Estruturação React

## 📖 Visão Geral

Este script cria a estrutura de pastas `src/` para projetos React seguindo os padrões do time. Ele **não** cria `package.json` nem instala dependências - apenas organiza a estrutura de diretórios, configura o Git Flow e cria os arquivos essenciais.

## 🚀 Instalação Automática (Recomendado)

Use o instalador automático que configura tudo:

### Bash
```bash
curl -fsSL https://raw.githubusercontent.com/intellisys-informatica/devhub/main/docs/ambiente/reactjs/assets/install.sh | bash
```

### Zsh
```bash
curl -fsSL https://raw.githubusercontent.com/intellisys-informatica/devhub/main/docs/ambiente/reactjs/assets/install.sh | zsh
```

### Download Local do Instalador
```bash
# Baixar
curl -fsSL https://raw.githubusercontent.com/intellisys-informatica/devhub/main/docs/ambiente/reactjs/assets/install.sh -o install.sh

# Executar
chmod +x install.sh
./install.sh
```

O instalador irá:
1. ✅ Detectar automaticamente seu shell
2. ✅ Localizar o arquivo de configuração correto
3. ✅ Permitir escolher o nome do alias
4. ✅ Instalar o script em `~/.local/bin/team-scripts/`
5. ✅ Configurar o alias automaticamente
6. ✅ Recarregar o shell (opcional)

---

## 📖 Instalação Manual

Se preferir instalar manualmente, siga os passos abaixo.

## Sugestões de Nomes para Alias

Escolha um dos nomes abaixo para adicionar ao seu `.bashrc` ou `.zshrc`:

### Opção 1: **`create-react-ts`** (Recomendado)
```bash
alias create-react-ts='bash /caminho/para/create-react-project.sh'
```
**Uso:** `create-react-ts meu-projeto`

**Vantagens:**
- Claro e descritivo
- Indica tecnologia (React + TypeScript)
- Fácil de lembrar

---

### Opção 2: **`new-react`**
```bash
alias new-react='bash /caminho/para/create-react-project.sh'
```
**Uso:** `new-react meu-projeto`

**Vantagens:**
- Curto e direto
- Semelhante a outros CLIs (new-app, new-project)

---

### Opção 3: **`react-init`**
```bash
alias react-init='bash /caminho/para/create-react-project.sh'
```
**Uso:** `react-init meu-projeto`

**Vantagens:**
- Semanticamente claro (inicializar projeto React)
- Padrão comum (git init, npm init)

---

### Opção 4: **`scaffold-react`**
```bash
alias scaffold-react='bash /caminho/para/create-react-project.sh'
```
**Uso:** `scaffold-react meu-projeto`

**Vantagens:**
- Termo técnico preciso
- Deixa claro que é scaffolding

---

## Instalação Passo a Passo

### 1. Download do Script

Baixe o arquivo [create-react-project.sh](./create-react-project.sh) e salve em um diretório de sua preferência.

Sugestão de localização:
```bash
mkdir -p ~/.local/bin/team-scripts
mv create-react-project.sh ~/.local/bin/team-scripts/
chmod +x ~/.local/bin/team-scripts/create-react-project.sh
```

---

### 2. Adicionar Alias ao Shell

#### Para Bash (`~/.bashrc`)

Abra o arquivo:
```bash
nano ~/.bashrc
```

Adicione no final do arquivo:
```bash
# React + TypeScript Project Scaffolding
alias create-react-ts='bash ~/.local/bin/team-scripts/create-react-project.sh'
```

Recarregue a configuração:
```bash
source ~/.bashrc
```

---

#### Para Zsh (`~/.zshrc`)

Abra o arquivo:
```bash
nano ~/.zshrc
```

Adicione no final do arquivo:
```bash
# React + TypeScript Project Scaffolding
alias create-react-ts='bash ~/.local/bin/team-scripts/create-react-project.sh'
```

Recarregue a configuração:
```bash
source ~/.zshrc
```

---

### 3. Verificar Instalação

Teste o comando:
```bash
create-react-ts --help
```

Se aparecer a mensagem de uso, está funcionando!

---

## Uso do Script

O script deve ser executado **na raiz de um projeto React existente** ou em um diretório vazio:

```bash
# Em um projeto React existente (com package.json)
cd meu-projeto-react
create-react-ts

# OU em um diretório vazio
mkdir meu-novo-projeto
cd meu-novo-projeto
create-react-ts
```

---

## Estrutura Criada

O script cria a seguinte estrutura:

```
.
├── src/
│   ├── app/
│   │   ├── providers/
│   │   ├── routes/
│   │   │   └── index.tsx
│   │   └── styles/
│   │       └── index.css
│   ├── features/
│   │   └── students/
│   │       ├── components/
│   │       ├── hooks/
│   │       ├── types/
│   │       │   └── student.types.ts
│   │       └── index.tsx
│   ├── shared/
│   │   ├── components/
│   │   │   ├── ui/
│   │   │   └── layout/
│   │   ├── lib/
│   │   │   └── utils.ts
│   │   ├── services/
│   │   │   └── api/
│   │   │       └── client.ts
│   │   └── types/
│   ├── App.tsx
│   ├── main.tsx
│   └── vite-env.d.ts
├── vite.config.ts (criado/atualizado)
├── .gitignore (criado se não existir)
└── .git/ (Git Flow inicializado)
```

---

## O que o script faz

✅ **Estrutura de pastas** - Cria `src/` com `app/`, `features/`, `shared/`
✅ **Vite config** - Configura path aliases (`@/`, `@app/`, `@features/`, `@shared/`)
✅ **Git Flow** - Inicializa Git Flow com branches `main` e `develop`
✅ **.gitignore** - Cria se não existir
✅ **Arquivos fonte** - Cria arquivos TypeScript de exemplo

## O que o script NÃO faz

❌ **Não cria package.json** - Use `npm create vite@latest` antes
❌ **Não instala dependências** - Execute `npm install` após o script
❌ **Não cria arquivos de config** do projeto (ESLint, Tailwind, etc.)

## Fluxo recomendado

1. Criar projeto com Vite:
```bash
npm create vite@latest meu-projeto -- --template react-ts
cd meu-projeto
```

2. Executar script de estruturação:
```bash
create-react-ts
```

3. Instalar dependências adicionais:
```bash
npm install react-router-dom react-hook-form zod axios
```

4. Iniciar desenvolvimento:
```bash
npm run dev
```

---

## Desinstalação

Para remover o script:

```bash
# Remover arquivo
rm ~/.local/bin/team-scripts/create-react-project.sh

# Remover alias do .bashrc ou .zshrc
nano ~/.bashrc  # ou ~/.zshrc
# Deletar a linha do alias e salvar
source ~/.bashrc  # ou source ~/.zshrc
```

---

## Troubleshooting

### Erro: "Permission denied"
```bash
chmod +x ~/.local/bin/team-scripts/create-react-project.sh
```

### Erro: "Command not found"
Verifique se o alias foi adicionado e o shell recarregado:
```bash
source ~/.bashrc  # ou source ~/.zshrc
```

### Script não executa
Verifique se o caminho no alias está correto:
```bash
which create-react-ts
```

---

## Suporte

Para dúvidas ou problemas, consulte a documentação completa em [REACT_STANDARDS.md](../REACT_STANDARDS.md).
