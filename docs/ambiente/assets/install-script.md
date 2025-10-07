# Instalação do Script de Scaffolding

## 🚀 Instalação Automática (Recomendado)

A forma mais rápida de instalar é usando o instalador automático:

### Bash
```bash
curl -fsSL https://raw.githubusercontent.com/seu-org/seu-repo/main/assets/install.sh | bash
```

### Zsh
```bash
curl -fsSL https://raw.githubusercontent.com/seu-org/seu-repo/main/assets/install.sh | zsh
```

### Download Local do Instalador
```bash
# Baixar
curl -fsSL https://raw.githubusercontent.com/seu-org/seu-repo/main/assets/install.sh -o install.sh

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

### Criar novo projeto
```bash
create-react-ts meu-projeto
```

### Criar projeto sem instalar dependências
```bash
create-react-ts meu-projeto --skip-install
```

---

## Estrutura Criada

O script cria a seguinte estrutura:

```
meu-projeto/
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
├── public/
├── .env.example
├── .eslintrc.cjs
├── .gitignore
├── index.html
├── package.json
├── postcss.config.js
├── README.md
├── tailwind.config.js
├── tsconfig.json
├── tsconfig.node.json
└── vite.config.ts
```

---

## Configurações Incluídas

✅ **TypeScript** - Strict mode ativado
✅ **Vite** - Build tool rápido
✅ **React 18** - Versão mais recente
✅ **React Router** - Navegação
✅ **React Hook Form** - Gerenciamento de formulários
✅ **Zod** - Validação de schemas
✅ **Axios** - Cliente HTTP
✅ **Tailwind CSS** - Estilização
✅ **ESLint** - Linting
✅ **Path Aliases** - `@/`, `@app/`, `@features/`, `@shared/`
✅ **Git** - Repositório inicializado

---

## Comandos Disponíveis

Após criar o projeto:

```bash
cd meu-projeto

# Desenvolvimento
npm run dev

# Build de produção
npm run build

# Linting
npm run lint

# Preview da build
npm run preview
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
