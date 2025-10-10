# Instalação do Script de Criação React

## 📖 Visão Geral

Este script cria projetos React + TypeScript **completos do zero** usando Vite, seguindo os padrões do time. Ele automatiza todo o processo: criação do projeto, instalação de dependências, configuração de ferramentas e estruturação de pastas.

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
alias create-react-ts='bash /caminho/para/create-react-vite.sh'
```
**Uso:** `create-react-ts meu-projeto`

**Vantagens:**
- Claro e descritivo
- Indica tecnologia (React + TypeScript)
- Fácil de lembrar

---

### Opção 2: **`new-react`**
```bash
alias new-react='bash /caminho/para/create-react-vite.sh'
```
**Uso:** `new-react meu-projeto`

**Vantagens:**
- Curto e direto
- Semelhante a outros CLIs (new-app, new-project)

---

### Opção 3: **`react-init`**
```bash
alias react-init='bash /caminho/para/create-react-vite.sh'
```
**Uso:** `react-init meu-projeto`

**Vantagens:**
- Semanticamente claro (inicializar projeto React)
- Padrão comum (git init, npm init)

---

### Opção 4: **`scaffold-react`**
```bash
alias scaffold-react='bash /caminho/para/create-react-vite.sh'
```
**Uso:** `scaffold-react meu-projeto`

**Vantagens:**
- Termo técnico preciso
- Deixa claro que é scaffolding

---

## Instalação Passo a Passo

### 1. Download do Script

Baixe o arquivo [create-react-vite.sh](docs/ambiente/reactjs/assets/create-react-vite.sh) e salve em um diretório de sua preferência.

Sugestão de localização:
```bash
mkdir -p ~/.local/bin/team-scripts
curl -fsSL https://raw.githubusercontent.com/intellisys-informatica/devhub/main/docs/ambiente/reactjs/assets/create-react-vite.sh -o ~/.local/bin/team-scripts/create-react-vite.sh
chmod +x ~/.local/bin/team-scripts/create-react-vite.sh
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
# React + TypeScript Project Creator
alias create-react-ts='bash ~/.local/bin/team-scripts/create-react-vite.sh'
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
# React + TypeScript Project Creator
alias create-react-ts='bash ~/.local/bin/team-scripts/create-react-vite.sh'
```

Recarregue a configuração:
```bash
source ~/.zshrc
```

---

### 3. Verificar Instalação

Teste o comando:
```bash
create-react-ts
```

Se aparecer o banner do script solicitando o nome do projeto, está funcionando!

---

## Uso do Script

O script cria um **novo projeto completo** do zero:

```bash
# Criar novo projeto
create-react-ts meu-projeto

# Ou deixar o script solicitar o nome
create-react-ts
```

O script irá:
1. Criar projeto com `npm create vite@latest`
2. Instalar todas as dependências
3. Configurar Tailwind CSS v4 + shadcn/ui
4. Criar estrutura de pastas personalizada
5. Inicializar Git + Git Flow

---

## Estrutura Criada

O script cria a seguinte estrutura completa:

```
meu-projeto/
├── src/
│   ├── app/
│   │   ├── providers/
│   │   ├── routes/
│   │   └── styles/
│   ├── features/
│   │   └── home/
│   │       ├── components/
│   │       ├── hooks/
│   │       ├── types/
│   │       └── mappers/          # Transformação de dados
│   ├── shared/
│   │   ├── components/
│   │   │   ├── ui/              # shadcn/ui components
│   │   │   └── layout/
│   │   ├── lib/
│   │   │   └── axios.ts          # Axios configurado
│   │   ├── services/
│   │   │   └── api.ts            # API Service Layer
│   │   ├── types/
│   │   │   └── api.types.ts
│   │   └── mappers/
│   ├── vite-env.d.ts             # Env types
│   ├── App.tsx
│   ├── main.tsx
│   └── index.css
├── .env                          # Variáveis de ambiente
├── components.json               # shadcn/ui config
├── vite.config.ts                # Vite + Tailwind + path aliases
├── tsconfig.json                 # TypeScript config
├── package.json
├── .gitignore
└── .git/                         # Git Flow initialized
```

---

## O que o script faz

✅ **Cria projeto Vite** - `npm create vite@latest` com template react-ts
✅ **Instala dependências** - react-router-dom, react-hook-form, zod, axios
✅ **Configura Tailwind CSS v4** - Plugin Vite + configuração completa
✅ **Inicializa shadcn/ui** - `shadcn init` com configuração padrão
✅ **Path aliases** - Configura `@/*` no Vite e TypeScript
✅ **Estrutura de pastas** - Cria `app/`, `features/`, `shared/`, `mappers/`
✅ **Axios configurado** - Instância + service layer + interceptors
✅ **.env + tipagem** - Variáveis de ambiente com TypeScript
✅ **Git Flow** - Inicializa com branches `main` e `develop`
✅ **Arquivos de exemplo** - Cria componentes e types de exemplo

---

## Dependências Instaladas

O script instala automaticamente:

### Principais
- `react`, `react-dom`
- `react-router-dom` - Roteamento
- `react-hook-form` - Formulários
- `zod` - Validação
- `axios` - HTTP client

### Estilização
- `tailwindcss` - Framework CSS
- `@tailwindcss/vite` - Plugin Vite
- `shadcn/ui` - Componentes UI (inicializado)

### Dev Dependencies
- `typescript`
- `vite`
- `@vitejs/plugin-react`
- `@types/node` - Para path resolution

---

## Fluxo de Uso

```bash
# 1. Criar projeto completo
create-react-ts meu-projeto

# 2. Entrar no diretório
cd meu-projeto

# 3. Iniciar desenvolvimento
npm run dev

# 4. Adicionar componentes shadcn/ui conforme necessário
npx shadcn@latest add button
npx shadcn@latest add card
npx shadcn@latest add input
```

---

## Desinstalação

Para remover o script:

```bash
# Remover arquivo
rm ~/.local/bin/team-scripts/create-react-vite.sh

# Remover alias do .bashrc ou .zshrc
nano ~/.bashrc  # ou ~/.zshrc
# Deletar a linha do alias e salvar
source ~/.bashrc  # ou source ~/.zshrc
```

---

## Troubleshooting

### Erro: "Permission denied"
```bash
chmod +x ~/.local/bin/team-scripts/create-react-vite.sh
```

### Erro: "Command not found"
Verifique se o alias foi adicionado e o shell recarregado:
```bash
source ~/.bashrc  # ou source ~/.zshrc
```

### Erro: "Directory already exists"
O script não sobrescreve diretórios existentes. Use outro nome ou remova o diretório.

### Script não executa
Verifique se o caminho no alias está correto:
```bash
which create-react-ts
# Deve mostrar: alias create-react-ts='bash ~/.local/bin/team-scripts/create-react-vite.sh'
```

### Git Flow não instala
O script tenta instalar automaticamente, mas se falhar:
- **Ubuntu/Debian:** `sudo apt-get install git-flow`
- **macOS:** `brew install git-flow`
- **Outros:** https://github.com/nvie/gitflow/wiki/Installation

---

## Comparação com Método Manual

| Tarefa | Manual | Com Script |
|--------|--------|-----------|
| Criar projeto Vite | ✅ Manual | ✅ Automático |
| Instalar dependências | ✅ Manual (npm install x 6) | ✅ Automático |
| Configurar Tailwind | ✅ Manual | ✅ Automático |
| Configurar shadcn/ui | ✅ Manual | ✅ Automático |
| Estruturar pastas | ✅ Manual | ✅ Automático |
| Path aliases | ✅ Manual | ✅ Automático |
| Git Flow | ✅ Manual | ✅ Automático |
| **Tempo total** | ~15-20 min | ~3-5 min |

---

## Suporte

Para dúvidas ou problemas:
- Consulte a [documentação de setup](./setup.md)
- Consulte os [padrões React + TypeScript](../../padroes/typescript.md)
- Abra uma issue no repositório

---

**Última atualização:** 10/10/2025 16:25
