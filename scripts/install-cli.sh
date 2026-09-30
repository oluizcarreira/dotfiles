#!/bin/bash

# Garante que o script para se houver erro
set -e

# Descobre a raiz do repositório
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "--- Iniciando configuração do ambiente CLI ---"

# 1. Instala utilitários via Homebrew
echo "A instalar ferramentas via Homebrew..."
brew install eza bat

# 2. Instala fontes Meslo Nerd Font completas para o Powerlevel10k
echo "A descarregar Meslo Nerd Font..."
mkdir -p "$HOME/.local/share/fonts"
FONTS_URL="https://github.com/romkatv/powerlevel10k-media/raw/master"
wget -q -nc "$FONTS_URL/MesloLGS%20NF%20Regular.ttf" -P "$HOME/.local/share/fonts/"
wget -q -nc "$FONTS_URL/MesloLGS%20NF%20Bold.ttf" -P "$HOME/.local/share/fonts/"
wget -q -nc "$FONTS_URL/MesloLGS%20NF%20Italic.ttf" -P "$HOME/.local/share/fonts/"
wget -q -nc "$FONTS_URL/MesloLGS%20NF%20Bold%20Italic.ttf" -P "$HOME/.local/share/fonts/"
fc-cache -fv > /dev/null

# 3. Instala o Oh My Zsh (se não existir)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "A instalar Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 4. Função auxiliar para clonar plugins/temas
install_repo() {
    local repo_url=$1
    local dest_dir=$2
    if [ ! -d "$dest_dir" ]; then
        echo "A clonar: $repo_url"
        git clone --depth=1 "$repo_url" "$dest_dir"
    else
        echo "Já existe: $dest_dir"
    fi
}

echo "A configurar temas e plugins do Zsh..."
mkdir -p "$HOME/.oh-my-zsh/custom/plugins"
mkdir -p "$HOME/.oh-my-zsh/custom/themes"

install_repo https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
install_repo https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
install_repo https://github.com/larkery/zsh-histdb "$HOME/.oh-my-zsh/custom/plugins/zsh-histdb"
install_repo https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"

# 5. Ligações simbólicas dinâmicas
echo "A criar links simbólicos a partir de: $DOTFILES_DIR"
ln -sf "$DOTFILES_DIR/home/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/home/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$DOTFILES_DIR/home/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/home/.tool-versions" "$HOME/.tool-versions"

# 6. Instala o gestor de runtimes mise
if ! command -v mise &> /dev/null; then
    echo "A instalar mise..."
    curl https://mise.run | sh
fi

# 7. Configuração da shell padrão
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "A definir Zsh como shell..."
    chsh -s "$(which zsh)" 2>/dev/null || true
fi

echo "--- Ambiente CLI configurado com sucesso! ---"