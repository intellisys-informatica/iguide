#!/bin/bash

# =============================================================================
# React + Vite Project Creator - Wrapper for npm create vite@latest
# Configurações padrão do time Intellisys
# =============================================================================

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
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
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}$1${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

# Validate project name
validate_project_name() {
    if [[ ! "$1" =~ ^[a-z0-9-]+$ ]]; then
        print_error "Nome do projeto inválido. Use apenas letras minúsculas, números e hífens."
        exit 1
    fi
}

# Check required tools
check_requirements() {
    print_header "Verificando Requisitos"

    # Check Node.js
    if ! command -v node &> /dev/null; then
        print_error "Node.js não encontrado. Instale: https://nodejs.org/"
        exit 1
    fi
    print_success "Node.js $(node --version)"

    # Check npm
    if ! command -v npm &> /dev/null; then
        print_error "npm não encontrado."
        exit 1
    fi
    print_success "npm $(npm --version)"

    # Check git
    if ! command -v git &> /dev/null; then
        print_error "Git não encontrado. Instale: https://git-scm.com/"
        exit 1
    fi
    print_success "Git $(git --version)"
}

# Create Vite project
create_vite_project() {
    local project_name=$1

    print_header "Criando Projeto com Vite"

    print_info "Criando projeto '$project_name' com Vite + React + TypeScript..."

    # Create Vite project with React + TypeScript template
    # --template react-ts: usa template React + TypeScript
    # --no-rolldown: não usa rolldown-vite experimental (padrão: No)
    # --no-interactive: força modo não-interativo
    npm create vite@latest "$project_name" -- --template react-ts --no-rolldown --no-interactive

    cd "$project_name"

    print_success "Projeto base criado com Vite"
}

# Install dependencies
install_dependencies() {
    print_header "Instalando Dependências"

    print_info "Instalando dependências base do Vite..."
    npm install

    print_success "Dependências base instaladas"

    print_info "Instalando dependências do projeto..."
    npm install react-router-dom react-hook-form zod axios

    print_success "Dependências principais instaladas"

    # Install Tailwind CSS
    print_info "Instalando Tailwind CSS..."
    npm install tailwindcss @tailwindcss/vite

    print_success "Todas as dependências instaladas"
}

# Create project structure
create_structure() {
    print_header "Criando Estrutura do Projeto"

    print_info "Criando estrutura de pastas..."

    # Create fundamental structure
    mkdir -p src/app/{providers,routes,styles}
    mkdir -p src/features
    mkdir -p src/shared/{components,lib,services,types}

    # Create feature example (students)
    mkdir -p src/features/students/{components,hooks,types}

    # Create shared components structure
    mkdir -p src/shared/components/{ui,layout}

    print_success "Estrutura de pastas criada"
}

# Configure Vite with Tailwind plugin and path aliases
configure_vite() {
    print_header "Configurando Vite"

    print_info "Instalando @types/node para resolução de paths..."
    npm install -D @types/node

    print_info "Configurando Vite com Tailwind e path aliases..."

    # Update vite.config.ts with Tailwind plugin and path resolution
    cat > vite.config.ts << 'EOF'
import path from "path"
import tailwindcss from "@tailwindcss/vite"
import react from "@vitejs/plugin-react"
import { defineConfig } from "vite"

export default defineConfig({
  plugins: [react(), tailwindcss()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
})
EOF

    print_success "Vite configurado com Tailwind CSS e path aliases"
}

# Create environment file (DESABILITADO)
create_env_file() {
    print_header "Criando Arquivo de Ambiente"

    print_info "Arquivo .env não criado - configure manualmente se necessário"
    print_success "Etapa pulada"
}

# Update .gitignore (DESABILITADO)
update_gitignore() {
    print_info ".gitignore mantido padrão do Vite"
}

# Configure Tailwind CSS in styles
configure_tailwind_styles() {
    print_header "Configurando Estilos do Tailwind"

    print_info "Adicionando @import do Tailwind ao CSS..."

    # Update index.css with Tailwind import
    cat > src/index.css << 'EOF'
@import "tailwindcss";
EOF

    print_success "Tailwind CSS configurado no arquivo de estilos"
}

# Update tsconfig.json for shadcn/ui
update_tsconfig() {
    print_header "Configurando TypeScript"

    print_info "Atualizando tsconfig.json com path aliases..."

    # Read existing tsconfig.json and add baseUrl and paths to compilerOptions
    cat > tsconfig.json << 'EOF'
{
  "files": [],
  "references": [
    { "path": "./tsconfig.app.json" },
    { "path": "./tsconfig.node.json" }
  ],
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  }
}
EOF

    print_info "Atualizando tsconfig.app.json com path aliases..."

    # Backup original tsconfig.app.json
    cp tsconfig.app.json tsconfig.app.json.bak

    # Update tsconfig.app.json with path resolution
    cat > tsconfig.app.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,

    /* Bundler mode */
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "isolatedModules": true,
    "moduleDetection": "force",
    "noEmit": true,
    "jsx": "react-jsx",

    /* Linting */
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,

    /* Path Aliases */
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["src"]
}
EOF

    print_success "TypeScript configurado com path aliases para shadcn/ui"
}

# Initialize shadcn/ui
init_shadcn() {
    print_header "Inicializando shadcn/ui"

    print_info "Executando shadcn init..."

    # Run shadcn init with default answers (non-interactive)
    # Using npx instead of pnpm dlx for npm compatibility
    npx shadcn@latest init -d

    print_success "shadcn/ui inicializado"
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
                return 1
            fi
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            if command -v brew &> /dev/null; then
                brew install git-flow
            else
                print_error "Homebrew não encontrado. Instale o Git Flow manualmente."
                return 1
            fi
        else
            print_warning "Sistema operacional não suportado para instalação automática do Git Flow."
            return 1
        fi

        print_success "Git Flow instalado"
    fi
    return 0
}

# Initialize git with git flow
init_git() {
    print_header "Inicializando Repositório Git"

    print_info "Inicializando Git..."

    # Initialize git repo
    git init

    # Try to initialize git flow
    if check_git_flow; then
        print_info "Inicializando Git Flow..."

        # Initialize git flow with main as production branch
        git flow init -d -f <<EOF
main
develop
feature/
release/
hotfix/
support/
EOF

        print_success "Git Flow inicializado (branch: main)"
    else
        print_warning "Continuando sem Git Flow"
    fi

    # Add and commit
    git add .
    git commit -m "chore: initial project setup

🚀 Projeto React + Vite criado com padrões do time
- Vite + React + TypeScript
- Tailwind CSS v4 + shadcn/ui configurados
- Path aliases (@/*) configurados
- react-router-dom, react-hook-form, zod, axios
- Estrutura de pastas personalizada (app/, features/, shared/)"

    print_success "Repositório Git inicializado"
}

# Show completion message
show_completion() {
    local project_name=$1

    print_header "Projeto Criado com Sucesso! 🎉"

    echo -e "\n${GREEN}Projeto:${NC} ${BLUE}$project_name${NC}\n"

    echo -e "${CYAN}Dependências Instaladas:${NC}"
    echo -e "  ✓ react, react-dom (Vite)"
    echo -e "  ✓ react-router-dom"
    echo -e "  ✓ react-hook-form"
    echo -e "  ✓ zod"
    echo -e "  ✓ axios"
    echo -e "  ✓ tailwindcss + @tailwindcss/vite"
    echo -e "  ✓ shadcn/ui (inicializado)"
    echo -e "  ✓ typescript + vite"

    echo -e "\n${CYAN}Configurações:${NC}"
    echo -e "  ✓ Path aliases (@/*) configurados"
    echo -e "  ✓ TypeScript configurado para shadcn/ui"
    echo -e "  ✓ Tailwind CSS v4 integrado"

    echo -e "\n${CYAN}Estrutura:${NC}"
    echo -e "  📁 src/app/          - Configuração da aplicação"
    echo -e "  📁 src/features/     - Módulos por funcionalidade"
    echo -e "  📁 src/shared/       - Código compartilhado"
    echo -e "  📁 src/components/   - Componentes shadcn/ui"

    echo -e "\n${GREEN}Git:${NC}"
    if command -v git-flow &> /dev/null; then
        echo -e "  ✓ Repositório inicializado com Git Flow"
        echo -e "  ✓ Branch principal: ${BLUE}main${NC}"
        echo -e "  ✓ Branch desenvolvimento: ${BLUE}develop${NC}"
    else
        echo -e "  ✓ Repositório Git inicializado"
    fi

    echo -e "\n${YELLOW}Próximos passos:${NC}\n"
    echo -e "  cd $project_name"
    echo -e "  npm run dev"
    echo -e "\n${CYAN}Adicionar componentes shadcn/ui:${NC}"
    echo -e "  npx shadcn@latest add button"
    echo -e "  npx shadcn@latest add card"
    echo -e "  npx shadcn@latest add input"
    echo -e "\n${GREEN}Projeto pronto para desenvolvimento! 🚀${NC}\n"
}

# Main function
main() {
    # Show banner
    echo -e "${BLUE}"
    echo "╔════════════════════════════════════════════╗"
    echo "║  React + Vite Project Creator             ║"
    echo "║  Padrões Intellisys                       ║"
    echo "╚════════════════════════════════════════════╝"
    echo -e "${NC}"

    # Get project name
    if [ -z "$1" ]; then
        read -p "Digite o nome do projeto: " PROJECT_NAME
    else
        PROJECT_NAME="$1"
    fi

    # Validate project name
    validate_project_name "$PROJECT_NAME"

    # Check if directory already exists
    if [ -d "$PROJECT_NAME" ]; then
        print_error "Diretório '$PROJECT_NAME' já existe"
        exit 1
    fi

    # Check requirements
    check_requirements

    # Create project
    create_vite_project "$PROJECT_NAME"

    # Install dependencies
    install_dependencies

    # Configure TypeScript for shadcn/ui
    update_tsconfig

    # Configure Vite with Tailwind and path aliases
    configure_vite

    # Configure Tailwind styles
    configure_tailwind_styles

    # Create project structure
    create_structure

    # Initialize shadcn/ui
    init_shadcn

    # Initialize git
    init_git

    # Go back to original directory
    cd ..

    # Show completion message
    show_completion "$PROJECT_NAME"
}

# Run main function
main "$@"
