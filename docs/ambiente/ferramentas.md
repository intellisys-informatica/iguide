# Ferramentas Essenciais

Lista de ferramentas necessárias e recomendadas para o desenvolvimento eficiente.

## Essenciais

### 1. Node.js & npm

**O que é:** Runtime JavaScript e gerenciador de pacotes.

**Por que usar:** Executa JavaScript fora do navegador e gerencia dependências.

**Instalação:** Veja o guia de [Setup Inicial](#)

```bash
# Verificar versão
node --version
npm --version
```

### 2. Git

**O que é:** Sistema de controle de versão distribuído.

**Por que usar:** Rastrear mudanças no código e colaborar com a equipe.

```bash
# Comandos essenciais
git status
git add .
git commit -m "mensagem"
git push
git pull
```

### 3. VSCode

**O que é:** Editor de código da Microsoft.

**Por que usar:** Leve, rápido, extensível e com ótima integração com Git.

**Download:** [code.visualstudio.com](https://code.visualstudio.com)

## Ferramentas de Qualidade de Código

### ESLint

**O que é:** Linter para JavaScript/TypeScript.

**Instalação:**

```bash
npm install --save-dev eslint
npx eslint --init
```

**Uso:**

```bash
# Rodar linter
npm run lint

# Corrigir automaticamente
npm run lint:fix
```

### Prettier

**O que é:** Formatador de código opinionado.

**Instalação:**

```bash
npm install --save-dev prettier
```

**Configuração básica (`.prettierrc`):**

```json
{
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "es5"
}
```

### Husky + lint-staged

**O que é:** Git hooks para rodar scripts antes do commit.

**Instalação:**

```bash
npm install --save-dev husky lint-staged
npx husky install
```

**Configuração (`package.json`):**

```json
{
  "lint-staged": {
    "*.{js,ts,jsx,tsx}": ["eslint --fix", "prettier --write"],
    "*.{css,scss,md}": ["prettier --write"]
  }
}
```

## Ferramentas de Terminal

### 1. Oh My Zsh (macOS/Linux)

**O que é:** Framework para gerenciar configuração do Zsh.

**Instalação:**

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 2. Windows Terminal (Windows)

**Download:** Microsoft Store

**Recursos:** Múltiplas abas, perfis customizáveis, suporte a emojis.

### 3. Git Bash (Windows)

**O que é:** Emulador de terminal Unix para Windows.

**Vem com:** Instalação do Git para Windows.

## Gerenciadores de Pacotes Alternativos

### Yarn

**Vantagens:** Mais rápido que npm, lock file determinístico.

```bash
# Instalação
npm install -g yarn

# Uso
yarn install
yarn add pacote
yarn remove pacote
```

### pnpm

**Vantagens:** Economiza espaço em disco, instalação mais rápida.

```bash
# Instalação
npm install -g pnpm

# Uso
pnpm install
pnpm add pacote
```

## Ferramentas de Debugging

### Chrome DevTools

**Acesso:** F12 no Google Chrome

**Recursos essenciais:**
- Console para logs
- Network para requisições
- Sources para debugging
- Performance para análise

### Node.js Debugger

**Uso no VSCode:**

1. Adicione breakpoints no código
2. Pressione F5
3. Selecione "Node.js"

**launch.json:**

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Debug",
      "program": "${workspaceFolder}/index.js"
    }
  ]
}
```

## Ferramentas de Teste

### Jest

**O que é:** Framework de testes para JavaScript.

```bash
npm install --save-dev jest
```

**Exemplo de teste:**

```javascript
// sum.test.js
const sum = (a, b) => a + b;

test('soma 1 + 2 igual a 3', () => {
  expect(sum(1, 2)).toBe(3);
});
```

## Ferramentas de Documentação

### JSDoc

**O que é:** Gerador de documentação a partir de comentários.

```javascript
/**
 * Soma dois números
 * @param {number} a - Primeiro número
 * @param {number} b - Segundo número
 * @returns {number} Resultado da soma
 */
function sum(a, b) {
  return a + b;
}
```

## Ferramentas de Colaboração

### 1. GitHub Desktop

**O que é:** Cliente visual do Git.

**Download:** [desktop.github.com](https://desktop.github.com)

### 2. Postman

**O que é:** Plataforma para testar APIs.

**Download:** [postman.com](https://www.postman.com)

### 3. Notion / Confluence

**O que é:** Ferramentas de documentação e organização de equipe.

## Extensões do VSCode Recomendadas

### Produtividade

- **Auto Rename Tag** - Renomeia tags automaticamente
- **Path Intellisense** - Autocomplete de caminhos
- **Bookmarks** - Marcar linhas importantes
- **TODO Highlight** - Destacar comentários TODO

### UI/UX

- **Bracket Pair Colorizer** - Colorir parênteses/colchetes
- **Indent Rainbow** - Colorir indentação
- **Material Icon Theme** - Ícones para arquivos

### Git

- **GitLens** - Superpoderes do Git
- **Git Graph** - Visualizar histórico do Git

## Checklist de Ferramentas

Marque as ferramentas que você já instalou:

- [ ] Node.js & npm
- [ ] Git
- [ ] VSCode
- [ ] ESLint
- [ ] Prettier
- [ ] Extensões do VSCode
- [ ] Terminal moderno (Oh My Zsh / Windows Terminal)
- [ ] Chrome / Firefox DevTools
- [ ] Postman ou similar
- [ ] Git GUI (GitHub Desktop ou GitKraken)

## Recursos Adicionais

- [Awesome VSCode](https://github.com/viatsko/awesome-vscode)
- [Awesome JavaScript](https://github.com/sorrycc/awesome-javascript)
- [Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)
