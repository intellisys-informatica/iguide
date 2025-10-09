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
    print_header "Criando estrutura do projeto na pasta src/"

    print_info "Criando estrutura de pastas..."

    # Create fundamental structure
    mkdir -p src/{app/{providers,routes,styles},features,shared/{components,lib,services,types}}

    # Create feature example (students)
    mkdir -p src/features/students/{components,hooks,types}

    # Create shared components structure
    mkdir -p src/shared/components/{ui,layout}

    print_success "Estrutura de pastas criada"
}

# Create configuration files
create_config_files() {
    print_info "Criando arquivos de configuração..."

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

    # .gitignore (se não existir)
    if [ ! -f .gitignore ]; then
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
    fi

    print_success "Arquivos de configuração criados"
}

# Create source files
create_source_files() {
    print_info "Criando arquivos fonte..."

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

# Check and install git flow
check_git_flow() {
    if ! command -v git-flow &> /dev/null; then
        print_warning "Git Flow não encontrado. Instalando..."

        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            if command -v apt-get &> /dev/null; then
                sudo apt-get install -y git-flow
            elif command -v yum &> /dev/null; then
                sudo yum install -y gitflow
            else
                print_error "Não foi possível instalar o Git Flow automaticamente."
                print_info "Instale manualmente: https://github.com/nvie/gitflow/wiki/Installation"
                exit 1
            fi
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            if command -v brew &> /dev/null; then
                brew install git-flow
            else
                print_error "Homebrew não encontrado. Instale o Git Flow manualmente."
                exit 1
            fi
        else
            print_error "Sistema operacional não suportado para instalação automática do Git Flow."
            exit 1
        fi

        print_success "Git Flow instalado"
    fi
}

# Initialize git with git flow
init_git() {
    print_info "Inicializando repositório Git com Git Flow..."

    check_git_flow

    # Initialize git repo
    git init

    # Initialize git flow with main as production branch
    git flow init -d -f <<EOF
main
develop
feature/
release/
hotfix/
support/
EOF

    # Add and commit
    git add .
    git commit -m "chore: initial project setup

🚀 Estrutura React criada seguindo padrões do time
- Estrutura de pastas baseada em features
- Path aliases configurados (@/, @app/, @features/, @shared/)"

    print_success "Repositório Git com Git Flow inicializado (branch: main)"
}


# Show completion message
show_completion() {
    print_header "Estrutura criada com sucesso! 🎉"

    echo -e "\n${BLUE}Estrutura criada:${NC}\n"
    echo -e "  📁 src/app/          - Configuração da aplicação"
    echo -e "  📁 src/features/     - Módulos por funcionalidade"
    echo -e "  📁 src/shared/       - Código compartilhado"
    echo -e "\n${GREEN}Git Flow inicializado${NC}"
    echo -e "  Branch principal: ${BLUE}main${NC}"
    echo -e "  Branch desenvolvimento: ${BLUE}develop${NC}"
    echo -e "\n${YELLOW}Próximo passo:${NC} Configure package.json e instale dependências conforme o projeto\n"
}

# Main function
main() {
    # Show banner
    echo -e "${BLUE}"
    echo "╔════════════════════════════════════════════╗"
    echo "║  React Structure Scaffolding              ║"
    echo "║  Baseado nos padrões do time              ║"
    echo "╚════════════════════════════════════════════╝"
    echo -e "${NC}"

    # Check if we're in a project root (must have package.json or be empty)
    if [ ! -f "package.json" ] && [ "$(ls -A)" ]; then
        print_error "Execute este script na raiz de um projeto React existente ou em um diretório vazio"
        exit 1
    fi

    # Create project structure
    create_structure
    create_config_files
    create_source_files
    init_git

    # Show completion message
    show_completion
}

# Run main function
main "$@"
