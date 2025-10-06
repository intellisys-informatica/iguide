# Configuração do Prettier

Guia de configuração do Prettier para formatação automática de código.

## Instalação

```bash
npm install --save-dev prettier eslint-config-prettier
```

## Arquivo .prettierrc

```json
{
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "es5",
  "printWidth": 80,
  "arrowParens": "always",
  "endOfLine": "lf",
  "bracketSpacing": true
}
```

## .prettierignore

```
node_modules/
dist/
build/
.next/
coverage/
package-lock.json
yarn.lock
```

## Scripts no package.json

```json
{
  "scripts": {
    "format": "prettier --write \"**/*.{js,jsx,ts,tsx,json,css,md}\"",
    "format:check": "prettier --check \"**/*.{js,jsx,ts,tsx,json,css,md}\""
  }
}
```

## Integração com ESLint

```bash
npm install --save-dev eslint-config-prettier
```

No `.eslintrc.json`:

```json
{
  "extends": [
    "eslint:recommended",
    "prettier"
  ]
}
```

## Integração com VSCode

Arquivo `.vscode/settings.json`:

```json
{
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true
}
```

## Recursos Adicionais

- [Prettier Documentation](https://prettier.io/docs/en/)
- [Prettier Playground](https://prettier.io/playground/)
