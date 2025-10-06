# Setup Inicial

Guia completo para configurar o ambiente de desenvolvimento do zero.

## Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- **Node.js** (v18 ou superior)
- **Git** (v2.30 ou superior)
- **Editor de código** (VSCode recomendado)

## Instalação do Node.js

### Windows

1. Acesse o site oficial: [nodejs.org](https://nodejs.org)
2. Baixe a versão LTS (Long Term Support)
3. Execute o instalador e siga as instruções

### macOS

```bash
# Usando Homebrew
brew install node
```

### Linux (Ubuntu/Debian)

```bash
# Atualizar repositórios
sudo apt update

# Instalar Node.js e npm
sudo apt install nodejs npm

# Verificar instalação
node --version
npm --version
```

## Instalação do Git

### Windows

1. Baixe o instalador em [git-scm.com](https://git-scm.com)
2. Execute e mantenha as opções padrão
3. Verifique a instalação:

```bash
git --version
```

### macOS/Linux

```bash
# macOS
brew install git

# Ubuntu/Debian
sudo apt install git
```

## Configuração do Git

Configure suas credenciais globais:

```bash
# Nome de usuário
git config --global user.name "Seu Nome"

# Email
git config --global user.email "seu.email@exemplo.com"

# Editor padrão (VSCode)
git config --global core.editor "code --wait"

# Verificar configurações
git config --list
```

## VSCode - Instalação e Configuração

### Instalação

1. Acesse [code.visualstudio.com](https://code.visualstudio.com)
2. Baixe e instale a versão para seu sistema operacional

### Extensões Recomendadas

Instale as extensões essenciais:

- **ESLint** - Linting para JavaScript/TypeScript
- **Prettier** - Formatação de código
- **GitLens** - Visualização avançada do Git
- **Auto Rename Tag** - Renomear tags HTML automaticamente
- **Path Intellisense** - Autocompletar caminhos de arquivos
- **Error Lens** - Visualizar erros inline

```bash
# Instalar todas de uma vez via CLI
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension eamodio.gitlens
code --install-extension formulahendry.auto-rename-tag
code --install-extension christian-kohler.path-intellisense
code --install-extension usernamehololens.error-lens
```

## Clonando o Repositório

```bash
# Clone o repositório do projeto
git clone https://github.com/seu-usuario/seu-projeto.git

# Entre no diretório
cd seu-projeto

# Instale as dependências
npm install
```

## Variáveis de Ambiente

Crie um arquivo `.env` na raiz do projeto:

```env
# Ambiente
NODE_ENV=development

# API Keys (exemplos)
API_KEY=sua-chave-aqui
DATABASE_URL=postgresql://user:password@localhost:5432/dbname
```

> [!WARNING]
> Nunca commite o arquivo `.env` no Git. Certifique-se de que ele está no `.gitignore`.

## Verificando a Instalação

Execute os comandos abaixo para verificar se tudo está funcionando:

```bash
# Verificar versões
node --version
npm --version
git --version

# Rodar o projeto (se aplicável)
npm run dev
```

## Próximos Passos

- ✅ Ambiente configurado com sucesso
- 📚 Leia sobre [Ferramentas Essenciais](#)
- 📝 Confira os [Padrões de Código](#)
- 🔀 Entenda as [Regras de Commits](#)

## Problemas Comuns

### Erro: "npm command not found"

Reinicie o terminal após instalar o Node.js ou adicione o npm ao PATH do sistema.

### Erro: "Permission denied" no Linux/macOS

Use `sudo` antes do comando ou configure as permissões corretas:

```bash
sudo chown -R $USER:$USER ~/.npm
```

### Git não reconhece credenciais

Configure o credential helper:

```bash
# Windows
git config --global credential.helper wincred

# macOS
git config --global credential.helper osxkeychain

# Linux
git config --global credential.helper cache
```

## Recursos Adicionais

- [Documentação oficial do Node.js](https://nodejs.org/docs)
- [Documentação oficial do Git](https://git-scm.com/doc)
- [VSCode Tips and Tricks](https://code.visualstudio.com/docs/getstarted/tips-and-tricks)
