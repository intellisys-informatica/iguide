#!/bin/bash

# =============================================================================
# Instalador Automático - React + TypeScript Project Scaffolding
# Instala o script create-react-project.sh e configura alias
# =============================================================================

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

# Print functions
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

# Banner
show_banner() {
    echo -e "${BLUE}"
    echo "╔════════════════════════════════════════════╗"
    echo "║      Instalador Automático                ║"
    echo "║  React + TypeScript Scaffolding Script    ║"
    echo "╚════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Detect shell
detect_shell() {
    if [ -n "$BASH_VERSION" ]; then
        echo "bash"
    elif [ -n "$ZSH_VERSION" ]; then
        echo "zsh"
    else
        # Try to detect from SHELL environment variable
        case "$SHELL" in
            */bash)
                echo "bash"
                ;;
            */zsh)
                echo "zsh"
                ;;
            *)
                echo "unknown"
                ;;
        esac
    fi
}

# Get shell config file
get_shell_config() {
    local shell_type=$1

    case "$shell_type" in
        bash)
            if [ -f "$HOME/.bashrc" ]; then
                echo "$HOME/.bashrc"
            elif [ -f "$HOME/.bash_profile" ]; then
                echo "$HOME/.bash_profile"
            else
                echo "$HOME/.bashrc"
            fi
            ;;
        zsh)
            echo "$HOME/.zshrc"
            ;;
        *)
            echo ""
            ;;
    esac
}

# Check if alias already exists
alias_exists() {
    local config_file=$1
    local alias_name=$2

    if [ -f "$config_file" ]; then
        grep -q "alias ${alias_name}=" "$config_file"
        return $?
    fi
    return 1
}

# Download script from GitHub
download_script() {
    local script_url=$1
    local dest_path=$2

    print_info "Baixando script do repositório..."

    if command -v curl &> /dev/null; then
        curl -fsSL "$script_url" -o "$dest_path"
    elif command -v wget &> /dev/null; then
        wget -q "$script_url" -O "$dest_path"
    else
        print_error "curl ou wget não encontrado. Instale um deles para continuar."
        exit 1
    fi

    chmod +x "$dest_path"
    print_success "Script baixado com sucesso"
}

# Install script locally
install_script_local() {
    local script_path=$1
    local dest_dir="$HOME/.local/bin/team-scripts"
    local dest_path="$dest_dir/create-react-project.sh"

    print_info "Instalando script em $dest_path..."

    # Create directory
    mkdir -p "$dest_dir"

    # Copy script
    cp "$script_path" "$dest_path"
    chmod +x "$dest_path"

    print_success "Script instalado com sucesso"
    echo "$dest_path"
}

# Add alias to shell config
add_alias() {
    local config_file=$1
    local alias_name=$2
    local script_path=$3

    print_info "Adicionando alias '$alias_name' ao $config_file..."

    # Create config file if it doesn't exist
    touch "$config_file"

    # Add alias with comment
    cat >> "$config_file" << EOF

# React + TypeScript Project Scaffolding
# Instalado automaticamente em $(date +"%Y-%m-%d %H:%M:%S")
alias $alias_name='bash $script_path'
EOF

    print_success "Alias adicionado com sucesso"
}

# Main installation
main() {
    show_banner

    print_header "Detectando ambiente"

    # Detect shell
    local shell_type=$(detect_shell)
    print_info "Shell detectado: $shell_type"

    if [ "$shell_type" = "unknown" ]; then
        print_error "Não foi possível detectar o shell. Use bash ou zsh."
        exit 1
    fi

    # Get config file
    local config_file=$(get_shell_config "$shell_type")
    print_info "Arquivo de configuração: $config_file"

    # Ask for alias name
    print_header "Configuração do Alias"
    echo -e "${YELLOW}Escolha o nome do alias:${NC}"
    echo "  1) create-react-ts (recomendado)"
    echo "  2) new-react"
    echo "  3) react-init"
    echo "  4) scaffold-react"
    echo "  5) Personalizado"
    echo ""
    read -p "Escolha uma opção [1-5]: " alias_choice

    case "$alias_choice" in
        1)
            alias_name="create-react-ts"
            ;;
        2)
            alias_name="new-react"
            ;;
        3)
            alias_name="react-init"
            ;;
        4)
            alias_name="scaffold-react"
            ;;
        5)
            read -p "Digite o nome do alias: " alias_name
            ;;
        *)
            alias_name="create-react-ts"
            print_warning "Opção inválida. Usando 'create-react-ts' como padrão."
            ;;
    esac

    # Check if alias already exists
    if alias_exists "$config_file" "$alias_name"; then
        print_warning "Alias '$alias_name' já existe em $config_file"
        read -p "Deseja sobrescrever? [s/N]: " overwrite
        if [[ ! "$overwrite" =~ ^[Ss]$ ]]; then
            print_info "Instalação cancelada"
            exit 0
        fi
    fi

    print_header "Instalando Script"

    # Check if script exists locally
    local local_script="./create-react-project.sh"
    local script_path=""

    if [ -f "$local_script" ]; then
        print_info "Script encontrado localmente"
        script_path=$(install_script_local "$local_script")
    else
        # Try assets directory
        local_script="./assets/create-react-project.sh"
        if [ -f "$local_script" ]; then
            print_info "Script encontrado em assets/"
            script_path=$(install_script_local "$local_script")
        else
            print_warning "Script não encontrado localmente"
            read -p "Deseja baixar do repositório GitHub? [S/n]: " download_choice
            if [[ ! "$download_choice" =~ ^[Nn]$ ]]; then
                read -p "Digite a URL do script: " script_url
                local dest_dir="$HOME/.local/bin/team-scripts"
                local dest_path="$dest_dir/create-react-project.sh"
                mkdir -p "$dest_dir"
                download_script "$script_url" "$dest_path"
                script_path="$dest_path"
            else
                print_error "Instalação cancelada"
                exit 1
            fi
        fi
    fi

    # Add alias
    print_header "Configurando Alias"

    if alias_exists "$config_file" "$alias_name"; then
        # Remove existing alias
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' "/alias $alias_name=/d" "$config_file"
        else
            sed -i "/alias $alias_name=/d" "$config_file"
        fi
    fi

    add_alias "$config_file" "$alias_name" "$script_path"

    # Success message
    print_header "Instalação Concluída! 🎉"

    echo -e "${GREEN}Script instalado com sucesso!${NC}\n"
    echo -e "${BLUE}Localização:${NC} $script_path"
    echo -e "${BLUE}Alias:${NC} $alias_name"
    echo -e "${BLUE}Shell:${NC} $shell_type"
    echo ""
    echo -e "${YELLOW}Para começar a usar:${NC}"
    echo ""
    echo -e "  1. Recarregue o shell:"
    if [ "$shell_type" = "bash" ]; then
        echo -e "     ${CYAN}source ~/.bashrc${NC}"
    else
        echo -e "     ${CYAN}source ~/.zshrc${NC}"
    fi
    echo ""
    echo -e "  2. Crie um novo projeto:"
    echo -e "     ${CYAN}$alias_name meu-projeto${NC}"
    echo ""
    echo -e "${GREEN}Pronto para criar projetos React + TypeScript! 🚀${NC}\n"

    # Ask to reload shell
    read -p "Deseja recarregar o shell agora? [S/n]: " reload_choice
    if [[ ! "$reload_choice" =~ ^[Nn]$ ]]; then
        if [ "$shell_type" = "bash" ]; then
            exec bash
        else
            exec zsh
        fi
    fi
}

# Run main
main "$@"
