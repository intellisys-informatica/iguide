#!/bin/bash

# =============================================================================
# Setup Automático do Ambiente de Desenvolvimento - Intellisys
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

# Detect OS (Ubuntu/Debian only)
detect_os() {
    if [[ "$OSTYPE" != "linux-gnu"* ]]; then
        print_error "Este script suporta apenas Ubuntu/Debian"
        print_error "Sistema detectado: $OSTYPE"
        exit 1
    fi

    if [ ! -f /etc/debian_version ]; then
        print_error "Este script suporta apenas Ubuntu/Debian"
        exit 1
    fi

    print_success "Sistema Ubuntu/Debian detectado"
}

# Detect shell
detect_shell() {
    if [ -n "$ZSH_VERSION" ]; then
        SHELL_TYPE="zsh"
        SHELL_RC="$HOME/.zshrc"
    elif [ -n "$BASH_VERSION" ]; then
        SHELL_TYPE="bash"
        SHELL_RC="$HOME/.bashrc"
    else
        print_warning "Shell não detectado. Usando bash como padrão."
        SHELL_TYPE="bash"
        SHELL_RC="$HOME/.bashrc"
    fi
}

# Show banner
show_banner() {
    echo -e "${BLUE}"
    echo "╔════════════════════════════════════════════╗"
    echo "║   Setup Automático - Ambiente Dev         ║"
    echo "║   Intellisys Informatica                  ║"
    echo "╚════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Ask user what to install
ask_installation_type() {
    echo -e "${YELLOW}Escolha o tipo de ambiente:${NC}\n"
    echo "1) Ferramentas essenciais + ReactJS"
    echo "2) Ferramentas essenciais + Go"
    echo "3) Tudo (Ferramentas essenciais + ReactJS + Go)"
    echo ""
    read -p "Digite sua escolha (1-3): " choice

    case $choice in
        1)
            INSTALL_ESSENTIALS=true
            INSTALL_REACT=true
            INSTALL_GO=false
            ;;
        2)
            INSTALL_ESSENTIALS=true
            INSTALL_REACT=false
            INSTALL_GO=true
            ;;
        3)
            INSTALL_ESSENTIALS=true
            INSTALL_REACT=true
            INSTALL_GO=true
            ;;
        *)
            print_error "Escolha inválida"
            exit 1
            ;;
    esac
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install Git
install_git() {
    print_header "Instalando Git"

    if command_exists git; then
        print_warning "Git já instalado: $(git --version)"
        return
    fi

    sudo apt update
    sudo apt install -y git

    print_success "Git instalado: $(git --version)"
}

# Install Git Flow
install_git_flow() {
    print_info "Instalando Git Flow..."

    if command_exists git-flow; then
        print_warning "Git Flow já instalado"
        return
    fi

    sudo apt install -y git-flow

    print_success "Git Flow instalado"
}

# Configure Git
configure_git() {
    # Check if git is already configured
    GIT_USER=$(git config --global user.name 2>/dev/null || echo "")
    GIT_EMAIL=$(git config --global user.email 2>/dev/null || echo "")

    if [ -z "$GIT_USER" ] || [ -z "$GIT_EMAIL" ]; then
        print_header "Configuração do Git"

        if [ -z "$GIT_USER" ]; then
            read -p "Digite seu nome completo: " git_name
            git config --global user.name "$git_name"
        fi

        if [ -z "$GIT_EMAIL" ]; then
            read -p "Digite seu email do GitHub: " git_email
            git config --global user.email "$git_email"
        fi

        git config --global core.editor "vim"
        git config --global init.defaultBranch main

        print_success "Git configurado com sucesso"
    else
        print_info "Git já configurado: $GIT_USER <$GIT_EMAIL>"
    fi
}

# Install Docker
install_docker() {
    print_header "Instalando Docker"

    if command_exists docker; then
        print_warning "Docker já instalado: $(docker --version)"
        return
    fi

    print_info "Instalando Docker..."

    # Remove old versions
    sudo apt remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true

    # Install dependencies
    sudo apt update
    sudo apt install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    # Add Docker's official GPG key
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    # Set up repository
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Install Docker Engine
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Configure Docker to start on boot
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
    sudo systemctl start docker

    # Add user to docker group (no sudo required)
    sudo usermod -aG docker $USER

    print_success "Docker instalado"
    print_info "Docker configurado para iniciar com o sistema"
    print_warning "IMPORTANTE: Faça logout e login novamente para usar Docker sem sudo"
}

# Install curl
install_curl() {
    print_info "Verificando curl..."

    if command_exists curl; then
        print_success "curl já instalado: $(curl --version | head -n1)"
        return
    fi

    sudo apt install -y curl
    print_success "curl instalado"
}

# Install vim
install_vim() {
    print_info "Verificando vim..."

    if command_exists vim; then
        print_success "vim já instalado: $(vim --version | head -n1)"
        return
    fi

    sudo apt install -y vim

    print_success "vim instalado"
}

# Install Node.js (LTS)
install_nodejs() {
    print_header "Instalando Node.js LTS"

    if command_exists node; then
        CURRENT_NODE=$(node --version)
        print_warning "Node.js já instalado: $CURRENT_NODE"

        read -p "Deseja reinstalar a versão LTS? (s/n): " reinstall
        if [[ ! "$reinstall" =~ ^[Ss]$ ]]; then
            return
        fi
    fi

    print_info "Instalando via NodeSource..."

    # Remove old Node if exists
    sudo apt remove -y nodejs npm 2>/dev/null || true

    # Install from NodeSource (LTS)
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs

    # Verify npm is installed
    if ! command_exists npm; then
        print_error "npm não foi instalado corretamente"
        exit 1
    fi

    print_success "Node.js instalado: $(node --version)"
    print_success "npm instalado: $(npm --version)"

    # Install global packages
    print_info "Instalando pacotes globais úteis..."
    npm install -g yarn pnpm
    print_success "yarn e pnpm instalados"
}

# Install Go
install_go() {
    print_header "Instalando Go (última versão estável)"

    if command_exists go; then
        print_warning "Go já instalado: $(go version)"

        read -p "Deseja reinstalar? (s/n): " reinstall
        if [[ ! "$reinstall" =~ ^[Ss]$ ]]; then
            configure_go_path
            return
        fi
    fi

    # Check if wget is installed
    if ! command_exists wget; then
        print_info "wget não encontrado, instalando..."
        sudo apt install -y wget
    fi

    # Get latest stable version
    GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n1)
    GO_TAR="${GO_VERSION}.linux-amd64.tar.gz"

    print_info "Baixando Go $GO_VERSION..."
    wget -q --show-progress "https://go.dev/dl/$GO_TAR"

    print_info "Instalando..."
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf "$GO_TAR"
    rm "$GO_TAR"

    configure_go_path
    print_success "Go instalado: $(/usr/local/go/bin/go version)"
}

# Configure Go PATH
configure_go_path() {
    print_info "Configurando Go PATH..."

    # Create GOPATH directory
    mkdir -p "$HOME/.go"

    # Check if already configured
    if grep -q "export GOPATH=" "$SHELL_RC" 2>/dev/null; then
        print_info "Go PATH já configurado em $SHELL_RC"
        return
    fi

    # Add to shell RC
    cat >> "$SHELL_RC" << 'EOF'

# Go configuration
export GOPATH=$HOME/.go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
EOF

    # Source the file
    if [ "$SHELL_TYPE" == "zsh" ]; then
        source "$HOME/.zshrc" 2>/dev/null || true
    else
        source "$HOME/.bashrc" 2>/dev/null || true
    fi

    print_success "Go PATH configurado em $SHELL_RC"
    print_info "GOPATH: $HOME/.go"
    print_info "GOROOT: /usr/local/go"

    # Install useful Go tools
    print_info "Instalando ferramentas Go úteis..."

    # Use PATH temporário para instalação
    export GOPATH=$HOME/.go
    export PATH=/usr/local/go/bin:$GOPATH/bin:$PATH

    /usr/local/go/bin/go install golang.org/x/tools/cmd/goimports@latest 2>/dev/null || print_warning "Erro ao instalar goimports"
    /usr/local/go/bin/go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest 2>/dev/null || print_warning "Erro ao instalar golangci-lint"

    print_success "Ferramentas Go instaladas"
}


# Show summary
show_summary() {
    print_header "Resumo da Instalação"

    echo -e "${GREEN}Ferramentas instaladas:${NC}\n"

    if [ "$INSTALL_ESSENTIALS" == true ]; then
        echo "✓ Git $(git --version 2>/dev/null || echo 'N/A')"
        echo "✓ Git Flow $(git flow version 2>/dev/null || echo 'N/A')"
        echo "✓ Docker $(docker --version 2>/dev/null || echo 'N/A')"
        echo "✓ curl $(curl --version 2>/dev/null | head -n1 || echo 'N/A')"
        echo "✓ vim $(vim --version 2>/dev/null | head -n1 || echo 'N/A')"
    fi

    if [ "$INSTALL_REACT" == true ]; then
        echo ""
        echo -e "${BLUE}Ambiente ReactJS:${NC}"
        echo "✓ Node.js $(node --version 2>/dev/null || echo 'N/A')"
        echo "✓ npm $(npm --version 2>/dev/null || echo 'N/A')"
        echo "✓ yarn $(yarn --version 2>/dev/null || echo 'N/A')"
        echo "✓ pnpm $(pnpm --version 2>/dev/null || echo 'N/A')"
    fi

    if [ "$INSTALL_GO" == true ]; then
        echo ""
        echo -e "${BLUE}Ambiente Go:${NC}"
        echo "✓ Go $(go version 2>/dev/null || echo 'N/A')"
        echo "✓ GOPATH: $HOME/.go"
        echo "✓ GOROOT: /usr/local/go"
    fi

    echo ""
    print_success "Instalação concluída!"

    echo -e "\n${YELLOW}Próximos passos:${NC}"

    if [ "$INSTALL_ESSENTIALS" == true ]; then
        echo "1. Faça logout e login novamente para usar Docker sem sudo"
    fi

    if [ "$INSTALL_GO" == true ]; then
        echo "2. Recarregue seu shell: source $SHELL_RC"
    fi

    if [ "$INSTALL_REACT" == true ]; then
        echo "3. Crie um projeto React: npm create vite@latest"
    fi

    if [ "$INSTALL_GO" == true ]; then
        echo "4. Teste Go: go version"
    fi
}

# Main installation flow
main() {
    show_banner
    detect_os
    detect_shell

    print_info "Shell: $SHELL_TYPE ($SHELL_RC)"
    echo ""

    ask_installation_type

    # Essential tools
    if [ "$INSTALL_ESSENTIALS" == true ]; then
        install_curl
        install_git
        install_git_flow
        install_docker
        install_vim
    fi

    # ReactJS environment
    if [ "$INSTALL_REACT" == true ]; then
        install_nodejs
    fi

    # Go environment
    if [ "$INSTALL_GO" == true ]; then
        install_go
    fi

    # Configure Git (ask at the end if not configured)
    if [ "$INSTALL_ESSENTIALS" == true ]; then
        configure_git
    fi

    # Show summary
    show_summary
}

# Run main function
main "$@"
