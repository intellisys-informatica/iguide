#!/bin/bash

# =============================================================================
# React + TypeScript Project Scaffolding
# Based on team standards and conventions
# =============================================================================

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Print colored messages
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_header() {
    echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

# Validate project name
validate_project_name() {
    if [[ ! "$1" =~ ^[a-z0-9-]+$ ]]; then
        print_error "Nome do projeto inválido. Use apenas letras minúsculas, números e hífens."
        exit 1
    fi
}

# Create directory structure
create_structure() {
    local project_name=$1

    print_header "Criando estrutura do projeto: $project_name"

    # Create root directory
    mkdir -p "$project_name"
    cd "$project_name"

    print_info "Criando estrutura de pastas..."

    # Create fundamental structure
    mkdir -p src/{app/{providers,routes,styles},features,shared/{components,lib,services,types}}

    # Create feature example (students)
    mkdir -p src/features/students/{components,hooks,types}

    # Create shared components structure
    mkdir -p src/shared/components/{ui,layout}

    # Create public folder
    mkdir -p public

    print_success "Estrutura de pastas criada"
}

# Create configuration files
create_config_files() {
    print_info "Criando arquivos de configuração..."

    # package.json
    cat > package.json << 'EOF'
{
  "name": "PROJECT_NAME",
  "private": true,
  "version": "0.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "lint": "eslint . --ext ts,tsx --report-unused-disable-directives --max-warnings 0",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.23.0",
    "react-hook-form": "^7.51.5",
    "@hookform/resolvers": "^3.4.2",
    "zod": "^3.23.8",
    "axios": "^1.6.8",
    "clsx": "^2.1.0",
    "tailwind-merge": "^2.2.2"
  },
  "devDependencies": {
    "@types/react": "^18.2.66",
    "@types/react-dom": "^18.2.22",
    "@typescript-eslint/eslint-plugin": "^7.2.0",
    "@typescript-eslint/parser": "^7.2.0",
    "@vitejs/plugin-react": "^4.2.1",
    "autoprefixer": "^10.4.19",
    "eslint": "^8.57.0",
    "eslint-plugin-react-hooks": "^4.6.0",
    "eslint-plugin-react-refresh": "^0.4.6",
    "postcss": "^8.4.38",
    "tailwindcss": "^3.4.3",
    "typescript": "^5.2.2",
    "vite": "^5.2.0"
  }
}
EOF

    # tsconfig.json
    cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "baseUrl": ".",

    /* Bundler mode */
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",

    /* Linting */
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,

    /* Path aliases */
    "paths": {
      "@/*": ["./src/*"],
      "@app/*": ["./src/app/*"],
      "@features/*": ["./src/features/*"],
      "@shared/*": ["./src/shared/*"]
    }
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
EOF

    # tsconfig.node.json
    cat > tsconfig.node.json << 'EOF'
{
  "compilerOptions": {
    "composite": true,
    "skipLibCheck": true,
    "module": "ESNext",
    "moduleResolution": "bundler",
    "allowSyntheticDefaultImports": true
  },
  "include": ["vite.config.ts"]
}
EOF

    # vite.config.ts
    cat > vite.config.ts << 'EOF'
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import path from 'path';

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
      '@app': path.resolve(__dirname, './src/app'),
      '@features': path.resolve(__dirname, './src/features'),
      '@shared': path.resolve(__dirname, './src/shared'),
    },
  },
});
EOF

    # .eslintrc.cjs
    cat > .eslintrc.cjs << 'EOF'
module.exports = {
  root: true,
  env: { browser: true, es2020: true },
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:react-hooks/recommended',
  ],
  ignorePatterns: ['dist', '.eslintrc.cjs'],
  parser: '@typescript-eslint/parser',
  plugins: ['react-refresh'],
  rules: {
    'react-refresh/only-export-components': [
      'warn',
      { allowConstantExport: true },
    ],
    '@typescript-eslint/no-explicit-any': 'warn',
  },
}
EOF

    # tailwind.config.js
    cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOF

    # postcss.config.js
    cat > postcss.config.js << 'EOF'
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOF

    # .gitignore
    cat > .gitignore << 'EOF'
# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*
lerna-debug.log*

node_modules
dist
dist-ssr
*.local

# Editor directories and files
.vscode/*
!.vscode/extensions.json
.idea
.DS_Store
*.suo
*.ntvs*
*.njsproj
*.sln
*.sw?

# Environment variables
.env
.env.local
.env.production
EOF

    # .env.example
    cat > .env.example << 'EOF'
VITE_API_BASE_URL=http://localhost:3000/api
VITE_API_KEY=your-api-key-here
EOF

    # README.md
    cat > README.md << EOF
# PROJECT_NAME

Projeto React + TypeScript seguindo os padrões do time.

## Estrutura do Projeto

\`\`\`
src/
├── app/              # Configuração da aplicação
├── features/         # Módulos por funcionalidade
└── shared/           # Código compartilhado
\`\`\`

## Instalação

\`\`\`bash
npm install
\`\`\`

## Desenvolvimento

\`\`\`bash
npm run dev
\`\`\`

## Build

\`\`\`bash
npm run build
\`\`\`

## Padrões

Este projeto segue os padrões de desenvolvimento documentados em [REACT_STANDARDS.md](./REACT_STANDARDS.md).
EOF

    print_success "Arquivos de configuração criados"
}

# Create source files
create_source_files() {
    print_info "Criando arquivos fonte..."

    # index.html
    cat > index.html << 'EOF'
<!doctype html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>PROJECT_NAME</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>
EOF

    # src/main.tsx
    cat > src/main.tsx << 'EOF'
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './app/styles/index.css';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
);
EOF

    # src/App.tsx
    cat > src/App.tsx << 'EOF'
import { AppRoutes } from './app/routes';

function App() {
  return <AppRoutes />;
}

export default App;
EOF

    # src/app/styles/index.css
    cat > src/app/styles/index.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  :root {
    --background: 0 0% 100%;
    --foreground: 222.2 84% 4.9%;
  }

  * {
    @apply border-border;
  }

  body {
    @apply bg-background text-foreground;
  }
}
EOF

    # src/app/routes/index.tsx
    cat > src/app/routes/index.tsx << 'EOF'
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { lazy, Suspense } from 'react';

const Students = lazy(() => import('@/features/students'));

const LoadingFallback = () => (
  <div className="flex items-center justify-center h-screen">
    <span>Carregando...</span>
  </div>
);

export const AppRoutes = () => {
  return (
    <BrowserRouter>
      <Suspense fallback={<LoadingFallback />}>
        <Routes>
          <Route path="/" element={<Navigate to="/students" replace />} />
          <Route path="/students" element={<Students />} />
        </Routes>
      </Suspense>
    </BrowserRouter>
  );
};
EOF

    # src/shared/services/api/client.ts
    mkdir -p src/shared/services/api
    cat > src/shared/services/api/client.ts << 'EOF'
import axios from 'axios';

export const apiClient = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || 'http://localhost:3000/api',
  headers: {
    'Content-Type': 'application/json',
  },
});

// Request interceptor - add auth token
apiClient.interceptors.request.use(
  (config) => {
    const token = sessionStorage.getItem('token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => Promise.reject(error)
);

// Response interceptor - handle errors
apiClient.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      sessionStorage.removeItem('token');
      window.location.href = '/';
    }
    return Promise.reject(error);
  }
);
EOF

    # src/shared/lib/utils.ts
    cat > src/shared/lib/utils.ts << 'EOF'
import { type ClassValue, clsx } from 'clsx';
import { twMerge } from 'tailwind-merge';

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}
EOF

    # src/features/students/index.tsx
    cat > src/features/students/index.tsx << 'EOF'
export default function Students() {
  return (
    <div className="p-8">
      <h1 className="text-3xl font-bold mb-4">Alunos</h1>
      <p className="text-gray-600">
        Lista de alunos - implemente conforme os padrões do time
      </p>
    </div>
  );
}
EOF

    # src/features/students/types/student.types.ts
    cat > src/features/students/types/student.types.ts << 'EOF'
export interface Student {
  id: string;
  name: string;
  birthDate: string;
  email?: string;
  phone?: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface StudentFilter {
  name?: string;
  email?: string;
}
EOF

    # src/vite-env.d.ts
    cat > src/vite-env.d.ts << 'EOF'
/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_API_BASE_URL: string;
  readonly VITE_API_KEY: string;
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}
EOF

    print_success "Arquivos fonte criados"
}

# Replace project name in files
replace_project_name() {
    local project_name=$1

    print_info "Configurando nome do projeto..."

    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        sed -i '' "s/PROJECT_NAME/$project_name/g" package.json
        sed -i '' "s/PROJECT_NAME/$project_name/g" README.md
        sed -i '' "s/PROJECT_NAME/$project_name/g" index.html
    else
        # Linux
        sed -i "s/PROJECT_NAME/$project_name/g" package.json
        sed -i "s/PROJECT_NAME/$project_name/g" README.md
        sed -i "s/PROJECT_NAME/$project_name/g" index.html
    fi

    print_success "Nome do projeto configurado"
}

# Initialize git
init_git() {
    print_info "Inicializando repositório Git..."

    git init
    git add .
    git commit -m "chore: initial project setup

🚀 Projeto criado seguindo padrões do time
- Estrutura de pastas baseada em features
- TypeScript + React + Vite
- Configurações de ESLint e Tailwind
- Path aliases configurados (@/, @app/, @features/, @shared/)"

    print_success "Repositório Git inicializado"
}

# Install dependencies
install_dependencies() {
    print_header "Instalando dependências"

    if command -v npm &> /dev/null; then
        npm install
        print_success "Dependências instaladas com npm"
    elif command -v yarn &> /dev/null; then
        yarn install
        print_success "Dependências instaladas com yarn"
    elif command -v pnpm &> /dev/null; then
        pnpm install
        print_success "Dependências instaladas com pnpm"
    else
        print_warning "Nenhum gerenciador de pacotes encontrado. Execute 'npm install' manualmente."
    fi
}

# Show completion message
show_completion() {
    local project_name=$1

    print_header "Projeto criado com sucesso! 🎉"

    echo -e "${GREEN}Próximos passos:${NC}\n"
    echo -e "  cd $project_name"
    echo -e "  npm run dev"
    echo -e "\n${BLUE}Estrutura criada:${NC}\n"
    echo -e "  📁 src/app/          - Configuração da aplicação"
    echo -e "  📁 src/features/     - Módulos por funcionalidade"
    echo -e "  📁 src/shared/       - Código compartilhado"
    echo -e "\n${BLUE}Comandos disponíveis:${NC}\n"
    echo -e "  npm run dev          - Inicia servidor de desenvolvimento"
    echo -e "  npm run build        - Build de produção"
    echo -e "  npm run lint         - Executa ESLint"
    echo -e "\n${YELLOW}Documentação:${NC} Consulte REACT_STANDARDS.md para padrões do time\n"
}

# Main function
main() {
    local project_name=$1
    local skip_install=$2

    # Show banner
    echo -e "${BLUE}"
    echo "╔════════════════════════════════════════════╗"
    echo "║  React + TypeScript Project Scaffolding   ║"
    echo "║  Baseado nos padrões do time              ║"
    echo "╚════════════════════════════════════════════╝"
    echo -e "${NC}"

    # Validate input
    if [ -z "$project_name" ]; then
        print_error "Uso: create-react-project <nome-do-projeto> [--skip-install]"
        exit 1
    fi

    validate_project_name "$project_name"

    # Check if directory exists
    if [ -d "$project_name" ]; then
        print_error "Diretório '$project_name' já existe"
        exit 1
    fi

    # Create project
    create_structure "$project_name"
    create_config_files
    create_source_files
    replace_project_name "$project_name"
    init_git

    # Install dependencies (unless skipped)
    if [ "$skip_install" != "--skip-install" ]; then
        install_dependencies
    else
        print_warning "Instalação de dependências ignorada"
    fi

    # Show completion message
    cd ..
    show_completion "$project_name"
}

# Run main function
main "$@"
