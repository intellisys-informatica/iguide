# Configuração do VSCode

Guia completo de configurações e extensões recomendadas para VSCode.

## Instalação

Baixe o Visual Studio Code em [code.visualstudio.com](https://code.visualstudio.com)

## Extensões Essenciais

### Linting e Formatação

#### ESLint
**ID:** `dbaeumer.vscode-eslint`

Integra ESLint ao VSCode para linting em tempo real.

```bash
code --install-extension dbaeumer.vscode-eslint
```

#### Prettier
**ID:** `esbenp.prettier-vscode`

Formatador de código automático.

```bash
code --install-extension esbenp.prettier-vscode
```

### Git

#### GitLens
**ID:** `eamodio.gitlens`

Superpoderes do Git: blame inline, histórico de arquivos, comparações.

```bash
code --install-extension eamodio.gitlens
```

#### Git Graph
**ID:** `mhutchie.git-graph`

Visualização gráfica do histórico do Git.

```bash
code --install-extension mhutchie.git-graph
```

### Produtividade

#### Path Intellisense
**ID:** `christian-kohler.path-intellisense`

Autocomplete de caminhos de arquivos.

```bash
code --install-extension christian-kohler.path-intellisense
```

#### Auto Rename Tag
**ID:** `formulahendry.auto-rename-tag`

Renomeia tags HTML/JSX automaticamente.

```bash
code --install-extension formulahendry.auto-rename-tag
```

#### Error Lens
**ID:** `usernamehololens.error-lens`

Mostra erros inline no código.

```bash
code --install-extension usernamehololens.error-lens
```

#### TODO Highlight
**ID:** `wayou.vscode-todo-highlight`

Destaca comentários TODO, FIXME, etc.

```bash
code --install-extension wayou.vscode-todo-highlight
```

### JavaScript/TypeScript

#### ES7+ React/Redux Snippets
**ID:** `dsznajder.es7-react-js-snippets`

Snippets para React, Redux, GraphQL.

```bash
code --install-extension dsznajder.es7-react-js-snippets
```

#### JavaScript (ES6) code snippets
**ID:** `xabikos.JavaScriptSnippets`

Snippets para JavaScript ES6.

```bash
code --install-extension xabikos.JavaScriptSnippets
```

### Temas e Ícones

#### Material Icon Theme
**ID:** `PKief.material-icon-theme`

Ícones modernos para arquivos e pastas.

```bash
code --install-extension PKief.material-icon-theme
```

#### One Dark Pro
**ID:** `zhuangtongfa.Material-theme`

Tema popular baseado no Atom.

```bash
code --install-extension zhuangtongfa.Material-theme
```

## Configurações (settings.json)

Acesse: `Ctrl/Cmd + Shift + P` → "Preferences: Open Settings (JSON)"

```json
{
  // Editor
  "editor.fontSize": 14,
  "editor.fontFamily": "'Fira Code', 'Cascadia Code', Consolas, monospace",
  "editor.fontLigatures": true,
  "editor.tabSize": 2,
  "editor.insertSpaces": true,
  "editor.wordWrap": "on",
  "editor.rulers": [80, 120],
  "editor.minimap.enabled": true,
  "editor.cursorBlinking": "smooth",
  "editor.cursorSmoothCaretAnimation": "on",
  "editor.smoothScrolling": true,

  // Format on save
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": "explicit",
    "source.organizeImports": "explicit"
  },

  // JavaScript/TypeScript
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[javascriptreact]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[typescriptreact]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[json]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },

  // Files
  "files.autoSave": "onFocusChange",
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "files.exclude": {
    "**/.git": true,
    "**/.DS_Store": true,
    "**/node_modules": true,
    "**/dist": true,
    "**/build": true
  },

  // Git
  "git.autofetch": true,
  "git.confirmSync": false,
  "git.enableSmartCommit": true,

  // Terminal
  "terminal.integrated.fontSize": 13,
  "terminal.integrated.fontFamily": "'Fira Code', monospace",
  "terminal.integrated.cursorBlinking": true,

  // Breadcrumbs
  "breadcrumbs.enabled": true,

  // Workbench
  "workbench.iconTheme": "material-icon-theme",
  "workbench.colorTheme": "One Dark Pro",
  "workbench.startupEditor": "none",

  // ESLint
  "eslint.validate": [
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact"
  ],

  // Prettier
  "prettier.semi": true,
  "prettier.singleQuote": true,
  "prettier.trailingComma": "es5",
  "prettier.tabWidth": 2,

  // Emmet
  "emmet.includeLanguages": {
    "javascript": "javascriptreact",
    "typescript": "typescriptreact"
  },

  // IntelliSense
  "typescript.updateImportsOnFileMove.enabled": "always",
  "javascript.updateImportsOnFileMove.enabled": "always",

  // Other
  "explorer.confirmDelete": false,
  "explorer.confirmDragAndDrop": false,
  "extensions.ignoreRecommendations": false,
  "diffEditor.ignoreTrimWhitespace": false
}
```

## Atalhos Úteis (keybindings.json)

Acesse: `Ctrl/Cmd + Shift + P` → "Preferences: Open Keyboard Shortcuts (JSON)"

```json
[
  // Toggle terminal
  {
    "key": "ctrl+`",
    "command": "workbench.action.terminal.toggleTerminal"
  },
  // Duplicate line
  {
    "key": "ctrl+shift+d",
    "command": "editor.action.copyLinesDownAction"
  },
  // Delete line
  {
    "key": "ctrl+shift+k",
    "command": "editor.action.deleteLines"
  },
  // Move line up
  {
    "key": "alt+up",
    "command": "editor.action.moveLinesUpAction"
  },
  // Move line down
  {
    "key": "alt+down",
    "command": "editor.action.moveLinesDownAction"
  },
  // Multi-cursor
  {
    "key": "ctrl+alt+down",
    "command": "editor.action.insertCursorBelow"
  },
  {
    "key": "ctrl+alt+up",
    "command": "editor.action.insertCursorAbove"
  }
]
```

## Snippets Personalizados

### JavaScript/TypeScript Snippets

Acesse: `Ctrl/Cmd + Shift + P` → "Preferences: Configure User Snippets" → "javascript.json"

```json
{
  "Console log": {
    "prefix": "clg",
    "body": ["console.log('$1', $1);"],
    "description": "Console log with label"
  },
  "Arrow Function": {
    "prefix": "af",
    "body": ["const $1 = ($2) => {", "  $3", "};"],
    "description": "Arrow function"
  },
  "Async Arrow Function": {
    "prefix": "aaf",
    "body": ["const $1 = async ($2) => {", "  $3", "};"],
    "description": "Async arrow function"
  },
  "Try Catch": {
    "prefix": "tryc",
    "body": ["try {", "  $1", "} catch (error) {", "  console.error('$2', error);", "  $3", "}"],
    "description": "Try catch block"
  },
  "Import": {
    "prefix": "imp",
    "body": ["import { $2 } from '$1';"],
    "description": "Import statement"
  }
}
```

### React Snippets

Acesse: "Preferences: Configure User Snippets" → "typescriptreact.json"

```json
{
  "React Functional Component": {
    "prefix": "rfc",
    "body": [
      "import React from 'react';",
      "",
      "interface ${1:ComponentName}Props {",
      "  $2",
      "}",
      "",
      "export const ${1:ComponentName}: React.FC<${1:ComponentName}Props> = ({ $3 }) => {",
      "  return (",
      "    <div>",
      "      $4",
      "    </div>",
      "  );",
      "};",
      ""
    ],
    "description": "React functional component with TypeScript"
  },
  "useState": {
    "prefix": "us",
    "body": ["const [$1, set${1/(.*)/${1:/capitalize}/}] = useState<$2>($3);"],
    "description": "useState hook"
  },
  "useEffect": {
    "prefix": "ue",
    "body": ["useEffect(() => {", "  $1", "}, [$2]);"],
    "description": "useEffect hook"
  }
}
```

## Workspace Settings

Para configurações específicas do projeto, crie `.vscode/settings.json` na raiz:

```json
{
  "editor.tabSize": 2,
  "editor.formatOnSave": true,
  "eslint.workingDirectories": ["./"],
  "typescript.tsdk": "node_modules/typescript/lib",
  "files.associations": {
    "*.css": "css",
    "*.scss": "scss"
  }
}
```

## Extensions.json (Recomendações)

Crie `.vscode/extensions.json` para recomendar extensões ao time:

```json
{
  "recommendations": [
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode",
    "eamodio.gitlens",
    "christian-kohler.path-intellisense",
    "formulahendry.auto-rename-tag",
    "usernamehololens.error-lens",
    "dsznajder.es7-react-js-snippets",
    "PKief.material-icon-theme"
  ]
}
```

## Launch.json (Debug)

Crie `.vscode/launch.json` para configurar debugging:

### Node.js

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Debug Node App",
      "skipFiles": ["<node_internals>/**"],
      "program": "${workspaceFolder}/src/index.js",
      "outFiles": ["${workspaceFolder}/dist/**/*.js"]
    }
  ]
}
```

### React (Chrome)

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "chrome",
      "request": "launch",
      "name": "Debug React in Chrome",
      "url": "http://localhost:3000",
      "webRoot": "${workspaceFolder}/src",
      "sourceMapPathOverrides": {
        "webpack:///src/*": "${webRoot}/*"
      }
    }
  ]
}
```

## Tasks.json (Automação)

Crie `.vscode/tasks.json` para automatizar tarefas:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "npm: install",
      "type": "shell",
      "command": "npm install",
      "problemMatcher": []
    },
    {
      "label": "npm: start",
      "type": "npm",
      "script": "start",
      "isBackground": true,
      "problemMatcher": {
        "owner": "custom",
        "pattern": {
          "regexp": "^$"
        },
        "background": {
          "activeOnStart": true,
          "beginsPattern": "Compiling...",
          "endsPattern": "Compiled successfully!"
        }
      }
    },
    {
      "label": "npm: test",
      "type": "npm",
      "script": "test",
      "group": {
        "kind": "test",
        "isDefault": true
      }
    }
  ]
}
```

## Fontes Recomendadas

### Fira Code
- Suporta ligaduras (font ligatures)
- Download: [github.com/tonsky/FiraCode](https://github.com/tonsky/FiraCode)

### Cascadia Code
- Da Microsoft, excelente para terminal
- Download: [github.com/microsoft/cascadia-code](https://github.com/microsoft/cascadia-code)

### JetBrains Mono
- Criada especificamente para código
- Download: [jetbrains.com/lp/mono](https://www.jetbrains.com/lp/mono/)

## Atalhos Essenciais

### Navegação
- `Ctrl/Cmd + P` - Quick Open (buscar arquivo)
- `Ctrl/Cmd + Shift + P` - Command Palette
- `Ctrl/Cmd + B` - Toggle Sidebar
- `Ctrl/Cmd + \` - Split Editor

### Edição
- `Alt + Click` - Multi cursor
- `Ctrl/Cmd + D` - Select next occurrence
- `Ctrl/Cmd + Shift + L` - Select all occurrences
- `Ctrl/Cmd + /` - Toggle comment
- `Alt + Up/Down` - Move line

### Busca
- `Ctrl/Cmd + F` - Find
- `Ctrl/Cmd + H` - Replace
- `Ctrl/Cmd + Shift + F` - Find in files

### Terminal
- `Ctrl + \`` - Toggle terminal
- `Ctrl + Shift + \`` - New terminal

## Dicas de Produtividade

### 1. Zen Mode
`Ctrl/Cmd + K, Z` - Modo foco sem distrações

### 2. Command Palette
`Ctrl/Cmd + Shift + P` - Acesso rápido a todos os comandos

### 3. Emmet
Digite `div.container>ul>li*5` + Tab para HTML rápido

### 4. Refactoring
- `F2` - Rename symbol
- `Ctrl/Cmd + .` - Quick fix

### 5. IntelliSense
`Ctrl + Space` - Trigger suggestions

## Recursos Adicionais

- [VSCode Tips and Tricks](https://code.visualstudio.com/docs/getstarted/tips-and-tricks)
- [VSCode Can Do That?](https://vscodecandothat.com/)
- [Awesome VSCode](https://github.com/viatsko/awesome-vscode)
